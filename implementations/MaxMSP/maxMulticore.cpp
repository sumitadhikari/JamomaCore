/* 
 *	MaxMulticore
 *	A thin wrapper of the Lydbaer audio system for use in the Cycling '74 Max/MSP environment.
 *	Includes an automated class wrapper to make TTBlue object's available as objects for Max/MSP.
 *	Copyright © 2008 by Timothy Place
 * 
 * License: This code is licensed under the terms of the GNU LGPL
 * http://www.gnu.org/licenses/lgpl.html 
 */

#include "maxMulticore.h"
#include "ext_hashtab.h"


// Data Structure for this object
typedef struct _wrappedInstance {
    t_object					obj;					///< Max audio object header
	TTMulticoreObjectPtr		multicoreObject;		///< The DSP instance we are wrapping -- MUST BE 2nd!
	TTPtr						multicoreOutlets[16];	///< Array of outlets, may eventually want this to be more dynamic
	TTPtr						inlets[16];				///< Array of proxy inlets beyond the first inlet
	MaxMulticoreWrappedClassPtr	wrappedClassDefinition;	///< A pointer to the class definition
} WrappedInstance;

typedef WrappedInstance* WrappedInstancePtr;		///< Pointer to a wrapped instance of our object.


/** A hash of all wrapped clases, keyed on the Max class name. */
static t_hashtab*	wrappedMaxClasses = NULL;


ObjectPtr MaxMulticoreWrappedClass_new(SymbolPtr name, AtomCount argc, AtomPtr argv)
{	
	MaxMulticoreWrappedClassPtr	wrappedMaxClass = NULL;
    WrappedInstancePtr			self = NULL;
	TTValue						v;
	TTErr						err = kTTErrNone;
	TTUInt8						numInputs = 1;
	TTUInt8						numOutputs = 1;
 	long						attrstart = attr_args_offset(argc, argv);		// support normal arguments
	
	// Find the WrappedClass
	hashtab_lookup(wrappedMaxClasses, name, (ObjectPtr*)&wrappedMaxClass);
	
	// If the WrappedClass has a validity check defined, then call the validity check function.
	// If it returns an error, then we won't instantiate the object.
	if (wrappedMaxClass) {
		if (wrappedMaxClass->validityCheck)
			err = wrappedMaxClass->validityCheck(wrappedMaxClass->validityCheckArgument);
		else
			err = kTTErrNone;
	}
	else
		err = kTTErrGeneric;
	
	if (!err)
		self = (WrappedInstancePtr)object_alloc(wrappedMaxClass->maxClass);
    if (self){

		if (wrappedMaxClass->options && !wrappedMaxClass->options->lookup(TT("argumentDefinesNumInlets"), v)) {
			long argumentOffsetToDefineTheNumberOfInlets = v;
			if ((attrstart-argumentOffsetToDefineTheNumberOfInlets > 0) && argv+argumentOffsetToDefineTheNumberOfInlets)
				numInputs = atom_getlong(argv+argumentOffsetToDefineTheNumberOfInlets);
		}
		for (TTUInt16 i=numInputs-1; i>0; i--)
			self->inlets[i-1] = proxy_new(self, i, NULL);
		
    	object_obex_store((void*)self, _sym_dumpout, (object*)outlet_new(self, NULL));	// dumpout
		if (wrappedMaxClass->options && !wrappedMaxClass->options->lookup(TT("argumentDefinesNumOutlets"), v)) {
			long argumentOffsetToDefineTheNumberOfOutlets = v;
			if ((attrstart-argumentOffsetToDefineTheNumberOfOutlets > 0) && argv+argumentOffsetToDefineTheNumberOfOutlets)
				numOutputs = atom_getlong(argv+argumentOffsetToDefineTheNumberOfOutlets);
		}
		for (TTInt16 i=numOutputs-1; i>=0; i--)
			self->multicoreOutlets[i] = outlet_new(self, "multicore.connect");

		self->wrappedClassDefinition = wrappedMaxClass;
		v.setSize(3);
		v.set(0, wrappedMaxClass->ttClassName);
		v.set(1, numInputs);
		v.set(2, numOutputs);
		err = TTObjectInstantiate(TT("multicore.object"), (TTObjectPtr*)&self->multicoreObject, v);
		if (wrappedMaxClass->options && !wrappedMaxClass->options->lookup(TT("generator"), v))
			self->multicoreObject->addAudioFlag(kTTMulticoreGenerator);
		if (wrappedMaxClass->options && !wrappedMaxClass->options->lookup(TT("nonadapting"), v))
			self->multicoreObject->addAudioFlag(kTTMulticoreNonAdapting);
			
		attr_args_process(self, argc, argv);
	}
	return ObjectPtr(self);
}


