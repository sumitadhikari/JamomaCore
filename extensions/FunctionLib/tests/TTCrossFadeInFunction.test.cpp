/*
 * Unit tests for the Jamoma DSP CrossFadeInFunction of the FunctionLib 
 * Copyright © 2012, Trond Lossius
 * 
 * License: This code is licensed under the terms of the "New BSD License"
 * http://creativecommons.org/licenses/BSD/
 */

#include "TTFunction.h"
#include "TTCrossFadeInFunction.h"


/*
 * coefficients calculated in Octave using:

 x = linspace(0,1,128);
 y = sin(x * pi * 0.5);
 printf("%.16e,\n", y)
 
 */

TTErr TTCrossFadeInFunction::test(TTValue& returnedTestInfo)
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
		1.2368159663362913e-02,
		2.4734427279994954e-02,
		3.7096911092605309e-02,
		4.9453719922738996e-02,
		6.1802963460084098e-02,
		7.4142752551646193e-02,
		8.6471199490745720e-02,
		9.8786418305794141e-02,
		1.1108652504880456e-01,
		1.2336963808359297e-01,
		1.3563387837362564e-01,
		1.4787736976946894e-01,
		1.6009823929579747e-01,
		1.7229461743791666e-01,
		1.8446463842775590e-01,
		1.9660644052928852e-01,
		2.0871816632333506e-01,
		2.2079796299170620e-01,
		2.3284398260064146e-01,
		2.4485438238350118e-01,
		2.5682732502266792e-01,
		2.6876097893061413e-01,
		2.8065351853009307e-01,
		2.9250312453341087e-01,
		3.0430798422073607e-01,
		3.1606629171740452e-01,
		3.2777624827017676e-01,
		3.3943606252240655e-01,
		3.5104395078807760e-01,
		3.6259813732466700e-01,
		3.7409685460479319e-01,
		3.8553834358660738e-01,
		3.9692085398288718e-01,
		4.0824264452879033e-01,
		4.1950198324822902e-01,
		4.3069714771882195e-01,
		4.4182642533538669e-01,
		4.5288811357192876e-01,
		4.6388052024208931e-01,
		4.7480196375801115e-01,
		4.8565077338758367e-01,
		4.9642528951002624e-01,
		5.0712386386977315e-01,
		5.1774485982861806e-01,
		5.2828665261608365e-01,
		5.3874762957797362e-01,
		5.4912619042307242e-01,
		5.5942074746795312e-01,
		5.6962972587985716e-01,
		5.7975156391760729e-01,
		5.8978471317051939e-01,
		5.9972763879527302e-01,
		6.0957881975070782e-01,
		6.1933674903050873e-01,
		6.2899993389374242e-01,
		6.3856689609321438e-01,
		6.4803617210160513e-01,
		6.5740631333535815e-01,
		6.6667588637627928e-01,
		6.7584347319081739e-01,
		6.8490767134699104e-01,
		6.9386709422892900e-01,
		7.0272037124899012e-01,
		7.1146614805743313e-01,
		7.2010308674960033e-01,
		7.2862986607058722e-01,
		7.3704518161736376e-01,
		7.4534774603831877e-01,
		7.5353628923019544e-01,
		7.6160955853238788e-01,
		7.6956631891856975e-01,
		7.7740535318562576e-01,
		7.8512546213985479e-01,
		7.9272546478042061e-01,
		8.0020419848001689e-01,
		8.0756051916272376e-01,
		8.1479330147902440e-01,
		8.2190143897795842e-01,
		8.2888384427638384e-01,
		8.3573944922532140e-01,
		8.4246720507335737e-01,
		8.4906608262707872e-01,
		8.5553507240851590e-01,
		8.6187318480957020e-01,
		8.6807945024340172e-01,
		8.7415291929275274e-01,
		8.8009266285518828e-01,
		8.8589777228522737e-01,
		8.9156735953334432e-01,
		8.9710055728182103e-01,
		9.0249651907742612e-01,
		9.0775441946090385e-01,
		9.1287345409324927e-01,
		9.1785283987875510e-01,
		9.2269181508480669e-01,
		9.2738963945841024e-01,
		9.3194559433943458e-01,
		9.3635898277054919e-01,
		9.4062912960384382e-01,
		9.4475538160410988e-01,
		9.4873710754877116e-01,
		9.5257369832444572e-01,
		9.5626456702012752e-01,
		9.5980914901696923e-01,
		9.6320690207465709e-01,
		9.6645730641436034e-01,
		9.6955986479824652e-01,
		9.7251410260554694e-01,
		9.7531956790516261e-01,
		9.7797583152480028e-01,
		9.8048248711662533e-01,
		9.8283915121942378e-01,
		9.8504546331726328e-01,
		9.8710108589464407e-01,
		9.8900570448813074e-01,
		9.9075902773445801e-01,
		9.9236078741510303e-01,
		9.9381073849731638e-01,
		9.9510865917160662e-01,
		9.9625435088567205e-01,
		9.9724763837477470e-01,
		9.9808836968855197e-01,
		9.9877641621426128e-01,
		9.9931167269645527e-01,
		9.9969405725308313e-01,
		9.9992351138801694e-01,
		1.0000000000000000e+00
	};	
	
	// setup Function 
	this->setAttributeValue(TT("function"), TT("crossFadeIn"));

	
	// create 1 channel audio signal objects
	TTObjectInstantiate(kTTSym_audiosignal, &input, 1);
	TTObjectInstantiate(kTTSym_audiosignal, &output, 1);
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
	
	
	TTObjectRelease(&input);
	TTObjectRelease(&output);
	
	// wrap up test results and pass back to whoever called test
	return TTTestFinish(testAssertionCount, errorCount, returnedTestInfo);
	
}