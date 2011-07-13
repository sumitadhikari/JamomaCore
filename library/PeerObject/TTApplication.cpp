/* 
 * TTObject to handle application data structure
 * like a TTNodeDirectory and a hash tables of names
 *
 * Copyright © 2010, Théo de la Hogue
 * 
 * License: This code is licensed under the terms of the "New BSD License"
 * http://creativecommons.org/licenses/BSD/
 */

#include "TTApplication.h"

#define thisTTClass			TTApplication
#define thisTTClassName		"Application"
#define thisTTClassTags		"application"

TT_MODULAR_CONSTRUCTOR,
mDirectory(NULL),
mName(kTTSymEmpty),
mVersion(kTTSymEmpty),
mNamespaceFile(kTTSymEmpty),
mPluginParameters(NULL),
mDirectoryListenersCache(NULL),
mAttributeListenersCache(NULL),
mAppToTT(NULL),
mTTToApp(NULL),
mTempAddress(kTTAdrsEmpty)
{
	arguments.get(0, &mName);
	arguments.get(1, &mVersion);
	
	addAttributeWithSetter(Name, kTypeSymbol);
	
	addAttribute(Version, kTypeSymbol);
	addAttributeProperty(version, readOnly, YES);
	
	addAttribute(NamespaceFile, kTypeSymbol);
	addAttributeProperty(namespaceFile, readOnly, YES);
	
	addAttribute(Directory, kTypePointer);
	addAttributeProperty(directory, readOnly, YES);
	
	addAttributeWithSetter(PluginParameters, kTypePointer);
	
	addAttributeWithGetter(PluginNames, kTypeLocalValue);
	addAttributeProperty(pluginNames, readOnly, YES);
	
	addMessageWithArgument(Configure);

	addAttributeWithGetter(AllAppNames, kTypeLocalValue);
	addAttributeProperty(allAppNames, readOnly, YES);
	
	addAttributeWithGetter(AllTTNames, kTypeLocalValue);
	addAttributeProperty(allTTNames, readOnly, YES);
	
	addMessageWithArgument(AddDirectoryListener);
	addMessageWithArgument(AddAttributeListener);
	
	addMessageWithArgument(RemoveDirectoryListener);
	addMessageWithArgument(RemoveAttributeListener);
	
	addMessageWithArgument(UpdateDirectory);
	addMessageWithArgument(UpdateAttribute);
	
	addMessageWithArgument(ConvertToAppName);
	addMessageWithArgument(ConvertToTTName);
	
	// needed to be handled by a TTXmlHandler
	addMessageWithArgument(WriteAsXml);
	addMessageProperty(WriteAsXml, hidden, YES);
	
	addMessageWithArgument(ReadFromXml);
	addMessageProperty(ReadFromXml, hidden, YES);
	
	addMessageWithArgument(ReadFromOpml);
	addMessageProperty(ReadFromOpml, hidden, YES);
	
	mDirectory = new TTNodeDirectory(mName);
	TT_ASSERT("NodeDirectory created successfully", mDirectory != NULL);
	
	mAppToTT = new TTHash();
	mTTToApp = new TTHash();
	
	mPluginParameters = new TTHash();
	
	mDirectoryListenersCache = new TTHash();
	mAttributeListenersCache = new TTHash();
}

TTApplication::~TTApplication()
{
	TTHashPtr		oldParameters;
	TTValue			hk, v;
	TTSymbolPtr		key;
	TTUInt8			i;
	
	// delete PluginParameters
	mPluginParameters->getKeys(hk);
	for (i=0; i<mPluginParameters->getSize(); i++) {
		hk.get(i, &key);
		mPluginParameters->lookup(key, v);
		v.get(0, (TTPtr*)&oldParameters);
		
		delete oldParameters;
	}
	delete mPluginParameters;
	
	// TODO : delete observers
	
	delete mDirectory;
	
	delete mTTToApp;
	delete mAppToTT;
}

