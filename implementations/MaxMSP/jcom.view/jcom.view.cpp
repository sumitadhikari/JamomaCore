/* 
 *	jcom.view
 *	External object
 *	Copyright © 2010 by Théo de la Hogue
 * 
 * License: This code is licensed under the terms of the GNU LGPL
 * http://www.gnu.org/licenses/lgpl.html 
 */

#include "TTModularClassWrapperMax.h"

// those stuffes are needed for handling patchers without using the pcontrol object
#include "jpatcher_api.h"
typedef struct dll {
	t_object d_ob;
	struct dll *d_next;
	struct dll *d_prev;
	void *d_x1;
} t_dll;

typedef struct outlet {
	struct tinyobject o_ob;
	struct dll *o_dll;
} t_outlet;

// This is used to store extra data
typedef struct extra {
	TTSymbolPtr address;		// the first arg address
	ObjectPtr	connected;		// our ui object
	AtomPtr		bgcolor;		// our ui object bgcolor
	long		x;				// our ui object x presentation
	long		y;				// our ui object y presentation
	long		w;				// our ui object width presentation
	long		h;				// our ui object heigth presentation
	TTBoolean	sensible;		// is the ui object is mouse sensible (comment and panel are not)
	TTBoolean	hover;			// is the mouse hover a none sensible object ?
} t_extra;
#define EXTRA ((t_extra*)x->extra)

#define set_out 0
#define select_out 1
#define	dump_out 2

// Definitions
void	WrapTTViewerClass(WrappedClassPtr c);
void	WrappedViewerClass_new(TTPtr self, AtomCount argc, AtomPtr argv);
void	WrappedViewerClass_free(TTPtr self);
void	WrappedViewerClass_anything(TTPtr self, SymbolPtr msg, AtomCount argc, AtomPtr argv);
t_max_err WrappedViewerClass_notify(TTPtr self, t_symbol *s, t_symbol *msg, void *sender, void *data);

void	view_assist(TTPtr self, void *b, long msg, long arg, char *dst);

void	view_return_value(TTPtr self, SymbolPtr msg, AtomCount argc, AtomPtr argv);
void	view_return_model_address(TTPtr self, SymbolPtr msg, AtomCount argc, AtomPtr argv);

void	view_bang(TTPtr self);
void	view_int(TTPtr self, long value);
void	view_float(TTPtr self, double value);
void	view_list(TTPtr self, SymbolPtr msg, AtomCount argc, AtomPtr argv);

void	view_attach(TTPtr self);
void 	view_mousemove(TTPtr self, t_object *patcherview, t_pt pt, long modifiers);
void	view_mouseleave(TTPtr self, t_object *patcherview, t_pt pt, long modifiers);

void	view_build(TTPtr self, SymbolPtr address);

void	view_ui_queuefn(TTPtr self);

int TTCLASSWRAPPERMAX_EXPORT main(void)
{
	ModularSpec *spec = new ModularSpec;
	spec->_wrap = &WrapTTViewerClass;
	spec->_new = &WrappedViewerClass_new;
	spec->_free = &WrappedViewerClass_free;
	spec->_any = &WrappedViewerClass_anything;
	spec->_notify = &WrappedViewerClass_notify;
	
	return wrapTTModularClassAsMaxClass(TT("Viewer"), "jcom.view", NULL, spec);
}

void WrapTTViewerClass(WrappedClassPtr c)
{
	class_addmethod(c->maxClass, (method)view_assist,				"assist",				A_CANT, 0L);
	
	class_addmethod(c->maxClass, (method)view_mousemove,			"mousemove",			A_CANT, 0);
	class_addmethod(c->maxClass, (method)view_mouseleave,			"mouseleave",			A_CANT, 0);
	
	class_addmethod(c->maxClass, (method)view_return_value,			"return_value",			A_CANT, 0);
	class_addmethod(c->maxClass, (method)view_return_model_address,	"return_model_address",	A_CANT, 0);
	
	class_addmethod(c->maxClass, (method)view_bang,					"bang",					0L);
	class_addmethod(c->maxClass, (method)view_int,					"int",					A_LONG, 0L);
	class_addmethod(c->maxClass, (method)view_float,				"float",				A_FLOAT, 0L);
	class_addmethod(c->maxClass, (method)view_list,					"list",					A_GIMME, 0L);
}