void MaxMulticoreWrappedClass_free(WrappedInstancePtr self)
{
	if (self->multicoreObject)
		TTObjectRelease((TTObjectPtr*)&self->multicoreObject);
	// FIXME: leaking proxy inlets!
}



// METHODS SPECIFIC TO MULTICORE EXTERNALS

TTErr MaxMulticoreReset(WrappedInstancePtr self, long vectorSize)
{
	return self->multicoreObject->resetAudio();
}


TTErr MaxMulticoreSetup(WrappedInstancePtr self)
{
	Atom		a[2];
	TTUInt16	i=0;
	
	atom_setobj(a+0, ObjectPtr(self->multicoreObject));
	while (self->multicoreOutlets[i]) {
		atom_setlong(a+1, i);
		outlet_anything(self->multicoreOutlets[i], gensym("multicore.connect"), 2, a);
		i++;
	}
	return kTTErrNone;
}


TTErr MaxMulticoreConnect(ObjectPtr x, TTMulticoreObjectPtr audioSourceObject, TTUInt16 sourceOutletNumber)
{
	WrappedInstancePtr	self = WrappedInstancePtr(x);
	long				inletNumber = proxy_getinlet(SELF);
	
	return self->multicoreObject->connectAudio(audioSourceObject, sourceOutletNumber, inletNumber);
}


TTErr MaxMulticoreDrop(ObjectPtr x, long inletNumber, ObjectPtr sourceMaxObject, long sourceOutletNumber)
{
	WrappedInstancePtr		self = WrappedInstancePtr(x);
	TTMulticoreObjectPtr	sourceObject = NULL;
	TTErr 					err;
	
	err = (TTErr)int(object_method(sourceMaxObject, gensym("multicore.object"), &sourceObject));
	if (self->multicoreObject && sourceObject && !err)
		err = self->multicoreObject->dropAudio(sourceObject, sourceOutletNumber, inletNumber);	
	return err;
}


TTErr MaxMulticoreObject(ObjectPtr x, TTMulticoreObjectPtr* returnedMulticoreObject)
{
	WrappedInstancePtr	self = WrappedInstancePtr(x);

	*returnedMulticoreObject = self->multicoreObject;
	return kTTErrNone;
}


t_max_err MaxMulticoreWrappedClass_attrGet(WrappedInstancePtr self, ObjectPtr attr, AtomCount* argc, AtomPtr* argv)
{
	SymbolPtr	attrName = (SymbolPtr)object_method(attr, _sym_getname);
	TTValue		v;
	AtomCount	i;
	TTSymbolPtr	ttAttrName = NULL;
	MaxErr		err;
	
	err = hashtab_lookup(self->wrappedClassDefinition->maxAttrNamesToTTAttrNames, attrName, (ObjectPtr*)&ttAttrName);
	if (err)
		return err;

	self->multicoreObject->getUnitGenerator()->getAttributeValue(ttAttrName, v);

	*argc = v.getSize();
	if (!(*argv)) // otherwise use memory passed in
		*argv = (t_atom *)sysmem_newptr(sizeof(t_atom) * v.getSize());

	for (i=0; i<v.getSize(); i++) {
		if(v.getType(i) == kTypeFloat32 || v.getType(i) == kTypeFloat64){
			TTFloat64	value;
			v.get(i, value);
			atom_setfloat(*argv+i, value);
		}
		else if(v.getType(i) == kTypeSymbol){
			TTSymbolPtr	value = NULL;
			v.get(i, &value);
			atom_setsym(*argv+i, gensym((char*)value->getCString()));
		}
		else{	// assume int
			TTInt32		value;
			v.get(i, value);
			atom_setlong(*argv+i, value);
		}
	}	
	return MAX_ERR_NONE;
}