TTErr TTApplication::setName(TTValue& value)
{
	mName = value;
	return mDirectory->setName(mName);
}

TTErr TTApplication::getPluginNames(TTValue& value)
{
	return mPluginParameters->getKeys(value);
}

TTErr TTApplication::setPluginParameters(const TTValue& value)
{
	TTValue			hk, v;
	TTSymbolPtr		pluginName;
	TTHashPtr		parameters;
	TTUInt8			i;
	
	value.get(0, (TTPtr*)mPluginParameters);
	
	// for all plugins used by the application
	mPluginParameters->getKeys(hk);
	for (i=0; i<mPluginParameters->getSize(); i++) {
		hk.get(i, &pluginName);
		mPluginParameters->lookup(pluginName, v);
		v.get(0, (TTPtr*)&parameters);
		
		// if local application : reset plugin reception parameters
		if (mName == kTTSym_localApplicationName) {
			v = TTValue((TTPtr)parameters);
			getPlugin(pluginName)->setAttributeValue(TT("parameters"), v);
		}
	}
	
	return kTTErrNone;
}

TTErr TTApplication::getAllAppNames(TTValue& value)
{	
	if (mAppToTT->isEmpty())
		value = kTTSymEmpty;
	else
		mAppToTT->getKeys(value);
	
	return kTTErrNone;
}

TTErr TTApplication::getAllTTNames(TTValue& value)
{	
	if (mTTToApp->isEmpty())
		value = kTTSymEmpty;
	else
		mTTToApp->getKeys(value);
	
	return kTTErrNone;
}

TTErr TTApplication::Configure(const TTValue& value)
{
	TTPluginHandlerPtr	aPlugin;
	TTSymbolPtr			pluginName, parameterName;
	TTHashPtr			parameters;
	TTValue				v;
	TTErr				err;
	
	if (value.getSize() > 2) {
		value.get(0, &pluginName);
		value.get(1, &parameterName);
		
		err = mPluginParameters->lookup(pluginName, v);
		
		if (!err) {
			v.get(0, (TTPtr*)&parameters);
			
			err = parameters->lookup(parameterName, v);
			
			if (!err) {
				
				parameters->remove(parameterName);
				
				v.clear();
				v.copyFrom(value, 2);
				
				err = parameters->append(parameterName, v);
				
				// if local application : set plugin reception parameters
				// else : do nothing for distant application
				if (!err && mName == kTTSym_localApplicationName) {
					if (aPlugin = getPlugin(pluginName)) {
						v = TTValue((TTPtr)parameters);
						aPlugin->setAttributeValue(TT("parameters"), v);
					}
				}
			
				return err;
			}
		}
		// prepare an empty parameters table for this plugin
		// and then retry configuration
		else {
			if (aPlugin = getPlugin(pluginName)) {
				
				aPlugin->getAttributeValue(TT("parameterNames"), v);
				
				parameters = new TTHash();
				for (TTInt32 i=0; i<v.getSize(); i++) {
					v.get(i, &parameterName);
					parameters->append(parameterName, kTTValNONE);
				}
				
				// append a new entry
				v = TTValue((TTPtr)parameters);
				mPluginParameters->append(pluginName, v);
				
				// update plugin names member
				mPluginParameters->getKeys(mPluginNames);
				
				Configure(value);
			}
		}
	}
	
	return kTTErrGeneric;
}

TTErr TTApplication::ConvertToAppName(TTValue& value)
{
	TTValue				c;
	TTSymbolPtr			ttName;
	TTSymbolPtr			appName;
	
	// if there is only 1 symbol : replace value directly by the founded one.
	// because it's possible to have conversion containing several appNames for 1 ttname
	if (value.getSize() == 1) 
		if (value.getType(0) == kTypeSymbol){
			value.get(0, &ttName);
			if (!this->mTTToApp->lookup(ttName, c))
				value = c;
			return kTTErrNone;
		}
	
	// else convert each symbol of the value.
	// !!! in this case 1 to many conversion is not handled
	for (TTUInt8 i=0; i<value.getSize(); i++)
		if (value.getType(i) == kTypeSymbol) {
			value.get(i, &ttName);
			if (!this->mTTToApp->lookup(ttName, c)) {
				c.get(0, &appName);
				value.set(i, appName);
			}
		}
	
	return kTTErrNone;
}