void WrappedViewerClass_new(TTPtr self, AtomCount argc, AtomPtr argv)
{
	WrappedModularInstancePtr	x = (WrappedModularInstancePtr)self;
	SymbolPtr					address;
 	long						attrstart = attr_args_offset(argc, argv);			// support normal arguments
	
	// A Modular object needs an address argument : atom_getsym(argv) or _sym_nothing by default
	if (attrstart && argv) 
		address = atom_getsym(argv);
	else
		address = _sym_nothing;
	
	// Prepare extra data
	x->extra = (t_extra*)malloc(sizeof(t_extra));
	EXTRA->connected = NULL;
	EXTRA->address = TT(address->s_name);
	
	jamoma_viewer_create((ObjectPtr)x, &x->wrappedObject);
	
	// Prepare memory to store internal objects
	x->internals = new TTHash();
	
	// The following must be deferred because we have to interrogate our box,
	// and our box is not yet valid until we have finished instantiating the object.
	// Trying to use a loadbang method instead is also not fully successful (as of Max 5.0.6)
	defer_low((ObjectPtr)x, (method)view_build, address, 0, 0);
	
	// Make two outlets
	x->outlets = (TTHandle)sysmem_newptr(sizeof(TTPtr) * 1);
	x->outlets[select_out] = outlet_new(x, NULL);					// anything outlet to select ui
	x->outlets[set_out] = outlet_new(x, NULL);						// anything outlet to output data
	
	// Make qelem object
	x->ui_qelem = qelem_new(x, (method)view_ui_queuefn);
	
	// handle attribute args
	attr_args_process(x, argc, argv);
}

// Method for Assistance Messages
void view_assist(TTPtr self, void *b, long msg, long arg, char *dst)
{
	if (msg==1) 						// Inlet
		strcpy(dst, "input");
	else {								// Outlets
		switch(arg) {
			case set_out:
				strcpy(dst, "set: connect to ui object");
				break;
			case dump_out:
				strcpy(dst, "dumpout");
				break;
		}
 	}
}

void WrappedViewerClass_free(TTPtr self)
{
	WrappedModularInstancePtr	x = (WrappedModularInstancePtr)self;
	free(EXTRA);
}

t_max_err WrappedViewerClass_notify(TTPtr self, t_symbol *s, t_symbol *msg, void *sender, void *data)
{
	WrappedModularInstancePtr	x = (WrappedModularInstancePtr)self;
	// DEBUG
	//object_post((ObjectPtr)x, "notify %s", msg->s_name);
	
	return MAX_ERR_NONE;
}

void view_build(TTPtr self, SymbolPtr address)
{
	WrappedModularInstancePtr	x = (WrappedModularInstancePtr)self;
	TTValue						v, args;
	TTNodePtr					node = NULL;
	TTBoolean					newInstance;
	TTSymbolPtr					nodeAddress, relativeAddress, contextAddress;
	TTObjectPtr					anObject;

	jamoma_patcher_type_and_class((ObjectPtr)x, &x->patcherType, &x->patcherClass);
	jamoma_subscriber_create((ObjectPtr)x, x->wrappedObject, jamoma_parse_dieze((ObjectPtr)x, address), x->patcherType, &x->subscriberObject);
	
	// if the subscription is successful
	if (x->subscriberObject) {
		
		// Is a new instance have been created ?
		x->subscriberObject->getAttributeValue(TT("newInstanceCreated"), v);
		v.get(0, newInstance);
		
		if (newInstance) {
			x->subscriberObject->getAttributeValue(TT("relativeAddress"), v);
			v.get(0, &relativeAddress);
			object_warn((t_object*)x, "Jamoma cannot create multiple jcom.view with the same OSC identifier (%s).  Using %s instead.", jamoma_parse_dieze((ObjectPtr)x, address)->s_name, relativeAddress->getCString());
		}
		
		// debug
		x->subscriberObject->getAttributeValue(TT("nodeAddress"), v);
		v.get(0, &nodeAddress);
		object_post((ObjectPtr)x, "address = %s", nodeAddress->getCString());
		
		// get the context address
		// and make a viewer on contextAddress/model/address parameter
		x->subscriberObject->getAttributeValue(TT("contextAddress"), v);
		v.get(0, &contextAddress);
		makeInternals_viewer(x, contextAddress, TT("/model/address"), gensym("return_model_address"), &anObject);
		anObject->sendMessage(kTTSym_Refresh);
		
		// get the Node
		x->subscriberObject->getAttributeValue(TT("node"), v);
		v.get(0, (TTPtr*)&node);
		
		// attach the jcom.view to connected ui object
		view_attach(self);
	}
}

