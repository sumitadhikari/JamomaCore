/* 
 * Unit tests for the NodeLib
 * Copyright © 2011, Théo de la Hogue
 * 
 * License: This code is licensed under the terms of the "New BSD License"
 * http://creativecommons.org/licenses/BSD/
 */

#ifndef __TT_NODELIBTEST_H__
#define __TT_NODELIBTEST_H__

#include "TTDataObject.h"
#include "TTUnitTest.h"

#include "TTNode.h"
#include "TTNodeAddress.h"
#include "TTNodeAddressItem.h"
#include "TTNodeDirectory.h"

/**	Provide unit tests for #TTValue */
class TTNodeLibTest : public TTDataObject {
	TTCLASS_SETUP(TTNodeLibTest)
		
	virtual TTErr test(TTValue& returnedTestInfo);
};


#endif // __TT_NODELIBTEST_H__