TTErr TTApplication::ConvertToTTName(TTValue& value)
{
	TTValue				c;
	TTSymbolPtr			appName;
	TTSymbolPtr			ttName;
	
	// if there is only 1 symbol : replace value directly by the founded one.
	// because it's possible to have conversion containing several ttNames for 1 appName
	if (value.getSize() == 1) 
		if (value.getType(0) == kTypeSymbol){
			value.get(0, &appName);
			if (!this->mAppToTT->lookup(appName, c))
				value = c;
			return kTTErrNone;
		}
	
	// else convert each symbol of the value.
	// !!! in this case 1 to many conversion is not handled
	for (TTUInt8 i=0; i<value.getSize(); i++)
		if (value.getType(i) == kTypeSymbol) {
			value.get(i, &appName);
			if (!this->mAppToTT->lookup(appName, c)) {
				c.get(0, &ttName);
				value.set(i, ttName);
			}
		}
	
	return kTTErrNone;
}

TTErr TTApplication::AddDirectoryListener(const TTValue& value)
{
	TTNodeAddressPtr	whereToListen;
	TTObjectPtr			returnValueCallback;
	TTValuePtr			returnValueBaton;
	TTValue				cacheElement;
	TTErr				err;
	
	value.get(2, &whereToListen);
	
	// prepare a callback based on TTApplicationAttributeCallback
	returnValueCallback = NULL;			// without this, TTObjectInstantiate try to release an oldObject that doesn't exist ... Is it good ?
	TTObjectInstantiate(TT("callback"), &returnValueCallback, kTTValNONE);
	
	returnValueBaton = new TTValue();
	*returnValueBaton = value;
	
	returnValueCallback->setAttributeValue(kTTSym_baton, TTPtr(returnValueBaton));
	returnValueCallback->setAttributeValue(kTTSym_function, TTPtr(&TTPluginHandlerDirectoryCallback));
	
	err = mDirectory->addObserverForNotifications(whereToListen, *returnValueCallback);
	
	if (!err) {
		
		// cache the observer in the directoryListenersCache
		cacheElement.append((TTPtr)returnValueCallback);
		mDirectoryListenersCache->append(whereToListen, cacheElement); // TODO : have many observers for the same address ? (add plugin info ?)
		
		return kTTErrNone;
	}
	else
		; // TODO : observe the directory in order to add the listener later
	
	return kTTErrGeneric;
}

TTErr TTApplication::RemoveDirectoryListener(const TTValue& value)
{
	TTNodeAddressPtr	whereToListen;
	TTObjectPtr			returnValueCallback;
	TTValue				cacheElement;
	TTErr				err;
	
	value.get(0, &whereToListen);
	
	// get the observer in the directoryListenersCache
	err = mDirectoryListenersCache->lookup(whereToListen, cacheElement);
	
	if (!err) {
		cacheElement.get(0, (TTPtr*)&returnValueCallback);
		mDirectory->removeObserverForNotifications(whereToListen, *returnValueCallback);
		TTObjectRelease(TTObjectHandle(&returnValueCallback));
		return kTTErrNone;
	}
	
	return kTTErrGeneric;
}

