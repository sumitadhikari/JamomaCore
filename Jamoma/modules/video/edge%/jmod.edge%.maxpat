{
	"patcher" : 	{
		"fileversion" : 1,
		"rect" : [ 457.0, 366.0, 1022.0, 521.0 ],
		"bglocked" : 0,
		"defrect" : [ 457.0, 366.0, 1022.0, 521.0 ],
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
					"maxclass" : "message",
					"text" : "/preset/store 1 default, /preset/write",
					"bgcolor" : [ 0.8, 0.54902, 0.54902, 1.0 ],
					"fontname" : "Verdana",
					"id" : "obj-25",
					"numinlets" : 2,
					"fontsize" : 9.873845,
					"numoutlets" : 1,
					"patching_rect" : [ 62.0, 96.0, 195.0, 16.0 ],
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "jit.pwindow",
					"id" : "obj-24",
					"numinlets" : 1,
					"presentation_rect" : [ 236.0, 22.0, 60.0, 45.0 ],
					"numoutlets" : 2,
					"patching_rect" : [ 236.0, 22.0, 60.0, 45.0 ],
					"outlettype" : [ "", "" ],
					"presentation" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "jcom.out 1",
					"fontname" : "Verdana",
					"id" : "obj-1",
					"numinlets" : 1,
					"fontsize" : 9.873845,
					"numoutlets" : 2,
					"patching_rect" : [ 141.0, 398.0, 62.0, 18.0 ],
					"outlettype" : [ "", "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "jcom.in 1",
					"fontname" : "Verdana",
					"id" : "obj-2",
					"numinlets" : 1,
					"fontsize" : 9.873845,
					"numoutlets" : 3,
					"patching_rect" : [ 191.0, 242.0, 55.0, 18.0 ],
					"outlettype" : [ "", "", "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "umenu",
					"varname" : "Algorithm",
					"pattrmode" : 1,
					"fontname" : "Verdana",
					"types" : [  ],
					"id" : "obj-3",
					"numinlets" : 1,
					"presentation_rect" : [ 89.0, 44.0, 60.0, 19.0 ],
					"fontsize" : 10.0,
					"numoutlets" : 3,
					"patching_rect" : [ 453.0, 109.0, 60.0, 19.0 ],
					"outlettype" : [ "int", "", "" ],
					"presentation" : 1,
					"items" : [ "Sobel", ",", "Prewitt", ",", "Robcross" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "pcontrol",
					"fontname" : "Verdana",
					"id" : "obj-4",
					"numinlets" : 1,
					"fontsize" : 9.873845,
					"numoutlets" : 1,
					"patching_rect" : [ 69.0, 317.0, 49.0, 18.0 ],
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "jcom.pass /open",
					"fontname" : "Verdana",
					"id" : "obj-5",
					"numinlets" : 1,
					"fontsize" : 9.873845,
					"numoutlets" : 2,
					"patching_rect" : [ 69.0, 296.0, 91.0, 18.0 ],
					"outlettype" : [ "", "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "/documentation/generate",
					"bgcolor" : [ 0.8, 0.54902, 0.54902, 1.0 ],
					"fontname" : "Verdana",
					"id" : "obj-7",
					"numinlets" : 2,
					"fontsize" : 9.873845,
					"numoutlets" : 1,
					"patching_rect" : [ 104.0, 125.0, 135.0, 16.0 ],
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"varname" : "algorithm",
					"text" : "jcom.parameter algorithm @type msg_symbol @description \"Choose the type of algorithm to use for the edge detection.\"",
					"linecount" : 2,
					"fontname" : "Verdana",
					"id" : "obj-8",
					"numinlets" : 1,
					"fontsize" : 9.873845,
					"numoutlets" : 3,
					"patching_rect" : [ 524.0, 105.0, 326.0, 30.0 ],
					"outlettype" : [ "", "", "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"varname" : "thresh",
					"text" : "jcom.parameter thresh @type msg_float @ramp/drive scheduler @description \"Edge detection threshold - pixels below the threshold are set to black.\"",
					"linecount" : 2,
					"fontname" : "Verdana",
					"id" : "obj-9",
					"numinlets" : 1,
					"fontsize" : 9.873845,
					"numoutlets" : 3,
					"patching_rect" : [ 526.0, 25.0, 401.0, 30.0 ],
					"outlettype" : [ "", "", "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"varname" : "Thresh",
					"triscale" : 0.9,
					"fontname" : "Verdana",
					"id" : "obj-11",
					"numinlets" : 1,
					"presentation_rect" : [ 89.0, 22.0, 35.0, 19.0 ],
					"triangle" : 0,
					"fontsize" : 10.0,
					"numoutlets" : 2,
					"patching_rect" : [ 455.0, 35.0, 35.0, 19.0 ],
					"outlettype" : [ "float", "bang" ],
					"presentation" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "thresh",
					"fontname" : "Verdana",
					"id" : "obj-12",
					"numinlets" : 1,
					"textcolor" : [ 0.584314, 0.584314, 0.584314, 1.0 ],
					"presentation_rect" : [ 34.0, 22.0, 41.0, 19.0 ],
					"frgb" : [ 0.584314, 0.584314, 0.584314, 1.0 ],
					"fontsize" : 10.0,
					"numoutlets" : 0,
					"patching_rect" : [ 407.0, 36.0, 41.0, 19.0 ],
					"presentation" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "algorithm",
					"fontname" : "Verdana",
					"id" : "obj-13",
					"numinlets" : 1,
					"textcolor" : [ 0.584314, 0.584314, 0.584314, 1.0 ],
					"presentation_rect" : [ 21.0, 44.0, 57.0, 19.0 ],
					"frgb" : [ 0.584314, 0.584314, 0.584314, 1.0 ],
					"fontsize" : 10.0,
					"numoutlets" : 0,
					"patching_rect" : [ 392.0, 109.0, 57.0, 19.0 ],
					"presentation" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "VIDEO OUTPUT",
					"fontname" : "Verdana",
					"id" : "obj-14",
					"numinlets" : 1,
					"frgb" : [ 0.658824, 0.658824, 0.658824, 1.0 ],
					"fontsize" : 9.873845,
					"numoutlets" : 0,
					"patching_rect" : [ 164.0, 425.0, 85.0, 18.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "outlet",
					"id" : "obj-15",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 143.0, 426.0, 13.0, 13.0 ],
					"comment" : ""
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "inlet",
					"id" : "obj-16",
					"numinlets" : 0,
					"numoutlets" : 1,
					"patching_rect" : [ 193.0, 221.0, 13.0, 13.0 ],
					"outlettype" : [ "" ],
					"comment" : ""
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "VIDEO INPUT",
					"fontname" : "Verdana",
					"id" : "obj-17",
					"numinlets" : 1,
					"frgb" : [ 0.658824, 0.658824, 0.658824, 1.0 ],
					"fontsize" : 9.873845,
					"numoutlets" : 0,
					"patching_rect" : [ 208.0, 221.0, 75.0, 18.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "jalg.edge%",
					"fontname" : "Verdana",
					"id" : "obj-18",
					"numinlets" : 2,
					"fontsize" : 9.873845,
					"numoutlets" : 1,
					"patching_rect" : [ 141.0, 371.0, 69.0, 18.0 ],
					"outlettype" : [ "jit_matrix" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "/init",
					"bgcolor" : [ 0.8, 0.54902, 0.54902, 1.0 ],
					"fontname" : "Verdana",
					"id" : "obj-19",
					"numinlets" : 2,
					"fontsize" : 9.873845,
					"numoutlets" : 1,
					"patching_rect" : [ 249.0, 125.0, 31.0, 16.0 ],
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "command input",
					"fontname" : "Verdana",
					"id" : "obj-20",
					"numinlets" : 1,
					"frgb" : [ 0.658824, 0.658824, 0.658824, 1.0 ],
					"fontsize" : 9.873845,
					"numoutlets" : 0,
					"patching_rect" : [ 20.0, 123.0, 86.0, 18.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"varname" : "jcom.hub",
					"text" : "jcom.hub jmod.edge% @size 1U-half @module_type video @algorithm_type jitter @description \"Glowing Edges Effect\"",
					"linecount" : 2,
					"fontname" : "Verdana",
					"id" : "obj-21",
					"numinlets" : 1,
					"fontsize" : 9.873845,
					"numoutlets" : 2,
					"patching_rect" : [ 6.0, 153.0, 306.0, 30.0 ],
					"outlettype" : [ "", "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "outlet",
					"id" : "obj-22",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 6.0, 210.0, 13.0, 13.0 ],
					"comment" : ""
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "inlet",
					"id" : "obj-23",
					"numinlets" : 0,
					"numoutlets" : 1,
					"patching_rect" : [ 6.0, 123.0, 13.0, 13.0 ],
					"outlettype" : [ "" ],
					"comment" : ""
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "jcom.ui",
					"text" : "/editing_this_module",
					"has_bypass" : 1,
					"has_preview" : 1,
					"id" : "obj-34",
					"numinlets" : 1,
					"presentation_rect" : [ 0.0, 0.0, 300.0, 70.0 ],
					"has_freeze" : 1,
					"numoutlets" : 1,
					"prefix" : "video",
					"outlettype" : [ "" ],
					"presentation" : 1,
					"has_mute" : 1
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"source" : [ "obj-2", 0 ],
					"destination" : [ "obj-18", 1 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-16", 0 ],
					"destination" : [ "obj-2", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-1", 0 ],
					"destination" : [ "obj-15", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-18", 0 ],
					"destination" : [ "obj-1", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-4", 0 ],
					"destination" : [ "obj-18", 0 ],
					"hidden" : 0,
					"midpoints" : [ 78.5, 356.0, 150.5, 356.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-5", 1 ],
					"destination" : [ "obj-18", 0 ],
					"hidden" : 0,
					"midpoints" : [ 150.5, 348.0, 150.5, 348.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-5", 0 ],
					"destination" : [ "obj-4", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-2", 1 ],
					"destination" : [ "obj-5", 0 ],
					"hidden" : 0,
					"midpoints" : [ 218.5, 282.0, 78.5, 282.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-21", 0 ],
					"destination" : [ "obj-22", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-19", 0 ],
					"destination" : [ "obj-21", 0 ],
					"hidden" : 0,
					"midpoints" : [ 258.5, 146.0, 15.5, 146.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-23", 0 ],
					"destination" : [ "obj-21", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-7", 0 ],
					"destination" : [ "obj-21", 0 ],
					"hidden" : 0,
					"midpoints" : [ 113.5, 144.0, 15.5, 144.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-34", 0 ],
					"destination" : [ "obj-24", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-25", 0 ],
					"destination" : [ "obj-21", 0 ],
					"hidden" : 0,
					"midpoints" : [ 71.5, 114.0, 3.0, 114.0, 3.0, 147.0, 15.5, 147.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-3", 1 ],
					"destination" : [ "obj-8", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-8", 0 ],
					"destination" : [ "obj-3", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-11", 0 ],
					"destination" : [ "obj-9", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-9", 0 ],
					"destination" : [ "obj-11", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
 ]
	}

}
