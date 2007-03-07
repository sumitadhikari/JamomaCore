// taptools base file

#include "tt_audio_base.h"

// GLOBALS (CLASS STATICS)
tt_int32 tt_audio_base::global_sr = 44100;						// Global Sample Rate
tt_int16 tt_audio_base::global_vectorsize = 64;					// Global Vector Size

const double tt_audio_base::pi = 3.1415926535897932;		// pi
const double tt_audio_base::twopi = 6.2831853071795864;	// 2 * pi
const double tt_audio_base::anti_denormal_value = 1e-18;	// used by tt_audio_base::anti_denormal()

const float tt_audio_base::lookup_equalpower[] = {			// 512 point equal-power table
	0.999939F, 0.999908F, 0.999939F, 0.999908F, 0.999908F,
	0.999847F, 0.999817F, 0.999756F, 0.999664F, 0.999695F, 0.999512F, 0.999481F, 0.999298F, 0.999298F, 0.999146F, 
	0.998993F, 0.998840F, 0.998779F, 0.998505F, 0.998474F, 0.998169F, 0.998047F, 0.997864F, 0.997650F, 0.997406F, 
	0.997253F, 0.996918F, 0.996765F, 0.996521F, 0.996155F, 0.996033F, 0.995667F, 0.995331F, 0.995209F, 0.994690F, 
	0.994568F, 0.994049F, 0.993866F, 0.993500F, 0.993073F, 0.992767F, 0.992371F, 0.992004F, 0.991608F, 0.991241F, 
	0.990753F, 0.990387F, 0.989960F, 0.989532F, 0.989044F, 0.988617F, 0.988098F, 0.987732F, 0.987183F, 0.986633F, 
	0.986267F, 0.985565F, 0.985229F, 0.984589F, 0.984131F, 0.983429F, 0.983032F, 0.982391F, 0.981842F, 0.981171F, 
	0.980713F, 0.980011F, 0.979431F, 0.978729F, 0.978241F, 0.977478F, 0.976868F, 0.976227F, 0.975525F, 0.974823F, 
	0.974243F, 0.973419F, 0.972809F, 0.972015F, 0.971375F, 0.970551F, 0.969849F, 0.969116F, 0.968323F, 0.967529F, 
	0.966858F, 0.965912F, 0.965210F, 0.964386F, 0.963562F, 0.962738F, 0.961945F, 0.960999F, 0.960236F, 0.959351F, 
	0.958466F, 0.957611F, 0.956696F, 0.955811F, 0.954895F, 0.953979F, 0.953064F, 0.952118F, 0.951172F, 0.950226F, 
	0.949310F, 0.948242F, 0.947357F, 0.946259F, 0.945404F, 0.944305F, 0.943298F, 0.942291F, 0.941223F, 0.940247F, 
	0.939148F, 0.938080F, 0.937073F, 0.935883F, 0.934937F, 0.933716F, 0.932678F, 0.931549F, 0.930481F, 0.929260F, 
	0.928162F, 0.927002F, 0.925903F, 0.924683F, 0.923523F, 0.922272F, 0.921234F, 0.919922F, 0.918701F, 0.917542F, 
	0.916290F, 0.915070F, 0.913788F, 0.912598F, 0.911285F, 0.910034F, 0.908722F, 0.907501F, 0.906189F, 0.904846F, 
	0.903534F, 0.902222F, 0.900970F, 0.899536F, 0.898193F, 0.896881F, 0.895508F, 0.894165F, 0.892670F, 0.891418F, 
	0.889923F, 0.888611F, 0.887085F, 0.885773F, 0.884216F, 0.882965F, 0.881287F, 0.880005F, 0.878479F, 0.876984F, 
	0.875610F, 0.873932F, 0.872589F, 0.871063F, 0.869476F, 0.868011F, 0.866516F, 0.864899F, 0.863373F, 0.861877F, 
	0.860229F, 0.858765F, 0.857056F, 0.855591F, 0.853912F, 0.852325F, 0.850739F, 0.849091F, 0.847534F, 0.845764F, 
	0.844238F, 0.842560F, 0.840851F, 0.839264F, 0.837524F, 0.835876F, 0.834167F, 0.832489F, 0.830719F, 0.829132F, 
	0.827271F, 0.825592F, 0.823883F, 0.822113F, 0.820343F, 0.818634F, 0.816803F, 0.815033F, 0.813324F, 0.811401F, 
	0.809723F, 0.807861F, 0.806030F, 0.804291F, 0.802338F, 0.800598F, 0.798706F, 0.796844F, 0.795044F, 0.793091F,
	0.791260F, 0.789398F, 0.787476F, 0.785583F, 0.783661F, 0.781799F, 0.779816F, 0.777954F, 0.775970F, 0.774017F, 
	0.772156F, 0.770111F, 0.768127F, 0.766266F, 0.764191F, 
	0.762268F, 0.760193F, 0.758331F, 0.756165F, 0.754242F, 0.752228F, 0.750183F, 0.748108F, 0.746124F, 0.744019F, 
	0.742035F, 0.739899F, 0.737854F, 0.735779F, 0.733673F, 0.731659F, 0.729431F, 0.727448F, 0.725220F, 0.723206F, 
	0.721008F, 0.718964F, 0.716644F, 0.714752F, 0.712341F, 0.710358F, 0.708099F, 0.705994F, 0.703766F, 0.701599F, 
	0.699371F, 0.697235F, 0.694946F, 0.692810F, 0.690552F, 0.688324F, 0.686096F, 0.683868F, 0.681580F, 0.679382F, 
	0.677155F, 0.674744F, 0.672638F, 0.670258F, 0.668030F, 0.665710F, 0.663422F, 0.661102F, 0.658844F, 0.656494F, 
	0.654144F, 0.651886F, 0.649445F, 0.647247F, 0.644745F, 0.642517F, 0.640106F, 0.637756F, 0.635315F, 0.633118F, 
	0.630493F, 0.628326F, 0.625763F, 0.623505F, 0.620941F, 0.618683F, 0.616180F, 0.613770F, 0.611359F, 0.608856F, 
	0.606537F, 0.603973F, 0.601593F, 0.599121F, 0.596649F, 0.594147F, 0.591766F, 0.589172F, 0.586761F, 0.584229F, 
	0.581757F, 0.579254F, 0.576721F, 0.574188F, 0.571777F, 0.569092F, 0.566742F, 0.564026F, 0.561615F, 0.558990F, 
	0.556519F, 0.553925F, 0.551331F, 0.548767F, 0.546295F, 0.543610F, 0.541016F, 0.538544F, 0.535828F, 0.533325F, 
	0.530640F, 0.528107F, 0.525421F, 0.522858F, 0.520203F, 0.517578F, 0.515015F, 0.512238F, 0.509766F, 0.506927F, 
	0.504486F, 0.501648F, 0.499115F, 0.496338F, 0.493774F, 0.491028F, 0.488403F, 0.485657F, 0.483032F, 0.480255F, 
	0.477631F, 0.474915F, 0.472198F, 0.469482F, 0.466705F, 0.464142F, 0.461243F, 0.458649F, 0.455811F, 0.453156F, 
	0.450378F, 0.447632F, 0.444824F, 0.442169F, 0.439423F, 0.436493F, 0.433899F, 0.431061F, 0.428253F, 0.425568F, 
	0.422668F, 0.419952F, 0.417145F, 0.414368F, 0.411499F, 0.408813F, 0.405853F, 0.403229F, 0.400208F, 0.397552F, 
	0.394653F, 0.391876F, 0.388977F, 0.386200F, 0.383331F, 0.380554F, 0.377625F, 0.374786F, 0.372009F, 0.369080F, 
	0.366241F, 0.363403F, 0.360504F, 0.357697F, 0.354706F, 0.351929F, 0.349030F, 0.346191F, 0.343170F, 0.340424F, 
	0.337463F, 0.334595F, 0.331696F, 0.328766F, 0.325897F, 0.322968F, 0.320038F, 0.317230F, 0.314117F, 0.311401F, 
	0.308350F, 0.305511F, 0.302490F, 0.299622F, 0.296661F, 0.293732F, 0.290802F, 0.287872F, 0.284882F, 0.281952F, 
	0.279022F, 0.276031F, 0.273163F, 0.270050F, 0.267242F, 0.264160F, 0.261292F, 0.258301F, 0.255280F, 0.252319F, 
	0.249420F, 0.246368F, 0.243347F, 0.240509F, 0.237396F, 0.234436F, 0.231476F, 0.228485F, 0.225464F, 0.222443F, 
	0.219513F, 0.216461F, 0.213531F, 0.210419F, 0.207489F, 0.204437F, 0.201477F, 0.198456F, 0.195404F, 0.192413F, 
	0.189423F, 0.186340F, 0.183411F, 0.180267F, 0.177338F, 0.174316F, 0.171204F, 0.168213F, 0.165253F, 0.16214F, 
	0.159088F, 0.156158F, 0.153015F, 0.149994F, 0.147003F, 0.143951F, 0.1409F, 0.137787F, 0.134857F, 0.131714F, 
	0.128754F, 0.125641F, 0.122589F, 0.119568F, 0.116547F, 0.113373F, 0.110443F, 0.10733F, 0.10434F, 0.101166F, 
	0.098175F, 0.095154F, 0.09201F, 0.08902F, 0.085907F, 0.082855F, 0.079865F, 0.07666F, 0.07373F, 0.070557F, 
	0.067596F, 0.064392F, 0.061493F, 0.058319F, 0.055237F, 0.052216F, 0.049164F, 0.04599F, 0.04306F, 0.039856F, 
	0.036896F, 0.033752F, 0.030701F, 0.027618F, 0.024567F, 0.021484F, 0.018402F, 0.01532F, 0.012268F,0.009216F, 
	0.006042F, 0.0F};	