void view_return_value(TTPtr self, SymbolPtr msg, AtomCount argc, AtomPtr argv)
{
	WrappedModularInstancePtr	x = (WrappedModularInstancePtr)self;
	TTValue		v;
	//TTBoolean	freeze;
	TTUInt8		i;
	
	/*
	// TODO : Check viewFreeze attribute
	x->wrappedObject->getAttributeValue(kTTSym_viewFreeze, v);
	v.get(0, freeze);
	
	if (!freeze) {
	*/
	
		// Copy atom in order to avoid losing data
		x->argc = argc;
		x->argv = NULL;
		x->argv = (AtomPtr)sysmem_newptr(sizeof(t_atom) * argc);
		
		if (argc) {
			for (i=0; i<argc; i++) {
				x->argv[i] = argv[i];
			}
		}
		
		qelem_set(x->ui_qelem);
	//}
}

void view_ui_queuefn(TTPtr self)
{
	WrappedModularInstancePtr	x = (WrappedModularInstancePtr)self;
	outlet_anything(x->outlets[set_out], _sym_set, x->argc, x->argv);
}

void view_bang(TTPtr self)
{
	view_list(self, _sym_bang, 0, NULL);
}

void view_int(TTPtr self, long value)
{
	t_atom a;
	
	atom_setlong(&a, value);
	view_list(self, _sym_int, 1, &a);
}

void view_float(TTPtr self, double value)
{
	t_atom a;
	
	atom_setfloat(&a, value);
	view_list(self, _sym_float, 1, &a);
}

void view_list(TTPtr self, SymbolPtr msg, AtomCount argc, AtomPtr argv)
{
	WrappedModularInstancePtr	x = (WrappedModularInstancePtr)self;
	TTValue		v;
	
	jamoma_ttvalue_from_Atom(v, msg, argc, argv);
	
	x->wrappedObject->sendMessage(kTTSym_Send, v);
}

void WrappedViewerClass_anything(TTPtr self, SymbolPtr msg, AtomCount argc, AtomPtr argv)
{
	WrappedModularInstancePtr	x = (WrappedModularInstancePtr)self;
	TTValue		v;
	
	jamoma_ttvalue_from_Atom(v, msg, argc, argv);
	
	x->wrappedObject->sendMessage(kTTSym_Send, v);
}

void view_return_model_address(TTPtr self, SymbolPtr msg, AtomCount argc, AtomPtr argv)
{
	WrappedModularInstancePtr	x = (WrappedModularInstancePtr)self;
	TTSymbolPtr address;
	
	if (argc)
		if (atom_gettype(argv) == A_SYM) {
			
			// set address attribute of the wrapped Viewer object
			joinOSCAddress(TT(atom_getsym(argv)->s_name), EXTRA->address, &address);
			x->wrappedObject->setAttributeValue(kTTSym_address, address);
		}
}

void view_attach(TTPtr self)
{
	WrappedModularInstancePtr	x = (WrappedModularInstancePtr)self;
	ObjectPtr	box;
	t_outlet*	myoutlet = NULL;
	t_dll*		connecteds = NULL;
	ObjectPtr	o;
	TTValue		v;
	AtomCount	ac;
	AtomPtr		av;
	
	// get the first object connected to the select_out
	object_obex_lookup(x, _sym_pound_B, &box);
	
	myoutlet = (t_outlet*)jbox_getoutlet((t_jbox*)box, select_out);
	if (myoutlet)
		connecteds = (t_dll*)myoutlet->o_dll;
	
	if (connecteds) {
		o = (t_object*)connecteds->d_x1;

		if (EXTRA->connected = o) {

			ac = 0;
			EXTRA->bgcolor = NULL;
			object_attr_getvalueof(EXTRA->connected, _sym_bgcolor, &ac, (AtomPtr*)&EXTRA->bgcolor);
			
			ac = 0;
			av = NULL;
			object_attr_getvalueof(EXTRA->connected, _sym_presentation_rect , &ac, &av);
			if (ac && av) {
				EXTRA->x = atom_getlong(av+0);
				EXTRA->y = atom_getlong(av+1);
				EXTRA->w = atom_getlong(av+2);
				EXTRA->h = atom_getlong(av+3);
			}
			
			EXTRA->sensible = !(	object_classname(EXTRA->connected) == gensym("comment") 
								||	object_classname(EXTRA->connected) == gensym("panel"));
		}
	}
}

