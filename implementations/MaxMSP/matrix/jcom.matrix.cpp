/* 
 *	matrix≈
 *	External object for Jamoma Multicore
 *	Copyright © 2009 by Timothy Place
 * 
 *	License: This code is licensed under the terms of the GNU LGPL
 *	http://www.gnu.org/licenses/lgpl.html 
 */

#include "maxMulticore.h"


int main(void)
{
	MaxMulticoreWrappedClassOptionsPtr	options = new MaxMulticoreWrappedClassOptions;
	TTValue								value(0);
	
	TTMulticoreInit();

	options->append(TT("nonadapting"), value); // don't change the number of out-channels in response to changes in the number of in-channels
	return wrapAsMaxMulticore(TT("matrix"), "jcom.matrix≈", NULL, options);
}