TTErr TTApplication::AddAttributeListener(const TTValue& value)
{
	TTNodeAddressPtr	whereToListen;
	TTList				aNodeList;
	TTNodePtr			nodeToListen;
	TTObjectPtr			anObject, returnValueCallback;
	TTAttributePtr		anAttribute;
	TTValuePtr			returnValueBaton;
	TTValue				cacheElement;
	TTErr				err;
	
	value.get(2, &whereToListen);
	
	err = mDirectory->Lookup(whereToListen, aNodeList, &nodeToListen);
	
	if (!err) {
		
		for (aNodeList.begin(); aNodeList.end(); aNodeList.next())
		{
			// get a node from the selection
			aNodeList.current().get(0,(TTPtr*)&nodeToListen);
			
			if (anObject = nodeToListen->getObject()) {
				
				// create an Attribute observer 
				anAttribute = NULL;
				err = anObject->findAttribute(whereToListen->getAttribute(), &anAttribute);
				
				if (!err) {
					// prepare a callback based on TTApplicationAttributeCallback
					returnValueCallback = NULL;			// without this, TTObjectInstantiate try to release an oldObject that doesn't exist ... Is it good ?
					TTObjectInstantiate(TT("callback"), &returnValueCallback, kTTValNONE);
					
					returnValueBaton = new TTValue();
					*returnValueBaton = value;
					
					returnValueCallback->setAttributeValue(kTTSym_baton, TTPtr(returnValueBaton));
					returnValueCallback->setAttributeValue(kTTSym_function, TTPtr(&TTPluginHandlerAttributeCallback));
					
					anAttribute->registerObserverForNotifications(*returnValueCallback);
					
					// cache the listener in the attributeListenersCache
					cacheElement.append((TTPtr)returnValueCallback);
					mAttributeListenersCache->append(whereToListen, cacheElement); // TODO : have many observers for the same address:attribute ? (add plugin info ?)
					
					return kTTErrNone;
				}
			}
		}
	}
	else
		; // TODO : observe the directory in order to add the listener later
	
	return kTTErrGeneric;
}

TTErr TTApplication::RemoveAttributeListener(const TTValue& value)
{
	TTNodeAddressPtr	whereToListen;
	TTList				aNodeList;
	TTNodePtr			nodeToListen;
	TTObjectPtr			anObject, returnValueCallback;
	TTAttributePtr		anAttribute;
	TTValue				cacheElement;
	TTErr				err;
	
	value.get(0, &whereToListen);
	
	err = mDirectory->Lookup(whereToListen, aNodeList, &nodeToListen);
	
	if (!err) {
		
		for (aNodeList.begin(); aNodeList.end(); aNodeList.next())
		{
			// get a node from the selection
			aNodeList.current().get(0,(TTPtr*)&nodeToListen);
			
			if (anObject = nodeToListen->getObject()) {
				
				// delete Attribute observer 
				anAttribute = NULL;
				err = anObject->findAttribute(whereToListen->getAttribute(), &anAttribute);
				
				if (!err) {
					
					err = mAttributeListenersCache->lookup(whereToListen, cacheElement);
					
					if (!err) {
						cacheElement.get(0, (TTPtr*)&returnValueCallback);
						anAttribute->unregisterObserverForNotifications(*returnValueCallback);
						TTObjectRelease(TTObjectHandle(&returnValueCallback));
						return kTTErrNone;
					}
				}
			}
		}
	}

	return kTTErrGeneric;
}

TTErr TTApplication::UpdateDirectory(const TTValue& value)
{
	TTNodeAddressPtr	whereComesFrom;
	TTValuePtr			newValue;
	TTBoolean			enable;
	
	value.get(0, &whereComesFrom);
	value.get(1, (TTPtr*)&newValue);
	
	newValue->get(0, enable);
	
	if (enable) {
		// TODO : create Mirror object and register it
		;//mDirectory->TTNodeCreate(whereComesFrom, ...
		
	}
	else {
		;// TODO : unregister the address and destroy the Mirror object
	}
	
	return kTTErrGeneric;
}

TTErr TTApplication::UpdateAttribute(const TTValue& value)
{
	TTNodePtr			nodeToUpdate;
	TTNodeAddressPtr	whereComesFrom;
	TTValuePtr			newValue;
	TTMirrorPtr			aMirror;
	TTErr				err;
	
	value.get(0, &whereComesFrom);
	value.get(1, (TTPtr*)&newValue);
	
	err = mDirectory->getTTNode(whereComesFrom, &nodeToUpdate);
	
	if (!err)
		if (aMirror = (TTMirrorPtr)nodeToUpdate->getObject())
			if (aMirror->getName() == TT("Mirror"))
				return aMirror->updateAttributeValue(whereComesFrom->getAttribute(), *newValue);
	
	return kTTErrGeneric;
}

