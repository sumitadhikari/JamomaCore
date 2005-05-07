/*
 *******************************************************
 *		FOUR POLE LOWPASS FILTER
 *		based on moog-variation2, musicdsp.org
 *******************************************************
 *		taptools_audio object
 *		copyright � 2003 by Timothy A. Place
 *
 */

// Check against redundant including
#ifndef TAP_LOWPASS_FOURPOLE_H
#define TAP_LOWPASS_FOURPOLE_H

// Include appropriate headers
#include "taptools_base.h"


/********************************************************
	CLASS INTERFACE/IMPLEMENTATION

	The entire class is implemented inline for speed.
 ********************************************************/

class tap_lowpass_fourpole:public taptools_audio{

	private:
		tt_attribute_value 	resonance;
		tt_attribute_value		frequency;
		double				c, res;			// c = cutoff [0.0 to 1.0], res = resonance [0.0 to 4.0]
		double				in[4], out[4];
		double 				f, fb;
	
	
	public:
		enum selectors{								
			num_poles = 4,
			
			k_resonance,							// Attribute Selectors
			k_frequency
		};
		

		// OBJECT LIFE					
		tap_lowpass_fourpole()								// Constructor		
		{
			set_attr(k_frequency, 4000.0);	
			set_attr(k_resonance, 4.0);	
			clear();
		}

		~tap_lowpass_fourpole()								// Destructor
		{
			;
		}


		// ATTRIBUTES
		void set_attr(tt_selector sel, tt_attribute_value val)	// Set Attributes
		{
			switch (sel){			
				case k_frequency:
					frequency = val;
					c = (val * 2.0) / sr;
					f = c * 1.16;
					fb = res * (1.0 - 0.15 * (f * f));
					break;
				case k_resonance:
					resonance = val;
					res = 4.0 * (val * 0.1);
					fb = res * (1.0 - 0.15 * (f * f)); 			
					break;
			}
		}

		tt_attribute_value get_attr(tt_selector sel)				// Get Attributes
		{
			switch (sel){
				case k_frequency:
					return frequency;
				case k_resonance:
					return resonance;
				default:
					return 0.0;
			}
		}
		
		
		// DSP LOOP
		void dsp_vector_calc(tt_audio_signal *input, tt_audio_signal *output)
		{
			tt_sample_value temp;
			temp_vs = input->vectorsize;
			
			while(temp_vs--){
				temp = *input->vector++;
				
				temp -= out[3] * fb; 
				temp *= 0.35013 * ((f * f) * (f * f)); 
				out[0] = temp + 0.3 * in[0] + (1 - f) * out[0]; 
				in[0] = temp; 
				out[1] = out[0] + 0.3 * in[1] + (1 - f) * out[1]; 
				in[1] = out[0]; 
				out[2] = out[1] + 0.3 * in[2] + (1 - f) * out[2]; 
				in[2] = out[1]; 
				out[3] = out[2] + 0.3 * in[3] + (1 - f) * out[3]; 
				in[3] = out[2]; 
				temp = out[3];
								
				*output->vector++ = temp;
			}
			input->reset(); output->reset();
		}


		// clear
		void clear()
		{
			short i;
			
			for(i=0; i < num_poles; i++){
				in[i] = 0.0;
				out[i] = 0.0;
			}
		}
		
};


#endif	// TAP_LOWPASS_FOURPOLE_H