t_max_err MaxMulticoreWrappedClass_attrSet(WrappedInstancePtr self, ObjectPtr attr, AtomCount argc, AtomPtr argv)
{
	if (argc && argv) {
		SymbolPtr	attrName = (SymbolPtr)object_method(attr, _sym_getname);
		TTValue		v;
		AtomCount	i;
		TTSymbolPtr	ttAttrName = NULL;
		MaxErr		err;
		
		err = hashtab_lookup(self->wrappedClassDefinition->maxAttrNamesToTTAttrNames, attrName, (ObjectPtr*)&ttAttrName);
		if (err)
			return err;
		
		v.setSize(argc);
		for (i=0; i<argc; i++) {
			if(atom_gettype(argv+i) == A_LONG)
				v.set(i, AtomGetInt(argv+i));
			else if(atom_gettype(argv+i) == A_FLOAT)
				v.set(i, atom_getfloat(argv+i));
			else if(atom_gettype(argv+i) == A_SYM)
				v.set(i, TT(atom_getsym(argv+i)->s_name));
			else
				object_error(SELF, "bad type for attribute setter");
		}
		self->multicoreObject->getUnitGenerator()->setAttributeValue(ttAttrName, v);
		return MAX_ERR_NONE;
	}
	return MAX_ERR_GENERIC;
}


void MaxMulticoreWrappedClass_anything(WrappedInstancePtr self, SymbolPtr s, AtomCount argc, AtomPtr argv)
{
	if (argc && argv) {
		TTValue	v;
		
		v.setSize(argc);
		for (AtomCount i=0; i<argc; i++) {
			if (atom_gettype(argv+i) == A_LONG)
				v.set(i, AtomGetInt(argv+i));
			else if (atom_gettype(argv+i) == A_FLOAT)
				v.set(i, atom_getfloat(argv+i));
			else if (atom_gettype(argv+i) == A_SYM)
				v.set(i, TT(atom_getsym(argv+i)->s_name));
			else
				object_error(SELF, "bad type for message arg");
		}
		self->multicoreObject->getUnitGenerator()->sendMessage(TT(s->s_name), v);
		
		// process the returned value for the dumpout outlet
		{
			AtomCount	ac = v.getSize();

			if (ac) {
				AtomPtr		av = (AtomPtr)malloc(sizeof(Atom) * ac);
				
				for (AtomCount i=0; i<ac; i++) {
					if (v.getType() == kTypeSymbol){
						TTSymbolPtr ttSym = NULL;
						v.get(i, &ttSym);
						atom_setsym(av+i, gensym((char*)ttSym->getCString()));
					}
					else if (v.getType() == kTypeFloat32 || v.getType() == kTypeFloat64) {
						TTFloat64 f = 0.0;
						v.get(i, f);
						atom_setfloat(av+i, f);
					}
					else {
						TTInt32 l = 0;
						v.get(i, l);
						atom_setfloat(av+i, l);
					}
				}
				object_obex_dumpout(self, s, ac, av);
			}
		}
	}
	else
		self->multicoreObject->getUnitGenerator()->sendMessage(TT(s->s_name));
}


// Method for Assistance Messages
void MaxMulticoreWrappedClass_assist(WrappedInstancePtr self, void *b, long msg, long arg, char *dst)
{
	if (msg==1)			// Inlets
		strcpy(dst, "multichannel input and control messages");		
	else if (msg==2) {	// Outlets
		if (arg == 0)
			strcpy(dst, "multichannel output");
		else
			strcpy(dst, "dumpout");
	}
}