// When the mouse is moving on the jcom.ui (not our view !)
void view_mousemove(TTPtr self, t_object *patcherview, t_pt pt, long modifiers)
{
	WrappedModularInstancePtr	x = (WrappedModularInstancePtr)self;
	TTValue		v;
	TTBoolean	selected;
	Atom		selected_color[4];
	long		around = 2; //offset to select our object easily
	
	if (EXTRA->connected) {
		
		// if the control key is pressed
		if (modifiers & eControlKey) {
			
			// Special case for none mouse sensible ui object
			if (!EXTRA->sensible) {
				if (pt.x > EXTRA->x-around && pt.x < EXTRA->x+EXTRA->w+around && pt.y > EXTRA->y-around && pt.y < EXTRA->y+EXTRA->h+around) {
					if (!EXTRA->hover) {
						EXTRA->hover = true;
						view_mouseleave(self, patcherview, pt, modifiers);
					}
				}
				else
					if (EXTRA->hover)
						EXTRA->hover = false;
			}
			
			// display selected attribute by changing background color if selected
			x->wrappedObject->getAttributeValue(TT("selected"), v);
			v.get(0, selected);
				
			if (selected) {
				
				atom_setfloat(&selected_color[0], 0.62);
				atom_setfloat(&selected_color[1], 0.);
				atom_setfloat(&selected_color[2], 0.36);
				atom_setfloat(&selected_color[3], 0.70);
				
				object_attr_setvalueof(EXTRA->connected, _sym_bgcolor, 4, selected_color);
			}
			else
				object_attr_setvalueof(EXTRA->connected, _sym_bgcolor, 4, (AtomPtr)EXTRA->bgcolor);
		}
		// else set default color
		// TODO : do this only one time !!!
		else
			object_attr_setvalueof(EXTRA->connected, _sym_bgcolor, 4, (AtomPtr)EXTRA->bgcolor);
	}
}

// When the mouse is leaving on the jcom.ui (not our view !)
void view_mouseleave(TTPtr self, t_object *patcherview, t_pt pt, long modifiers)
{
	WrappedModularInstancePtr	x = (WrappedModularInstancePtr)self;
	TTValue		v;
	TTBoolean	selected;
	Atom		selected_color[4];
	long		around = 2; //offset to select our object easily
	
	if (EXTRA->connected) {
		
		// if the control key is pressed
		if (modifiers & eControlKey) {
			
			// if mouse leave jcom.ui maybe it is on our object
			if (pt.x > EXTRA->x-around && pt.x < EXTRA->x+EXTRA->w+around && pt.y > EXTRA->y-around && pt.y < EXTRA->y+EXTRA->h+around) {
				
				// DEBUG
				object_post((ObjectPtr)x, "mouse on %s", object_classname(EXTRA->connected)->s_name);
				
				x->wrappedObject->getAttributeValue(TT("selected"), v);
				v.get(0, selected);
				
				// reverse selected attribute and change background color
				if (selected) {
					x->wrappedObject->setAttributeValue(TT("selected"), NO);
					object_attr_setvalueof(EXTRA->connected, _sym_bgcolor, 4, (AtomPtr)EXTRA->bgcolor);
				}
				else {
					x->wrappedObject->setAttributeValue(TT("selected"), YES);
					
					atom_setfloat(&selected_color[0], 0.62);
					atom_setfloat(&selected_color[1], 0.);
					atom_setfloat(&selected_color[2], 0.36);
					atom_setfloat(&selected_color[3], 0.70);
					
					object_attr_setvalueof(EXTRA->connected, _sym_bgcolor, 4, selected_color);
				}
			}
		}
		// else set default color
		// TODO : do this only one time !!!
		else
			object_attr_setvalueof(EXTRA->connected, _sym_bgcolor, 4, (AtomPtr)EXTRA->bgcolor);
	}
}