const float tt_audio_base::lookup_half_paddedwelch[] = {		// 256 point window table
	0.000000F, 0.000000F, 0.000000F, 0.000000F, 0.000000F, 0.000000F,	0.000000F, 0.000000F, 0.000000F, 0.000000F,
	0.000000F, 0.000000F, 0.000000F, 0.000000F, 0.000000F, 0.000000F, 0.000000F, 0.006989F, 0.014008F, 0.021027F,
	0.028046F, 0.035034F, 0.042053F, 0.049042F, 0.056061F, 0.063049F, 0.070038F, 0.077057F, 0.084045F, 0.091034F,
	0.097992F, 0.104980F, 0.111938F, 0.118927F, 0.125885F, 0.132812F, 0.139771F, 0.146698F, 0.153656F, 0.160583F,
	0.167480F, 0.174408F, 0.181305F, 0.188202F, 0.195068F, 0.201935F, 0.208801F, 0.215668F, 0.222504F, 0.229340F,
	0.236145F, 0.242950F, 0.249756F, 0.256531F, 0.263306F, 0.270081F, 0.276825F, 0.283539F, 0.290253F, 0.296967F,
	0.303650F, 0.310333F, 0.316986F, 0.323639F, 0.330261F, 0.336853F, 0.343445F, 0.350037F, 0.356598F, 0.363129F,
	0.369659F, 0.376160F, 0.382660F, 0.389130F, 0.395569F, 0.402008F, 0.408417F, 0.414795F, 0.421173F, 0.427521F,
	0.433868F, 0.440155F, 0.446442F, 0.452698F, 0.458954F, 0.465179F, 0.471375F, 0.477539F, 0.483704F, 0.489807F,
	0.495911F, 0.501984F, 0.508057F, 0.514069F, 0.520081F, 0.526062F, 0.532013F, 0.537933F, 0.543823F, 0.549683F,
	0.555542F, 0.561340F, 0.567139F, 0.572906F, 0.578644F, 0.584351F, 0.590027F, 0.595673F, 0.601288F, 0.606873F,
	0.612427F, 0.617950F, 0.623444F, 0.628937F, 0.634369F, 0.639771F, 0.645142F, 0.650482F, 0.655792F, 0.661072F,
	0.666321F, 0.671509F, 0.676697F, 0.681854F, 0.686951F, 0.692047F, 0.697083F, 0.702087F, 0.707062F, 0.712006F,
	0.716919F, 0.721802F, 0.726624F, 0.731415F, 0.736176F, 0.740906F, 0.745605F, 0.750244F, 0.754883F, 0.759460F,
	0.764008F, 0.768494F, 0.772980F, 0.777405F, 0.781799F, 0.786133F, 0.790466F, 0.794739F, 0.798981F, 0.803162F,
	0.807312F, 0.811432F, 0.815521F, 0.819550F, 0.823547F, 0.827515F, 0.831421F, 0.835297F, 0.839142F, 0.842926F,
	0.846680F, 0.850403F, 0.854065F, 0.857697F, 0.861267F, 0.864807F, 0.868317F, 0.871765F, 0.875183F, 0.878540F,
	0.881866F, 0.885162F, 0.888397F, 0.891602F, 0.894745F, 0.897858F, 0.900940F, 0.903961F, 0.906921F, 0.909851F,
	0.912750F, 0.915588F, 0.918365F, 0.921143F, 0.923828F, 0.926483F, 0.929108F, 0.931671F, 0.934204F, 0.936676F,
	0.939117F, 0.941498F, 0.943848F, 0.946136F, 0.948364F, 0.950592F, 0.952728F, 0.954834F, 0.956909F, 0.958893F,
	0.960876F, 0.962799F, 0.964661F, 0.966492F, 0.968262F, 0.970001F, 0.971680F, 0.973297F, 0.974884F, 0.976410F,
	0.977905F, 0.979340F, 0.980743F, 0.982086F, 0.983368F, 0.984619F, 0.985840F, 0.986969F, 0.988068F, 0.989136F,
	0.990143F, 0.991089F, 0.992004F, 0.992859F, 0.993652F, 0.994415F, 0.995148F, 0.995789F, 0.996429F, 0.996979F,
	0.997498F, 0.997955F, 0.998383F, 0.998749F, 0.999084F, 0.999329F, 0.999573F, 0.999725F, 0.999847F, 0.999939F,
	0.999969F, 0.999969F, 0.999969F, 0.999969F, 0.999969F, 0.999969F, 0.999969F, 0.999969F, 0.999969F, 0.999969F,
	0.999969F, 0.999969F, 0.999969F, 0.999969F, 0.999969F, 0.999969F
};
	