TTErr wrapAsMaxMulticore(TTSymbolPtr ttClassName, char* maxClassName, MaxMulticoreWrappedClassPtr* c)
{
	return wrapAsMaxMulticore(ttClassName, maxClassName, c, (MaxMulticoreWrappedClassOptionsPtr)NULL);
}

TTErr wrapAsMaxMulticore(TTSymbolPtr ttClassName, char* maxClassName, MaxMulticoreWrappedClassPtr* c, MaxMulticoreWrappedClassOptionsPtr options)
{
	TTObject*					o = NULL;
	TTValue						v;
	TTUInt16					numChannels = 1;
	MaxMulticoreWrappedClassPtr	wrappedMaxClass = NULL;

	common_symbols_init();
	TTMulticoreInit();
	
	if(!wrappedMaxClasses)
		wrappedMaxClasses = hashtab_new(0);
	
	wrappedMaxClass = new MaxMulticoreWrappedClass;
	wrappedMaxClass->maxClassName = gensym(maxClassName);
	wrappedMaxClass->maxClass = class_new(	maxClassName, 
											(method)MaxMulticoreWrappedClass_new, 
											(method)MaxMulticoreWrappedClass_free, 
											sizeof(WrappedInstance), 
											(method)0L, 
											A_GIMME, 
											0);
	wrappedMaxClass->ttClassName = ttClassName;
	wrappedMaxClass->validityCheck = NULL;
	wrappedMaxClass->validityCheckArgument = NULL;
	wrappedMaxClass->options = options;
	wrappedMaxClass->maxAttrNamesToTTAttrNames = hashtab_new(0);
	
	// Create a temporary instance of the class so that we can query it.
	TTObjectInstantiate(ttClassName, &o, numChannels);

	o->getMessageNames(v);
	for(TTUInt16 i=0; i<v.getSize(); i++){
		TTSymbolPtr			name = NULL;
		
		v.get(i, &name);
		if(name == TT("updateMaxNumChannels") || name == TT("updateSr"))
			continue;	// don't expose these attributes to Max users

		class_addmethod(wrappedMaxClass->maxClass, (method)MaxMulticoreWrappedClass_anything, (char*)name->getCString(), A_GIMME, 0);
	}
	
	o->getAttributeNames(v);
	for (TTUInt16 i=0; i<v.getSize(); i++) {
		TTSymbolPtr		name = NULL;
		TTAttributePtr	attr = NULL;
		SymbolPtr		maxType = _sym_long;
		TTCString		nameCString = NULL;
		SymbolPtr		nameMaxSymbol = NULL;
		TTUInt32		nameSize = 0;
		
		v.get(i, &name);
		if (name == TT("maxNumChannels") || name == TT("processInPlace"))
			continue;	// don't expose these attributes to Max users
		if (name == TT("bypass")) {
			if (wrappedMaxClass->options && !wrappedMaxClass->options->lookup(TT("generator"), v))
				continue;	// generators don't have inputs, and so don't really provide a bypass
		}
		
		o->findAttribute(name, &attr);
		
		if (attr->type == kTypeFloat32)
			maxType = _sym_float32;
		else if (attr->type == kTypeFloat64)
			maxType = _sym_float64;
		else if (attr->type == kTypeSymbol || attr->type == kTypeString)
			maxType = _sym_symbol;
		
		// convert first letter to lower-case if it isn't already
		nameSize = name->getString().length();
		nameCString = new char[nameSize+1];
		strncpy_zero(nameCString, name->getCString(), nameSize+1);
		if (nameCString[0]>64 && nameCString[0]<91)
			nameCString[0] += 32;
		nameMaxSymbol = gensym(nameCString);
		
		hashtab_store(wrappedMaxClass->maxAttrNamesToTTAttrNames, nameMaxSymbol, ObjectPtr(name));
		class_addattr(wrappedMaxClass->maxClass, attr_offset_new(nameCString, maxType, 0, (method)MaxMulticoreWrappedClass_attrGet, (method)MaxMulticoreWrappedClass_attrSet, NULL));
		
		// Add display styles for the Max 5 inspector
		if (attr->type == kTypeBoolean)
			CLASS_ATTR_STYLE(wrappedMaxClass->maxClass, (char*)name->getCString(), 0, "onoff");
		if (name == TT("fontFace"))
			CLASS_ATTR_STYLE(wrappedMaxClass->maxClass,	"fontFace", 0, "font");
	}
	
	TTObjectRelease(&o);
	
	class_addmethod(wrappedMaxClass->maxClass, (method)MaxMulticoreReset,		"multicore.reset",		A_CANT, 0);
	class_addmethod(wrappedMaxClass->maxClass, (method)MaxMulticoreSetup,		"multicore.setup",		A_CANT, 0);
	class_addmethod(wrappedMaxClass->maxClass, (method)MaxMulticoreConnect,		"multicore.connect",	A_OBJ, A_LONG, 0);
	class_addmethod(wrappedMaxClass->maxClass, (method)MaxMulticoreDrop,		"multicore.drop",		A_CANT, 0);
	class_addmethod(wrappedMaxClass->maxClass, (method)MaxMulticoreObject,		"multicore.object",		A_CANT, 0);
    class_addmethod(wrappedMaxClass->maxClass, (method)object_obex_dumpout, 	"dumpout",				A_CANT, 0); 
	class_addmethod(wrappedMaxClass->maxClass, (method)MaxMulticoreWrappedClass_assist, 	"assist",				A_CANT, 0L);
	class_addmethod(wrappedMaxClass->maxClass, (method)stdinletinfo,			"inletinfo",			A_CANT, 0);
	
	class_register(_sym_box, wrappedMaxClass->maxClass);
	if (c)
		*c = wrappedMaxClass;
	
	hashtab_store(wrappedMaxClasses, wrappedMaxClass->maxClassName, ObjectPtr(wrappedMaxClass));
	return kTTErrNone;
}


