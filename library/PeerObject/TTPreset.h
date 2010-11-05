/* 
 * A Preset Object
 * Copyright © 2010, Théo de la Hogue
 * 
 * License: This code is licensed under the terms of the "New BSD License"
 * http://creativecommons.org/licenses/BSD/
 */

#ifndef __TT_PRESET_H__
#define __TT_PRESET_H__

#include "TTModular.h"


/**	TTPreset ... TODO : an explanation
 
 
 */

/** Internal class to store an Object and his state <attribute, value> 
	The attributes to store are chosen when the item is created */
class Item
	{
		public :
		
		TTObjectPtr		object;
		TTHashPtr		state;
		
		Item(TTNodePtr aNode);
		~Item();
	};
typedef Item* ItemPtr;

class TTApplication;
typedef TTApplication* TTApplicationPtr;

class TTMODULAR_EXPORT TTPreset : public TTObject
{
	TTCLASS_SETUP(TTPreset)
	
public:		// use public to allow PresetManager to have a direct access
	
	TTSymbolPtr			mName;							///< ATTRIBUTE: the name of the preset
	TTSymbolPtr			mAddress;						///< ATTRIBUTE: the parent address of each stored data
	TTSymbolPtr			mComment;						///< TODO
	TTValue				mExtra;							///< TODO
	
private:	
	
	TTApplicationPtr	mApplication;					///< the application
	TTCallbackPtr		mTestObjectCallback;			///< a callback used to validate object storage
	TTHashPtr			mToStore;						///< a hash table containing <objectType, all Attribute names to store>
	TTHashPtr			mItemList;						///< a hash table containing <relativeAddress, ItemPtr>
	TTSymbolPtr			mCurrentItem;					///< a key to retrieve the current Item in the ItemList
	
	/** */
	TTErr setAddress(const TTValue& value);
	
	/** */
	TTErr Fill();
	
	/** */
	TTErr Clear();
	
	/** */
	TTErr Update();
	
	/** */
	TTErr Send();
	
	/**  needed to be handled by a TTXmlHandler */
	TTErr WriteAsXml(const TTValue& value);
	TTErr ReadFromXml(const TTValue& value);
	
	/**  needed to be handled by a TTTextHandler */
	TTErr WriteAsText(const TTValue& value);
	TTErr ReadFromText(const TTValue& value);
};

typedef TTPreset* TTPresetPtr;

#endif // __TT_PRESET_H__