const float tt_audio_base::lookup_quartersine[] = {		// 128 point quarter sine wave table
	0.000000F, 0.012272F, 0.024541F, 0.036807F, 0.049068F, 0.061321F, 0.073565F, 0.085797F, 
	0.098017F, 0.110222F, 0.122411F, 0.134581F, 0.146730F, 0.158858F, 0.170962F, 0.183040F, 
	0.195090F, 0.207111F, 0.219101F, 0.231058F, 0.242980F, 0.254866F, 0.266713F, 0.278520F, 
	0.290285F, 0.302006F, 0.313682F, 0.325310F, 0.336890F, 0.348419F, 0.359895F, 0.371317F, 
	0.382683F, 0.393992F, 0.405241F, 0.416430F, 0.427555F, 0.438616F, 0.449611F, 0.460539F, 
	0.471397F, 0.482184F, 0.492898F, 0.503538F, 0.514103F, 0.524590F, 0.534998F, 0.545325F, 
	0.555570F, 0.565732F, 0.575808F, 0.585798F, 0.595699F, 0.605511F, 0.615232F, 0.624859F, 
	0.634393F, 0.643832F, 0.653173F, 0.662416F, 0.671559F, 0.680601F, 0.689541F, 0.698376F, 
	0.707107F, 0.715731F, 0.724247F, 0.732654F, 0.740951F, 0.749136F, 0.757209F, 0.765167F, 
	0.773010F, 0.780737F, 0.788346F, 0.795837F, 0.803208F, 0.810457F, 0.817585F, 0.824589F, 
	0.831470F, 0.838225F, 0.844854F, 0.851355F, 0.857729F, 0.863973F, 0.870087F, 0.876070F, 
	0.881921F, 0.887640F, 0.893224F, 0.898674F, 0.903989F, 0.909168F, 0.914210F, 0.919114F, 
	0.923880F, 0.928506F, 0.932993F, 0.937339F, 0.941544F, 0.945607F, 0.949528F, 0.953306F, 
	0.956940F, 0.960431F, 0.963776F, 0.966976F, 0.970031F, 0.972940F, 0.975702F, 0.978317F, 
	0.980785F, 0.983105F, 0.985278F, 0.987301F, 0.989177F, 0.990903F, 0.992480F, 0.993907F, 
	0.995185F, 0.996313F, 0.997290F, 0.998118F, 0.998795F, 0.999322F, 0.999699F, 0.999925F 
}; 