TTErr wrapAsMaxMulticore(TTSymbolPtr ttClassName, char* maxClassName, MaxMulticoreWrappedClassPtr* c, TTValidityCheckFunction validityCheck)
{
	TTErr err = wrapAsMaxMulticore(ttClassName, maxClassName, c);
	
	if (!err) {
		(*c)->validityCheck = validityCheck;
		(*c)->validityCheckArgument = (*c)->maxClass;
	}
	return err;
}

TTErr wrapAsMaxMulticore(TTSymbolPtr ttClassName, char* maxClassName, MaxMulticoreWrappedClassPtr* c, TTValidityCheckFunction validityCheck, MaxMulticoreWrappedClassOptionsPtr options)
{
	TTErr err = wrapAsMaxMulticore(ttClassName, maxClassName, c, options);
	
	if (!err) {
		(*c)->validityCheck = validityCheck;
		(*c)->validityCheckArgument = (*c)->maxClass;
	}
	return err;
}


TTErr wrapAsMaxMulticore(TTSymbolPtr ttClassName, char* maxClassName, MaxMulticoreWrappedClassPtr* c, TTValidityCheckFunction validityCheck, TTPtr validityCheckArgument)
{
	TTErr err = wrapAsMaxMulticore(ttClassName, maxClassName, c);
	
	if (!err) {
		(*c)->validityCheck = validityCheck;
		(*c)->validityCheckArgument = validityCheckArgument;
	}
	return err;
}

TTErr wrapAsMaxMulticore(TTSymbolPtr ttClassName, char* maxClassName, MaxMulticoreWrappedClassPtr* c, TTValidityCheckFunction validityCheck, TTPtr validityCheckArgument, MaxMulticoreWrappedClassOptionsPtr options)
{
	TTErr err = wrapAsMaxMulticore(ttClassName, maxClassName, c, options);
	
	if (!err) {
		(*c)->validityCheck = validityCheck;
		(*c)->validityCheckArgument = validityCheckArgument;
	}
	return err;
}
