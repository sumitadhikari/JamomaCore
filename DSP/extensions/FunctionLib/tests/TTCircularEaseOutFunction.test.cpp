/** @file
 *
 * @ingroup dspFunctionLib
 *
 * @brief Unit tests for the Jamoma DSP #TTCircularEaseOutFunction of the #TTFunctionLib
 *
 * @details Derived from Sam Hocevar's public domain C/C++ implementation of Robert Penner easing functions
 *
 * @authors Trond Lossius
 *
 * @copyright Copyright © 2014 by Trond Lossius @n
 * This code is licensed under the terms of the "New BSD License" @n
 * http://creativecommons.org/licenses/BSD/
 */


#include "TTFunction.h"
#include "TTCircularEaseOutFunction.h"


/*
 * coefficients calculated in Octave using:

 x = linspace(0,1,128);
 y = sqrt((2 - x) .* x);
 printf("%.16e,\n", y)
 plot (x,y)
 
 */

TTErr TTCircularEaseOutFunction::test(TTValue& returnedTestInfo)
{
	int					errorCount = 0;
	int					testAssertionCount = 0;
	int					badSampleCount = 0;
	TTAudioSignalPtr	input = NULL;
	TTAudioSignalPtr	output = NULL;
	int					N = 128;
	TTValue				v;
	

	TTFloat64 inputSignal1[128] = {
		0.0000000000000000e+00,
		7.8740157480314960e-03,
		1.5748031496062992e-02,
		2.3622047244094488e-02,
		3.1496062992125984e-02,
		3.9370078740157480e-02,
		4.7244094488188976e-02,
		5.5118110236220472e-02,
		6.2992125984251968e-02,
		7.0866141732283464e-02,
		7.8740157480314960e-02,
		8.6614173228346455e-02,
		9.4488188976377951e-02,
		1.0236220472440945e-01,
		1.1023622047244094e-01,
		1.1811023622047244e-01,
		1.2598425196850394e-01,
		1.3385826771653542e-01,
		1.4173228346456693e-01,
		1.4960629921259844e-01,
		1.5748031496062992e-01,
		1.6535433070866140e-01,
		1.7322834645669291e-01,
		1.8110236220472442e-01,
		1.8897637795275590e-01,
		1.9685039370078738e-01,
		2.0472440944881889e-01,
		2.1259842519685040e-01,
		2.2047244094488189e-01,
		2.2834645669291337e-01,
		2.3622047244094488e-01,
		2.4409448818897639e-01,
		2.5196850393700787e-01,
		2.5984251968503935e-01,
		2.6771653543307083e-01,
		2.7559055118110237e-01,
		2.8346456692913385e-01,
		2.9133858267716534e-01,
		2.9921259842519687e-01,
		3.0708661417322836e-01,
		3.1496062992125984e-01,
		3.2283464566929132e-01,
		3.3070866141732280e-01,
		3.3858267716535434e-01,
		3.4645669291338582e-01,
		3.5433070866141730e-01,
		3.6220472440944884e-01,
		3.7007874015748032e-01,
		3.7795275590551181e-01,
		3.8582677165354329e-01,
		3.9370078740157477e-01,
		4.0157480314960631e-01,
		4.0944881889763779e-01,
		4.1732283464566927e-01,
		4.2519685039370081e-01,
		4.3307086614173229e-01,
		4.4094488188976377e-01,
		4.4881889763779526e-01,
		4.5669291338582674e-01,
		4.6456692913385828e-01,
		4.7244094488188976e-01,
		4.8031496062992124e-01,
		4.8818897637795278e-01,
		4.9606299212598426e-01,
		5.0393700787401574e-01,
		5.1181102362204722e-01,
		5.1968503937007871e-01,
		5.2755905511811019e-01,
		5.3543307086614167e-01,
		5.4330708661417326e-01,
		5.5118110236220474e-01,
		5.5905511811023623e-01,
		5.6692913385826771e-01,
		5.7480314960629919e-01,
		5.8267716535433067e-01,
		5.9055118110236215e-01,
		5.9842519685039375e-01,
		6.0629921259842523e-01,
		6.1417322834645671e-01,
		6.2204724409448819e-01,
		6.2992125984251968e-01,
		6.3779527559055116e-01,
		6.4566929133858264e-01,
		6.5354330708661412e-01,
		6.6141732283464560e-01,
		6.6929133858267720e-01,
		6.7716535433070868e-01,
		6.8503937007874016e-01,
		6.9291338582677164e-01,
		7.0078740157480313e-01,
		7.0866141732283461e-01,
		7.1653543307086609e-01,
		7.2440944881889768e-01,
		7.3228346456692917e-01,
		7.4015748031496065e-01,
		7.4803149606299213e-01,
		7.5590551181102361e-01,
		7.6377952755905509e-01,
		7.7165354330708658e-01,
		7.7952755905511806e-01,
		7.8740157480314954e-01,
		7.9527559055118113e-01,
		8.0314960629921262e-01,
		8.1102362204724410e-01,
		8.1889763779527558e-01,
		8.2677165354330706e-01,
		8.3464566929133854e-01,
		8.4251968503937003e-01,
		8.5039370078740162e-01,
		8.5826771653543310e-01,
		8.6614173228346458e-01,
		8.7401574803149606e-01,
		8.8188976377952755e-01,
		8.8976377952755903e-01,
		8.9763779527559051e-01,
		9.0551181102362199e-01,
		9.1338582677165348e-01,
		9.2125984251968507e-01,
		9.2913385826771655e-01,
		9.3700787401574803e-01,
		9.4488188976377951e-01,
		9.5275590551181100e-01,
		9.6062992125984248e-01,
		9.6850393700787396e-01,
		9.7637795275590555e-01,
		9.8425196850393704e-01,
		9.9212598425196852e-01,
		1.0000000000000000e+00
	};

		
	TTFloat64 expectedSignal1[128] = { 
		0.0000000000000000e+00,
		1.2524388756367610e-01,
		1.7677121512317834e-01,
		2.1606964935452352e-01,
		2.4899824095814010e-01,
		2.7783116164373783e-01,
		3.0373703184229778e-01,
		3.2741138403609121e-01,
		3.4930823642234382e-01,
		3.6974352383854792e-01,
		3.8894768614892816e-01,
		4.0709499069954530e-01,
		4.2432105780495999e-01,
		4.4073392028839459e-01,
		4.5642131484061221e-01,
		4.7145566550937645e-01,
		4.8589759434776419e-01,
		4.9979845897821573e-01,
		5.1320222793071890e-01,
		5.2614689361537370e-01,
		5.3866555516494707e-01,
		5.5078726086685548e-01,
		5.6253767242493713e-01,
		5.7393959509108416e-01,
		5.8501340538603808e-01,
		5.9577739962289589e-01,
		6.0624808046992618e-01,
		6.1644039452125454e-01,
		6.2636793075122332e-01,
		6.3604308745683114e-01,
		6.4547721360375421e-01,
		6.5468072922128573e-01,
		6.6366322852615678e-01,
		6.7243356871426985e-01,
		6.8099994678550080e-01,
		6.8936996631845004e-01,
		6.9755069575905826e-01,
		7.0554871950701692e-01,
		7.1337018286022835e-01,
		7.2102083169772524e-01,
		7.2850604763592930e-01,
		7.3583087927469160e-01,
		7.4300007005262669e-01,
		7.5001808315149976e-01,
		7.5688912382349072e-01,
		7.6361715946037545e-01,
		7.7020593767795176e-01,
		7.7665900265072108e-01,
		7.8297970989959387e-01,
		7.8917123970814540e-01,
		7.9523660931984863e-01,
		8.0117868404905013e-01,
		8.0700018742166657e-01,
		8.1270371044719725e-01,
		8.1829172011128060e-01,
		8.2376656716737073e-01,
		8.2913049329689337e-01,
		8.3438563769925034e-01,
		8.3953404316610014e-01,
		8.4457766168828619e-01,
		8.4951835963849931e-01,
		8.5435792256812348e-01,
		8.5909805965265240e-01,
		8.6374040781648287e-01,
		8.6828653556473834e-01,
		8.7273794654698422e-01,
		8.7709608287523277e-01,
		8.8136232821644189e-01,
		8.8553801067776683e-01,
		8.8962440550108890e-01,
		8.9362273758180211e-01,
		8.9753418382545314e-01,
		9.0135987535459439e-01,
		9.0510089957710071e-01,
		9.0875830212620523e-01,
		9.1233308868161167e-01,
		9.1582622668023383e-01,
		9.1923864692438817e-01,
		9.2257124509460220e-01,
		9.2582488317361000e-01,
		9.2900039078756702e-01,
		9.3209856647002476e-01,
		9.3512017885376519e-01,
		9.3806596779518647e-01,
		9.4093664543556887e-01,
		9.4373289720320885e-01,
		9.4645538276010821e-01,
		9.4910473689662045e-01,
		9.5168157037720480e-01,
		9.5418647074020169e-01,
		9.5662000305432682e-01,
		9.5898271063438811e-01,
		9.6127511571854196e-01,
		9.6349772010924517e-01,
		9.6565100577989871e-01,
		9.6773543544904150e-01,
		9.6975145312382061e-01,
		9.7169948461434141e-01,
		9.7357993802039255e-01,
		9.7539320419193287e-01,
		9.7713965716463436e-01,
		9.7881965457168485e-01,
		9.8043353803296895e-01,
		9.8198163352267298e-01,
		9.8346425171628327e-01,
		9.8488168831788114e-01,
		9.8623422436857799e-01,
		9.8752212653686955e-01,
		9.8874564739163850e-01,
		9.8990502565848182e-01,
		9.9100048645998573e-01,
		9.9203224154053404e-01,
		9.9300048947618558e-01,
		9.9390541587011760e-01,
		9.9474719353409491e-01,
		9.9552598265638670e-01,
		9.9624193095651714e-01,
		9.9689517382720594e-01,
		9.9748583446381822e-01,
		9.9801402398161920e-01,
		9.9847984152109337e-01,
		9.9888337434156493e-01,
		9.9922469790332624e-01,
		9.9950387593845580e-01,
		9.9972096051048054e-01,
		9.9987599206301525e-01,
		9.9996899945748308e-01,
		1.0000000000000000e+00
	};	
	
	// setup Function 
	this->setAttributeValue(TT("function"), TT("easeOutCircular"));

	
	// create 1 channel audio signal objects
	TTObjectBaseInstantiate(kTTSym_audiosignal, &input, 1);
	TTObjectBaseInstantiate(kTTSym_audiosignal, &output, 1);
	input->allocWithVectorSize(N);
	output->allocWithVectorSize(N);
	
	// create a signal to be transformed and then process it)
	input->clear();	
	for (int i=0; i<N; i++)
		input->mSampleVectors[0][i] = inputSignal1[i]; 
	
	this->process(input, output);
	
	// now test the output
	for (int n=0; n<N; n++)
	{
		TTBoolean result = !TTTestFloatEquivalence(output->mSampleVectors[0][n], expectedSignal1[n]);
		badSampleCount += result;
		if (result) 
			TTTestLog("BAD SAMPLE @ n=%i ( value=%.10f	expected=%.10f )", n, output->mSampleVectors[0][n], expectedSignal1[n]);
	}
	
	TTTestAssertion("Produces correct function values", 
					badSampleCount == 0,
					testAssertionCount, 
					errorCount);
	if (badSampleCount)
		TTTestLog("badSampleCount is %i", badSampleCount);
	
	
	TTObjectBaseRelease(&input);
	TTObjectBaseRelease(&output);
	
	// wrap up test results and pass back to whoever called test
	return TTTestFinish(testAssertionCount, errorCount, returnedTestInfo);
	
}