const tt_uint8 tt_audio_base::TT_MAX_NUM_CHANNELS = 16;




// CLASS IMPLEMENTATION

// Constructor for this base class: do initialization, etc.
tt_audio_base::tt_audio_base(void)
{
	set_sr(global_sr);						// Init the local sr to the global sr
	set_vectorsize(global_vectorsize);		// Init the local vs to the global vs
}


// DESTRUCTOR
tt_audio_base::~tt_audio_base()
{
	;
}


// ATTRIBUTE: global sample rate
void tt_audio_base::set_global_sr(const tt_atom &value)
{
	global_sr = value;
}

void tt_audio_base::get_global_sr(tt_atom &value)
{
	value = global_sr;
}


// ATTRIBUTE: local sample rate (intended for use by inherited objects)
void tt_audio_base::set_sr(const tt_atom &value)
{
	sr = value;
	r_sr = 1.0 / sr;
	m_sr = sr * 0.001;
}

void tt_audio_base::get_sr(tt_atom &value)
{
	value = sr;
}


// ATTRIBUTE: global vector size
void tt_audio_base::set_global_vectorsize(const tt_atom &value)
{
	global_vectorsize = value;
}

void tt_audio_base::get_global_vectorsize(tt_atom &value)
{
	value = global_vectorsize;
}