TTErr TTApplication::WriteAsXml(const TTValue& value)
{
	TTXmlHandlerPtr		aXmlHandler;
	TTSymbolPtr			pluginName, parameterName;
	TTString			aString;
	TTHashPtr			parameters;
    TTValue				keys, p_keys, v;
	
	value.get(0, (TTPtr*)&aXmlHandler);
	
	// For each plugin
	mPluginParameters->getKeys(keys);
	for (TTUInt16 i=0; i<keys.getSize(); i++) {
		
		keys.get(i, &pluginName);
		mPluginParameters->lookup(pluginName, v);
		v.get(0, (TTPtr*)&parameters);
		
		// Start "plugin" xml node
		xmlTextWriterStartElement(aXmlHandler->mWriter, BAD_CAST "plugin");
		xmlTextWriterWriteFormatAttribute(aXmlHandler->mWriter, BAD_CAST "name", "%s", BAD_CAST pluginName->getCString());
		
		// For each parameter
		parameters->getKeys(p_keys);
		for (TTUInt16 j=0; j<p_keys.getSize(); j++) {
			p_keys.get(j, &parameterName);
			parameters->lookup(parameterName, v);
			v.toString();
			v.get(0, aString);
			xmlTextWriterWriteFormatAttribute(aXmlHandler->mWriter, BAD_CAST parameterName->getCString(), "%s", BAD_CAST aString.data());
		}
		
		// End "plugin" xml node
		xmlTextWriterEndElement(aXmlHandler->mWriter);
	}
	
	
	/* to -- do we need to write the Application name table ?
	 TTSymbolPtr			k;
	 TTString			aString;
	 TTValue				v, keys;
	 TTUInt16			i;
	 
	 // Write ApplicationNames table
	 xmlTextWriterWriteComment(aXmlHandler->mWriter, BAD_CAST "Conversion table");
	 xmlTextWriterStartElement(aXmlHandler->mWriter, BAD_CAST "conversionTable");
	 
	 mAppToTT->getKeys(keys);
	 for (i = 0; i < keys.getSize(); i++) {
	 
	 keys.get(i, &k);
	 mAppToTT->lookup(k, v);
	 
	 // Don't write kTTValNONE
	 if (v == kTTValNONE)
	 continue;
	 
	 v.toString();
	 v.get(0, aString);
	 
	 xmlTextWriterStartElement(aXmlHandler->mWriter, BAD_CAST "entry");
	 xmlTextWriterWriteAttribute(aXmlHandler->mWriter, BAD_CAST "App", BAD_CAST k->getCString());
	 xmlTextWriterWriteAttribute(aXmlHandler->mWriter, BAD_CAST "TT", BAD_CAST aString.data());
	 xmlTextWriterEndElement(aXmlHandler->mWriter);
	 }
	 
	 // End ApplicationNames writing
	 xmlTextWriterEndElement(aXmlHandler->mWriter);
	 */
	
	return kTTErrNone;
}

