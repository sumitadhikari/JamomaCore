/* 
 * Jamoma Asynchronous Object Graph Layer
 * Creates a wrapper for TTObjects that can be used to build a control graph for asynchronous message passing.
 * Copyright © 2010, Timothy Place
 * 
 * License: This code is licensed under the terms of the GNU LGPL
 * http://www.gnu.org/licenses/lgpl.html 
 */

#include "TTGraphObject.h"
#include "TTGraphInlet.h"
#include "TTGraphOutlet.h"

#define thisTTClass			TTGraphObject
#define thisTTClassName		"graph.object"
#define thisTTClassTags		"audio, multicore, wrapper"


//	Arguments
//	1. (required) The name of the Jamoma DSP object you want to wrap
//	2. (optional) Number of inlets, default = 1
//	3. (optional) Number of outlets, default = 1

TT_OBJECT_CONSTRUCTOR,
//	mFlags(kTTGraphProcessor), 
	mKernel(NULL)
{
	TTErr		err = kTTErrNone;
	TTSymbolPtr	wrappedObjectName = NULL;
	TTUInt16	initialNumChannels = 1;
	TTUInt16	numInlets = 1;
	TTUInt16	numOutlets = 1;
	
	TT_ASSERT(graph_correct_instantiation_args, arguments.getSize() > 0);
	
	arguments.get(0, &wrappedObjectName);
	if (arguments.getSize() > 1)
		arguments.get(1, numInlets);
	if (arguments.getSize() > 2)
		arguments.get(2, numOutlets);
	
	err = TTObjectInstantiate(wrappedObjectName, &mKernel, initialNumChannels);
	
	mInlets.resize(numInlets);
	mOutlets.resize(numOutlets);
}


TTGraphObject::~TTGraphObject()
{
	TTObjectRelease(&mKernel);
}


void TTGraphObject::getDescription(TTGraphDescription& desc)
{
	desc.mClassName = mKernel->getName();
	desc.mInputDescriptions.clear();
	for (TTGraphInletIter inlet = mInlets.begin(); inlet != mInlets.end(); inlet++)
		inlet->getDescriptions(desc.mInputDescriptions);
}


TTErr TTGraphObject::reset()
{
	for_each(mInlets.begin(), mInlets.end(), mem_fun_ref(&TTGraphInlet::reset));		
	return kTTErrNone;
}


TTErr TTGraphObject::connect(TTGraphObjectPtr anObject, TTUInt16 fromOutletNumber, TTUInt16 toInletNumber)
{
	TTErr err;
	
	err = mInlets[toInletNumber].connect(anObject, fromOutletNumber);
	return err;
}


TTErr TTGraphObject::drop(TTGraphObjectPtr anObject, TTUInt16 fromOutletNumber, TTUInt16 toInletNumber)
{
	TTErr err = kTTErrInvalidValue;
	
	if (toInletNumber < mInlets.size())
		err = mInlets[toInletNumber].drop(anObject, fromOutletNumber);	
	return err;
}