// ATTRIBUTE: local vector size (intended for use by inherited objects)
void tt_audio_base::set_vectorsize(const tt_atom &value)
{
	vectorsize = value;
}

void tt_audio_base::get_vectorsize(tt_atom &value)
{
	value = vectorsize;
}


// Attempt to knock out denormalized floats; TT_INLINEd here for speed
TT_INLINE double tt_audio_base::anti_denormal(double value)
{
#ifndef TT_DISABLE_DENORMAL_FIX		// Define this to test code without denormal fixing
	value += anti_denormal_value;
	value -= anti_denormal_value;
#endif
	return(value);
}


// UTILITIES (all TT_INLINEd here for speed)

// RADIANS CONVERSIONS: cannot make static because of access to a member data element
// hz-to-radians conversion
TT_INLINE double tt_audio_base::hertz_to_radians(const double hz)	// NOTE: Be sure to set the sr before calling this function
{
	return(hz * (pi / (sr * 0.5)));
}

// radians-to-hz conversion
TT_INLINE double tt_audio_base::radians_to_hertz(const double radians)	// NOTE: Be sure to set the sr before calling this function
{
	return((radians * sr) / twopi);
}

// degrees-to-radians conversion
TT_INLINE double tt_audio_base::degrees_to_radians(const double degrees)
{
	return((degrees * pi) / 180.);
}

// radians-to-degrees conversion
TT_INLINE double tt_audio_base::radians_to_degrees(const double radians)
{
	return((radians * 180.) / pi);	
}


// Decay Time (seconds) to feedback coefficient conversion
TT_INLINE float tt_audio_base::decay_to_feedback(const float decay_time, float delay)
{
	float 	fb;					// variable for our result		
	delay = delay * 0.001;		// convert delay from milliseconds to seconds
	if(decay_time < 0){
		fb = delay / -decay_time;
		fb = fb * -60.;		
		fb = pow(10., (fb / 20.));	
		fb *= -1.;
	}
	else{
		fb = delay / decay_time;
		fb = fb * -60.;				
		fb = pow(10., (fb / 20.));		
	}		
	return(fb);			
}