TTErr TTApplication::ReadFromXml(const TTValue& value)
{
	TTXmlHandlerPtr	aXmlHandler = NULL;	
	TTString		anAppKey, aTTKey;
	TTSymbolPtr		pluginName, parameterName;
	TTValue			appValue, ttValue, v;
	
	value.get(0, (TTPtr*)&aXmlHandler);
	if (!aXmlHandler)
		return kTTErrGeneric;
	
	// Switch on the name of the XML node
	
	// Starts reading
	if (aXmlHandler->mXmlNodeName == TT("start")) {
		mAppToTT = new TTHash();
		mNamespaceFile = kTTSymEmpty;
		return kTTErrNone;
	}
	
	// Ends reading
	if (aXmlHandler->mXmlNodeName == TT("end"))
		return kTTErrNone;
	
	// Comment Node
	if (aXmlHandler->mXmlNodeName == TT("#comment"))
		return kTTErrNone;
	
	// Entry node
	if (aXmlHandler->mXmlNodeName == TT("entry")) {
	
		// get App Symbol
		if (xmlTextReaderMoveToAttribute(aXmlHandler->mReader, BAD_CAST "App") == 1) {
			aXmlHandler->fromXmlChar(xmlTextReaderValue(aXmlHandler->mReader), appValue);
			v = appValue;
			v.toString();
			v.get(0, anAppKey);
		}
		
		// get TT Value
		if (xmlTextReaderMoveToAttribute(aXmlHandler->mReader, BAD_CAST "TT") == 1) {
			aXmlHandler->fromXmlChar(xmlTextReaderValue(aXmlHandler->mReader), ttValue);
			v = ttValue;
			v.toString();
			v.get(0, aTTKey);
		}
		
		mAppToTT->append(TT(anAppKey), ttValue);		// here we register the entire value to handle 1 to many conversion
		mTTToApp->append(TT(aTTKey), appValue);			// here we register the entire value to handle 1 to many conversion
	}
	
	// Plugin node
	if (aXmlHandler->mXmlNodeName == TT("plugin")) {
		
		// get the plugin name
		xmlTextReaderMoveToAttribute(aXmlHandler->mReader, (const xmlChar*)("name"));
		aXmlHandler->fromXmlChar(xmlTextReaderValue(aXmlHandler->mReader), v);
		if (v.getType() == kTypeSymbol) {
			v.get(0, &pluginName);
		}
		
		// get all plugin attributes and their value
		while (xmlTextReaderMoveToNextAttribute(aXmlHandler->mReader) == 1) {
			
			// get parameter name
			aXmlHandler->fromXmlChar(xmlTextReaderName(aXmlHandler->mReader), v);
			if (v.getType() == kTypeSymbol) {
				v.get(0, &parameterName);
				
				// get parameter value
				aXmlHandler->fromXmlChar(xmlTextReaderValue(aXmlHandler->mReader), v);
				
				// configure a parameter of a plugin for the application
				v.prepend(parameterName);
				v.prepend(pluginName);
				Configure(v);
			}
		}
	}
	
	// Namespace node 
	if (aXmlHandler->mXmlNodeName == TT("namespace")) {
		
		// note : don't load namespace for local application in order 
		// to use the same configuration file for local and distant application
		// (the local application namespace could be loaded using mNamespaceFile attribute)
		if (mName != kTTSym_localApplicationName) {
			
			// get the file path
			xmlTextReaderMoveToAttribute(aXmlHandler->mReader, (const xmlChar*)("file"));
			aXmlHandler->fromXmlChar(xmlTextReaderValue(aXmlHandler->mReader), v);
			if (v.getType() == kTypeSymbol)
				v.get(0, &mNamespaceFile);
		}
	}
	
	// load namespace file if one is given and there is a plugin
	if (mNamespaceFile != kTTSymEmpty && mPluginNames.getSize()) {
		
		TTOpmlHandlerPtr	aOpmlHandler = NULL;
		TTValue				args, o;
		TTObjectInstantiate(TT("OpmlHandler"), TTObjectHandle(&aOpmlHandler), args);
		o = TTValue(TTPtr(this));
		aOpmlHandler->setAttributeValue(kTTSym_object, o);
		aOpmlHandler->sendMessage(TT("Read"), v);
		TTObjectRelease(TTObjectHandle(&aOpmlHandler));
	}
	
	return kTTErrNone;
}

