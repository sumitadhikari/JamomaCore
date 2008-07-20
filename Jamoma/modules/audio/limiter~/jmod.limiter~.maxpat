{
	"patcher" : 	{
		"fileversion" : 1,
		"rect" : [ 7.0, 73.0, 921.0, 687.0 ],
		"bglocked" : 0,
		"defrect" : [ 7.0, 73.0, 921.0, 687.0 ],
		"openrect" : [ 0.0, 0.0, 0.0, 0.0 ],
		"openinpresentation" : 1,
		"default_fontsize" : 10.970939,
		"default_fontface" : 0,
		"default_fontname" : "Verdana",
		"gridonopen" : 0,
		"gridsize" : [ 5.0, 5.0 ],
		"gridsnaponopen" : 0,
		"toolbarvisible" : 1,
		"boxanimatetime" : 200,
		"imprint" : 0,
		"metadata" : [  ],
		"boxes" : [ 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "jcom.meter_receive 2",
					"numoutlets" : 1,
					"fontname" : "Verdana",
					"outlettype" : [ "" ],
					"fontsize" : 10.970939,
					"patching_rect" : [ 644.0, 53.0, 152.0, 20.0 ],
					"numinlets" : 0,
					"id" : "obj-51"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "jcom.meter_receive 1",
					"numoutlets" : 1,
					"fontname" : "Verdana",
					"outlettype" : [ "" ],
					"fontsize" : 10.970939,
					"patching_rect" : [ 639.0, 8.0, 152.0, 20.0 ],
					"numinlets" : 0,
					"id" : "obj-8"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "jcom.meter~",
					"numoutlets" : 0,
					"presentation_rect" : [ 152.0, 10.0, 80.0, 4.0 ],
					"patching_rect" : [ 549.0, 83.0, 80.0, 4.0 ],
					"numinlets" : 1,
					"presentation" : 1,
					"id" : "obj-50"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "jcom.meter~",
					"numoutlets" : 0,
					"presentation_rect" : [ 152.0, 5.0, 80.0, 4.0 ],
					"patching_rect" : [ 544.0, 38.0, 80.0, 4.0 ],
					"numinlets" : 1,
					"presentation" : 1,
					"id" : "obj-49"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "tt.limiter~",
					"numoutlets" : 3,
					"fontname" : "Verdana",
					"outlettype" : [ "signal", "signal", "" ],
					"fontsize" : 9.873845,
					"patching_rect" : [ 380.0, 118.0, 72.0, 18.0 ],
					"numinlets" : 2,
					"id" : "obj-1"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "inlet",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 514.0, 66.0, 15.0, 15.0 ],
					"numinlets" : 0,
					"id" : "obj-2",
					"comment" : ""
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "inlet",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 380.0, 66.0, 15.0, 15.0 ],
					"numinlets" : 0,
					"id" : "obj-3",
					"comment" : ""
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "jcom.out~ 2",
					"numoutlets" : 3,
					"fontname" : "Verdana",
					"outlettype" : [ "signal", "signal", "" ],
					"fontsize" : 9.873845,
					"patching_rect" : [ 380.0, 149.0, 70.0, 18.0 ],
					"numinlets" : 2,
					"id" : "obj-4"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "jcom.in~ 2",
					"numoutlets" : 4,
					"fontname" : "Verdana",
					"outlettype" : [ "signal", "signal", "", "" ],
					"fontsize" : 9.873845,
					"patching_rect" : [ 380.0, 88.0, 144.0, 18.0 ],
					"numinlets" : 2,
					"id" : "obj-5"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "/documentation/generate",
					"numoutlets" : 1,
					"fontname" : "Verdana",
					"outlettype" : [ "" ],
					"fontsize" : 9.873845,
					"patching_rect" : [ 141.0, 123.0, 135.0, 16.0 ],
					"numinlets" : 2,
					"id" : "obj-6"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "umenu",
					"varname" : "Mode",
					"numoutlets" : 3,
					"labelclick" : 1,
					"fontname" : "Verdana",
					"outlettype" : [ "int", "", "" ],
					"presentation_rect" : [ 203.0, 49.0, 87.0, 19.0 ],
					"items" : [ "exponential", ",", "linear" ],
					"fontsize" : 10.0,
					"types" : [  ],
					"patching_rect" : [ 69.0, 607.0, 87.0, 19.0 ],
					"numinlets" : 1,
					"presentation" : 1,
					"id" : "obj-7"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"varname" : "Preamp",
					"numoutlets" : 2,
					"triangle" : 0,
					"fontname" : "Verdana",
					"outlettype" : [ "float", "bang" ],
					"triscale" : 0.9,
					"presentation_rect" : [ 64.0, 19.0, 48.0, 19.0 ],
					"fontsize" : 10.0,
					"patching_rect" : [ 69.0, 251.0, 48.0, 19.0 ],
					"numinlets" : 1,
					"presentation" : 1,
					"id" : "obj-9"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"varname" : "mode",
					"text" : "jcom.parameter mode @repetitions/allow 0 @type msg_symbol @description \"Set the function to be used for calculating the scaling. Possible values: exponential | linear\"",
					"linecount" : 2,
					"numoutlets" : 3,
					"fontname" : "Verdana",
					"outlettype" : [ "", "", "" ],
					"fontsize" : 9.873845,
					"patching_rect" : [ 70.0, 630.0, 441.0, 30.0 ],
					"numinlets" : 1,
					"id" : "obj-16"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"varname" : "release",
					"text" : "jcom.parameter release @type msg_float @range/bounds 0 500 @range/clipmode low @dataspace time @dataspace/unit/native ms @dataspace/unit/active ms @ramp/drive scheduler @description \"The release time (ms).\"",
					"linecount" : 2,
					"numoutlets" : 3,
					"fontname" : "Verdana",
					"outlettype" : [ "", "", "" ],
					"fontsize" : 9.873845,
					"patching_rect" : [ 69.0, 561.0, 601.0, 30.0 ],
					"numinlets" : 1,
					"id" : "obj-17"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"varname" : "lookahead",
					"text" : "jcom.parameter lookahead @type msg_int @range/bounds 0 256 @range/clipmode both @ramp/drive scheduler @repetitions/allow 0 @dataspace time @dataspace/unit/native sample @dataspace/unit/active sample @description \"The number of samples (up to 256) to look ahead into the signal to see what is coming.\"",
					"linecount" : 3,
					"numoutlets" : 3,
					"fontname" : "Verdana",
					"outlettype" : [ "", "", "" ],
					"fontsize" : 9.873845,
					"patching_rect" : [ 69.0, 487.0, 650.0, 42.0 ],
					"numinlets" : 1,
					"id" : "obj-18"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"varname" : "threshold",
					"text" : "jcom.parameter threshold @type msg_float @range/bounds -48 6 @range/clipmode none @ramp/drive scheduler @dataspace gain @dataspace/unit/native dB @dataspace/unit/active dB @description \"The limiter threshold (in dB below full scale). When the input signal level exceeds this threshold, it will be attenuated as necessary to keep the level below the threshold.\"",
					"linecount" : 3,
					"numoutlets" : 3,
					"fontname" : "Verdana",
					"outlettype" : [ "", "", "" ],
					"fontsize" : 9.873845,
					"patching_rect" : [ 69.0, 401.0, 647.0, 42.0 ],
					"numinlets" : 1,
					"id" : "obj-19"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"varname" : "postamp",
					"text" : "jcom.parameter postamp @type msg_float @range/bounds -6 48 @range/clipmode none @dataspace gain @dataspace/unit/native dB @dataspace/unit/active dB @ramp/drive scheduler @description \"The gain in dB applied to the signal after limiting. \"",
					"linecount" : 2,
					"numoutlets" : 3,
					"fontname" : "Verdana",
					"outlettype" : [ "", "", "" ],
					"fontsize" : 9.873845,
					"patching_rect" : [ 69.0, 339.0, 666.0, 30.0 ],
					"numinlets" : 1,
					"id" : "obj-20"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"varname" : "preamp",
					"text" : "jcom.parameter preamp @type msg_float @range/bounds -6 48 @range/clipmode none @ramp/drive scheduler @dataspace gain @dataspace/unit/active dB @dataspace/unit/native dB @ramp/function linear @description \"The gain in dB applied to the signal before limiting.\"",
					"linecount" : 2,
					"numoutlets" : 3,
					"fontname" : "Verdana",
					"outlettype" : [ "", "", "" ],
					"fontsize" : 9.873845,
					"patching_rect" : [ 69.0, 274.0, 730.0, 30.0 ],
					"numinlets" : 1,
					"id" : "obj-21"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "number",
					"varname" : "Lookahead",
					"numoutlets" : 2,
					"triangle" : 0,
					"maximum" : 256,
					"fontname" : "Verdana",
					"outlettype" : [ "int", "bang" ],
					"triscale" : 0.9,
					"presentation_rect" : [ 203.0, 19.0, 35.0, 18.0 ],
					"fontsize" : 9.873845,
					"patching_rect" : [ 69.0, 464.0, 35.0, 18.0 ],
					"numinlets" : 1,
					"presentation" : 1,
					"minimum" : 0,
					"id" : "obj-22"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"varname" : "Release",
					"numoutlets" : 2,
					"triangle" : 0,
					"fontname" : "Verdana",
					"outlettype" : [ "float", "bang" ],
					"triscale" : 0.9,
					"presentation_rect" : [ 203.0, 33.0, 36.0, 18.0 ],
					"fontsize" : 9.873845,
					"patching_rect" : [ 69.0, 540.0, 36.0, 18.0 ],
					"numinlets" : 1,
					"presentation" : 1,
					"minimum" : 0.0,
					"id" : "obj-23"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"varname" : "Threshold",
					"numoutlets" : 2,
					"triangle" : 0,
					"fontname" : "Verdana",
					"outlettype" : [ "float", "bang" ],
					"triscale" : 0.9,
					"presentation_rect" : [ 64.0, 49.0, 48.0, 19.0 ],
					"fontsize" : 10.0,
					"patching_rect" : [ 69.0, 378.0, 48.0, 19.0 ],
					"numinlets" : 1,
					"presentation" : 1,
					"id" : "obj-24"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "dB",
					"numoutlets" : 0,
					"fontname" : "Verdana",
					"presentation_rect" : [ 109.0, 49.0, 22.0, 19.0 ],
					"fontsize" : 10.0,
					"patching_rect" : [ 114.0, 49.0, 22.0, 19.0 ],
					"numinlets" : 1,
					"presentation" : 1,
					"id" : "obj-25",
					"frgb" : [ 0.0, 0.0, 0.0, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"varname" : "Postamp",
					"numoutlets" : 2,
					"triangle" : 0,
					"fontname" : "Verdana",
					"outlettype" : [ "float", "bang" ],
					"triscale" : 0.9,
					"presentation_rect" : [ 64.0, 34.0, 48.0, 19.0 ],
					"fontsize" : 10.0,
					"patching_rect" : [ 69.0, 317.0, 48.0, 19.0 ],
					"numinlets" : 1,
					"presentation" : 1,
					"id" : "obj-26"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "dB",
					"numoutlets" : 0,
					"fontname" : "Verdana",
					"presentation_rect" : [ 109.0, 34.0, 22.0, 19.0 ],
					"fontsize" : 10.0,
					"patching_rect" : [ 114.0, 34.0, 22.0, 19.0 ],
					"numinlets" : 1,
					"presentation" : 1,
					"id" : "obj-27",
					"frgb" : [ 0.0, 0.0, 0.0, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "dB",
					"numoutlets" : 0,
					"fontname" : "Verdana",
					"presentation_rect" : [ 109.0, 19.0, 22.0, 19.0 ],
					"fontsize" : 10.0,
					"patching_rect" : [ 114.0, 19.0, 22.0, 19.0 ],
					"numinlets" : 1,
					"presentation" : 1,
					"id" : "obj-28",
					"frgb" : [ 0.0, 0.0, 0.0, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "ms",
					"numoutlets" : 0,
					"fontname" : "Verdana",
					"presentation_rect" : [ 239.0, 33.0, 53.0, 19.0 ],
					"fontsize" : 10.0,
					"patching_rect" : [ 239.0, 34.0, 53.0, 19.0 ],
					"numinlets" : 1,
					"presentation" : 1,
					"id" : "obj-29",
					"frgb" : [ 0.0, 0.0, 0.0, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "samples",
					"numoutlets" : 0,
					"fontname" : "Verdana",
					"presentation_rect" : [ 239.0, 19.0, 54.0, 19.0 ],
					"fontsize" : 10.0,
					"patching_rect" : [ 239.0, 19.0, 54.0, 19.0 ],
					"numinlets" : 1,
					"presentation" : 1,
					"id" : "obj-30",
					"frgb" : [ 0.0, 0.0, 0.0, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Mode",
					"numoutlets" : 0,
					"fontname" : "Verdana",
					"presentation_rect" : [ 142.0, 50.0, 52.0, 19.0 ],
					"fontsize" : 10.0,
					"patching_rect" : [ 142.0, 49.0, 52.0, 19.0 ],
					"numinlets" : 1,
					"presentation" : 1,
					"id" : "obj-31",
					"frgb" : [ 0.0, 0.0, 0.0, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Release",
					"numoutlets" : 0,
					"fontname" : "Verdana",
					"presentation_rect" : [ 142.0, 34.0, 53.0, 19.0 ],
					"fontsize" : 10.0,
					"patching_rect" : [ 142.0, 34.0, 53.0, 19.0 ],
					"numinlets" : 1,
					"presentation" : 1,
					"id" : "obj-32",
					"frgb" : [ 0.0, 0.0, 0.0, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Lookahead",
					"numoutlets" : 0,
					"fontname" : "Verdana",
					"presentation_rect" : [ 142.0, 19.0, 63.0, 19.0 ],
					"fontsize" : 10.0,
					"patching_rect" : [ 142.0, 19.0, 63.0, 19.0 ],
					"numinlets" : 1,
					"presentation" : 1,
					"id" : "obj-33",
					"frgb" : [ 0.0, 0.0, 0.0, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Threshold",
					"numoutlets" : 0,
					"fontname" : "Verdana",
					"presentation_rect" : [ 4.0, 49.0, 58.0, 19.0 ],
					"fontsize" : 10.0,
					"patching_rect" : [ 4.0, 49.0, 58.0, 19.0 ],
					"numinlets" : 1,
					"presentation" : 1,
					"id" : "obj-34",
					"frgb" : [ 0.0, 0.0, 0.0, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Postamp",
					"numoutlets" : 0,
					"fontname" : "Verdana",
					"presentation_rect" : [ 4.0, 34.0, 51.0, 19.0 ],
					"fontsize" : 10.0,
					"patching_rect" : [ 4.0, 34.0, 51.0, 19.0 ],
					"numinlets" : 1,
					"presentation" : 1,
					"id" : "obj-35",
					"frgb" : [ 0.0, 0.0, 0.0, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Preamp",
					"numoutlets" : 0,
					"fontname" : "Verdana",
					"presentation_rect" : [ 4.0, 19.0, 51.0, 19.0 ],
					"fontsize" : 10.0,
					"patching_rect" : [ 4.0, 19.0, 51.0, 19.0 ],
					"numinlets" : 1,
					"presentation" : 1,
					"id" : "obj-36",
					"frgb" : [ 0.0, 0.0, 0.0, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "command input",
					"numoutlets" : 0,
					"fontname" : "Verdana",
					"fontsize" : 9.873845,
					"patching_rect" : [ 51.0, 124.0, 86.0, 18.0 ],
					"numinlets" : 1,
					"id" : "obj-37",
					"frgb" : [ 0.0, 0.0, 0.0, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "inlet",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 37.0, 124.0, 15.0, 15.0 ],
					"numinlets" : 0,
					"id" : "obj-38",
					"comment" : ""
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "/init",
					"numoutlets" : 1,
					"fontname" : "Verdana",
					"outlettype" : [ "" ],
					"fontsize" : 9.873845,
					"patching_rect" : [ 277.330139, 123.0, 37.0, 16.0 ],
					"numinlets" : 2,
					"id" : "obj-39"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "outlet",
					"numoutlets" : 0,
					"patching_rect" : [ 380.0, 175.0, 15.0, 15.0 ],
					"numinlets" : 1,
					"id" : "obj-40",
					"comment" : ""
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"varname" : "jcom.hub",
					"text" : "jcom.hub @module_type audio @description \"A stereo limiter\"",
					"linecount" : 2,
					"numoutlets" : 2,
					"fontname" : "Verdana",
					"outlettype" : [ "", "" ],
					"fontsize" : 9.873845,
					"patching_rect" : [ 37.0, 152.0, 270.0, 30.0 ],
					"numinlets" : 1,
					"id" : "obj-41"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "----signal inputs----",
					"numoutlets" : 0,
					"fontname" : "Verdana",
					"fontsize" : 9.873845,
					"patching_rect" : [ 409.0, 68.0, 113.0, 18.0 ],
					"numinlets" : 1,
					"id" : "obj-42",
					"frgb" : [ 0.0, 0.0, 0.0, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "outlet",
					"numoutlets" : 0,
					"patching_rect" : [ 37.0, 193.0, 15.0, 15.0 ],
					"numinlets" : 1,
					"id" : "obj-43",
					"comment" : ""
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "outlet",
					"numoutlets" : 0,
					"patching_rect" : [ 407.0, 175.0, 15.0, 15.0 ],
					"numinlets" : 1,
					"id" : "obj-44",
					"comment" : ""
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "---signal outputs---",
					"numoutlets" : 0,
					"fontname" : "Verdana",
					"fontsize" : 9.873845,
					"patching_rect" : [ 361.0, 191.0, 105.0, 18.0 ],
					"numinlets" : 1,
					"id" : "obj-45",
					"frgb" : [ 0.0, 0.0, 0.0, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "jcom.ui",
					"text" : "/editing_this_module",
					"numoutlets" : 1,
					"has_bypass" : 1,
					"outlettype" : [ "" ],
					"has_gain" : 1,
					"presentation_rect" : [ 0.0, 0.0, 300.0, 70.0 ],
					"has_mix" : 1,
					"fontsize" : 12.068032,
					"numinlets" : 1,
					"presentation" : 1,
					"has_mute" : 1,
					"prefix" : "audio",
					"id" : "obj-46"
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"source" : [ "obj-20", 0 ],
					"destination" : [ "obj-26", 0 ],
					"hidden" : 0,
					"midpoints" : [ 78.5, 371.0, 54.0, 371.0, 54.0, 312.0, 78.5, 312.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-26", 0 ],
					"destination" : [ "obj-20", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-19", 0 ],
					"destination" : [ "obj-24", 0 ],
					"hidden" : 0,
					"midpoints" : [ 78.5, 444.0, 54.0, 444.0, 54.0, 375.0, 78.5, 375.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-24", 0 ],
					"destination" : [ "obj-19", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-22", 0 ],
					"destination" : [ "obj-18", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-18", 0 ],
					"destination" : [ "obj-22", 0 ],
					"hidden" : 0,
					"midpoints" : [ 78.5, 531.0, 54.0, 531.0, 54.0, 459.0, 78.5, 459.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-2", 0 ],
					"destination" : [ "obj-5", 1 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-5", 1 ],
					"destination" : [ "obj-1", 1 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-1", 1 ],
					"destination" : [ "obj-4", 1 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-4", 1 ],
					"destination" : [ "obj-44", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-4", 0 ],
					"destination" : [ "obj-40", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-1", 0 ],
					"destination" : [ "obj-4", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-5", 0 ],
					"destination" : [ "obj-1", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-5", 2 ],
					"destination" : [ "obj-1", 0 ],
					"hidden" : 0,
					"midpoints" : [ 472.833344, 111.0, 389.5, 111.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-3", 0 ],
					"destination" : [ "obj-5", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-7", 1 ],
					"destination" : [ "obj-16", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-16", 0 ],
					"destination" : [ "obj-7", 0 ],
					"hidden" : 0,
					"midpoints" : [ 79.5, 666.0, 54.0, 666.0, 54.0, 603.0, 78.5, 603.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-23", 0 ],
					"destination" : [ "obj-17", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-17", 0 ],
					"destination" : [ "obj-23", 0 ],
					"hidden" : 0,
					"midpoints" : [ 78.5, 591.0, 54.0, 591.0, 54.0, 537.0, 78.5, 537.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-21", 0 ],
					"destination" : [ "obj-9", 0 ],
					"hidden" : 0,
					"midpoints" : [ 78.5, 306.0, 54.0, 306.0, 54.0, 246.0, 78.5, 246.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-9", 0 ],
					"destination" : [ "obj-21", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-8", 0 ],
					"destination" : [ "obj-49", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-51", 0 ],
					"destination" : [ "obj-50", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-41", 0 ],
					"destination" : [ "obj-43", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-39", 0 ],
					"destination" : [ "obj-41", 0 ],
					"hidden" : 0,
					"midpoints" : [ 286.830139, 148.0, 46.5, 148.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-6", 0 ],
					"destination" : [ "obj-41", 0 ],
					"hidden" : 0,
					"midpoints" : [ 150.5, 146.0, 46.5, 146.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-38", 0 ],
					"destination" : [ "obj-41", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
 ]
	}

}