// return the decay time based on the feedback coefficient
TT_INLINE float tt_audio_base::feedback_to_decay(const float feedback, const float delay)
{
	float 	decay_time;				// variable for our result
	
	if(feedback > 0){
		decay_time = 20. * (log10(feedback));		
		decay_time = -60.0 / decay_time;		
		decay_time = decay_time * (delay);		
	}
	else if(feedback < 0){
		decay_time = 20. * (log10(fabs(feedback)));		
		decay_time = -60.0 / decay_time;		
		decay_time = decay_time * (-delay);		
	}
	else
		decay_time = 0;

	return(decay_time);
}


// ************* DECIBEL CONVERSIONS **************

// Amplitude to decibels
TT_INLINE float tt_audio_base::amplitude_to_decibels(const float value)
{
	if(value >= 0) 
		return(20. * (log10(value)));
	else
	 	return 0;
}

// Decibels to amplitude
TT_INLINE float tt_audio_base::decibels_to_amplitude(float value)
{
	return(pow(10., (value / 20.)));
}

// Decibels to millimeters
TT_INLINE float tt_audio_base::decibels_to_millimeters(float value)
{
	if (value >= 10.)
		value = 0.; 
	else if (value > -10.) 
		value = -12./5. * (value - 10.);
	else if (value > -40.)
		value = 48. - 12./10. * (value + 10.);
	else if (value > -60.)
		value = 84. - 12./20. * (value + 40.);
	else if (value > -200.)
		value = 96. - 1./35. * (value + 60.);
	else value = 100.; 
	value = 100. - value; 

	return(value);
}

// Decibels to millimeters
TT_INLINE float tt_audio_base::millimeters_to_decibels(float value)
{
	if (value <= 0.) 
		value = -200.0;
	else if (value < 4.0)
		value = -60. - 35. * (-(value - 100) - 96.); 
	else if (value < 16.)
		value = -40. - 20./12. * (-(value - 100) - 84.); 
	else if (value < 52.)
		value = -10. - 10./12. * (-(value - 100) - 48.);
	else if (value < 100.)
		value = 10.0 - 5.0/12.0 * -(value - 100);	
	else value = 10.0; 
	
	return(value);
}

// Millimeters to amplitude
TT_INLINE float tt_audio_base::millimeters_to_amplitude(float value)
{
	value = millimeters_to_decibels(value);
	return decibels_to_amplitude(value);
}

// Amplitude to millimeters
TT_INLINE float tt_audio_base::amplitude_to_millimeters(float value)
{
	value = amplitude_to_decibels(value);
	return decibels_to_millimeters(value);
}


// extended MIDI units to decibels (127 = unity gain)
TT_INLINE float tt_audio_base::xmidi_to_decibels(float value)
{
	return (value - 127) * 0.6;
}

// decibels to extended MIDI units  (127 = unity gain)
TT_INLINE float tt_audio_base::decibels_to_xmidi(float value)
{
	return (value * 1.66666667) + 127;
}



// ************* MISC STUFF **************

// Deviate
TT_INLINE float tt_audio_base::deviate(float value)
{
	value += (2.0 * (float(rand()) / float(RAND_MAX))) - 1.0;	// randomize input with +1 to -1 ms
	value = value * 0.001 * sr;									// convert from ms to samples
	value = (float)prime(long(value));										// find the nearest prime number (in samples)
	value = (value / sr) * 1000.0;								// convert back to ms
	
	return value;
}

// Prime
TT_INLINE long tt_audio_base::prime(long value)
{
	long	candidate, last, i, isPrime;

   	if(value < 2)
  		candidate = 2;
	else if(value == 2)
		candidate = 3;
	else{
		candidate = value;
		if (candidate % 2 == 0)    						// Test only odd numbers
			candidate--;
		do{
			isPrime = true;								// Assume glorious success
			candidate += 2;               				// Bump to the next number to test
			last = long(sqrt((float)candidate));      				// We'll check to see if candidate has any factors, from 2 to last
			for (i=3; (i <= last) && isPrime; i+=2){	// Loop through odd numbers only
				if((candidate % i) == 0)
				isPrime = false;
			}
		} 
		while (!isPrime);
	}
	return candidate;
}