TTErr TTApplication::ReadFromOpml(const TTValue& value)
{
	TTOpmlHandlerPtr	aOpmlHandler = NULL;	
	TTSymbolPtr			nodeNameInstance, objectName, attributeName, pluginName;
	TTNodeAddressPtr	absoluteAddress;
	TTMirrorPtr			aMirror;
	TTNodePtr			aNode;
	TTBoolean			empty, newInstanceCreated;
	TTObjectPtr			getAttributeCallback, setAttributeCallback, sendMessageCallback, listenAttributeCallback;
	TTValuePtr			getAttributeBaton, setAttributeBaton, sendMessageBaton, listenAttributeBaton;
	TTPluginHandlerPtr	aPlugin;
	TTValue				v, args;
	
	value.get(0, (TTPtr*)&aOpmlHandler);
	if (!aOpmlHandler)
		return kTTErrGeneric;
	
	// Switch on the name of the XML node
	
	// Starts reading
	if (aOpmlHandler->mXmlNodeName == TT("start")) {
		
		delete mDirectory;
		mDirectory = new TTNodeDirectory(mName);
		
		mTempAddress = kTTAdrsEmpty;
		
		return kTTErrNone;
	}
	
	// Ends reading
	if (aOpmlHandler->mXmlNodeName == TT("end"))
		return kTTErrNone;
	
	// Text Node
	if (aOpmlHandler->mXmlNodeName == TT("#text"))
		return kTTErrNone;
	
	// Outline node
	if (aOpmlHandler->mXmlNodeName == TT("outline")) {
		
		empty = xmlTextReaderIsEmptyElement(aOpmlHandler->mReader);
		
		// get the relative address
		xmlTextReaderMoveToAttribute(aOpmlHandler->mReader, (const xmlChar*)("text"));
		aOpmlHandler->fromXmlChar(xmlTextReaderValue(aOpmlHandler->mReader), v, YES);
		if (v.getType() == kTypeSymbol) {
			v.get(0, &nodeNameInstance);
		}
		
		// Is it the beginning of a new node or the end of one ?
		if (mTempAddress->getNameInstance() != nodeNameInstance) {
			
			absoluteAddress = mTempAddress->appendAddress(TTADRS(nodeNameInstance->getCString()));
			
			// get the object name
			if (xmlTextReaderMoveToAttribute(aOpmlHandler->mReader, (const xmlChar*)("object")) == 1) {
				aOpmlHandler->fromXmlChar(xmlTextReaderValue(aOpmlHandler->mReader), v);
				
				if (v.getType() == kTypeSymbol) {
					v.get(0, &objectName);
					
					// a distant application should have one plugin
					mPluginNames.get(0, &pluginName);
					
					if (aPlugin = getPlugin(pluginName)) {
						
						// instantiate Mirror object for distant application
						aMirror = NULL;
						args = TTValue(objectName);
						
						getAttributeCallback = NULL;
						TTObjectInstantiate(TT("callback"), &getAttributeCallback, kTTValNONE);
						getAttributeBaton = new TTValue(TTPtr(aPlugin));
						getAttributeBaton->append(TTPtr(this));
						getAttributeBaton->append(absoluteAddress);
						getAttributeCallback->setAttributeValue(kTTSym_baton, TTPtr(getAttributeBaton));
						getAttributeCallback->setAttributeValue(kTTSym_function, TTPtr(&TTPluginHandlerGetAttributeCallback));
						args.append(getAttributeCallback);
						
						setAttributeCallback = NULL;
						TTObjectInstantiate(TT("callback"), &setAttributeCallback, kTTValNONE);
						setAttributeBaton = new TTValue(TTPtr(aPlugin));
						setAttributeBaton->append(TTPtr(this));
						setAttributeBaton->append(absoluteAddress);
						setAttributeCallback->setAttributeValue(kTTSym_baton, TTPtr(setAttributeBaton));
						setAttributeCallback->setAttributeValue(kTTSym_function, TTPtr(&TTPluginHandlerSetAttributeCallback));
						args.append(setAttributeCallback);
						
						sendMessageCallback = NULL;
						TTObjectInstantiate(TT("callback"), &sendMessageCallback, kTTValNONE);
						sendMessageBaton = new TTValue(TTPtr(aPlugin));
						sendMessageBaton->append(TTPtr(this));
						sendMessageBaton->append(absoluteAddress);
						sendMessageCallback->setAttributeValue(kTTSym_baton, TTPtr(sendMessageBaton));
						sendMessageCallback->setAttributeValue(kTTSym_function, TTPtr(&TTPluginHandlerSendMessageCallback));
						args.append(sendMessageCallback);
						
						listenAttributeCallback = NULL;
						TTObjectInstantiate(TT("callback"), &listenAttributeCallback, kTTValNONE);
						listenAttributeBaton = new TTValue(TTPtr(aPlugin));
						listenAttributeBaton->append(TTPtr(this));
						listenAttributeBaton->append(absoluteAddress);
						listenAttributeCallback->setAttributeValue(kTTSym_baton, TTPtr(listenAttributeBaton));
						listenAttributeCallback->setAttributeValue(kTTSym_function, TTPtr(&TTPluginHandlerListenAttributeCallback));
						args.append(listenAttributeCallback);
						
						TTObjectInstantiate(TT("Mirror"), TTObjectHandle(&aMirror), args);
						
						// register object into the directory
						this->mDirectory->TTNodeCreate(absoluteAddress, (TTObjectPtr)aMirror, NULL,  &aNode, &newInstanceCreated);
						
						// ?? to -- is it usefull to set attribute value ?
						// yes : in modul8 case for example...
						// so it depends of the plugin features : isGetRequestAllowed ?
						
						/*
						// get all object attributes and their value
						while (xmlTextReaderMoveToNextAttribute(aOpmlHandler->mReader) == 1) {
							
							// get attribute name
							aOpmlHandler->fromXmlChar(xmlTextReaderName(aOpmlHandler->mReader), v);
							if (v.getType() == kTypeSymbol) {
								v.get(0, &attributeName);
								
								// get attribute value
								aOpmlHandler->fromXmlChar(xmlTextReaderValue(aOpmlHandler->mReader), v);
								

								// aMirror->setAttributeValue(attributeName, v);
							}
						}
						 */
					}
				}
			}
			
			// if there are other nodes below :
			// keep absolute address for next nodes
			if (!empty)
				mTempAddress = absoluteAddress;
		}
		// when a node ends : 
		// keep the parent address for next nodes
		else
			mTempAddress = mTempAddress->getParent();
			
	}
	
	return kTTErrNone;
}

#if 0
#pragma mark -
#pragma mark Some Methods
#endif

TTNodeDirectoryPtr TTApplicationGetDirectory(TTNodeAddressPtr anAddress)
{
	TTSymbolPtr			applicationName;
	TTApplicationPtr	anApplication;
	
	if (TTModularApplications && anAddress != kTTAdrsEmpty) {
		
		applicationName = anAddress->getDirectory();
		
		if (applicationName != NO_DIRECTORY)
			anApplication = TTApplicationManagerGetApplication(applicationName);
		else
			anApplication = TTApplicationManagerGetApplication(kTTSym_localApplicationName);
		
		if (anApplication)
			return anApplication->mDirectory;
	}
	
	return NULL;
}

TTSymbolPtr TTApplicationConvertAppNameToTTName(TTSymbolPtr anAppName)
{
	TTErr		err;
	TTValue		c;
	TTSymbolPtr converted = anAppName;
	
	if (TTModularApplications) {
		
		err = TTApplicationManagerGetApplication(kTTSym_localApplicationName)->mAppToTT->lookup(anAppName, c);
		
		if (!err)
			c.get(0, &converted);
		
	}
	
	return converted;
}

TTSymbolPtr TTApplicationConvertTTNameToAppName(TTSymbolPtr aTTName)
{
	TTErr		err;
	TTValue		c;
	TTSymbolPtr converted = kTTSymEmpty;
	
	if (TTModularApplications) {
		
		err = TTApplicationManagerGetApplication(kTTSym_localApplicationName)->mTTToApp->lookup(aTTName, c);
		
		if (!err)
			c.get(0, &converted);
		
	}
	
	return converted;
}