{
	"patcher" : 	{
		"fileversion" : 1,
		"rect" : [ 398.0, 73.0, 303.0, 163.0 ],
		"bglocked" : 0,
		"defrect" : [ 398.0, 73.0, 303.0, 163.0 ],
		"openrect" : [ 0.0, 0.0, 0.0, 0.0 ],
		"openinpresentation" : 0,
		"default_fontsize" : 10.0,
		"default_fontface" : 0,
		"default_fontname" : "Arial",
		"gridonopen" : 0,
		"gridsize" : [ 5.0, 5.0 ],
		"gridsnaponopen" : 0,
		"toolbarvisible" : 1,
		"boxanimatetime" : 200,
		"imprint" : 0,
		"metadata" : [  ],
		"boxes" : [ 			{
				"box" : 				{
					"maxclass" : "outlet",
					"id" : "obj-13",
					"patching_rect" : [ 20.0, 65.0, 16.0, 16.0 ],
					"numinlets" : 1,
					"numoutlets" : 0,
					"comment" : ""
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "p name",
					"fontname" : "Arial",
					"outlettype" : [ "" ],
					"id" : "obj-12",
					"patching_rect" : [ 190.0, 25.0, 48.0, 19.0 ],
					"fontsize" : 11.0,
					"numinlets" : 0,
					"numoutlets" : 1,
					"patcher" : 					{
						"fileversion" : 1,
						"rect" : [ 0.0, 0.0, 640.0, 480.0 ],
						"bglocked" : 0,
						"defrect" : [ 0.0, 0.0, 640.0, 480.0 ],
						"openrect" : [ 0.0, 0.0, 0.0, 0.0 ],
						"openinpresentation" : 0,
						"default_fontsize" : 10.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"gridonopen" : 0,
						"gridsize" : [ 5.0, 5.0 ],
						"gridsnaponopen" : 0,
						"toolbarvisible" : 1,
						"boxanimatetime" : 200,
						"imprint" : 0,
						"metadata" : [  ],
						"boxes" : [ 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "prepend name",
									"fontname" : "Arial",
									"outlettype" : [ "" ],
									"id" : "obj-9",
									"patching_rect" : [ 50.0, 175.0, 75.0, 18.0 ],
									"fontsize" : 10.0,
									"numinlets" : 1,
									"numoutlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "loadbang",
									"fontname" : "Arial",
									"outlettype" : [ "bang" ],
									"id" : "obj-8",
									"patching_rect" : [ 245.0, 100.0, 52.0, 18.0 ],
									"fontsize" : 10.0,
									"numinlets" : 1,
									"numoutlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "combine /amplitude/follower. 1 @triggers 1",
									"fontname" : "Arial",
									"outlettype" : [ "", "" ],
									"id" : "obj-4",
									"patching_rect" : [ 50.0, 145.0, 214.0, 18.0 ],
									"fontsize" : 10.0,
									"numinlets" : 2,
									"numoutlets" : 2
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "#1",
									"fontname" : "Arial",
									"outlettype" : [ "" ],
									"id" : "obj-3",
									"patching_rect" : [ 245.0, 125.0, 50.0, 16.0 ],
									"fontsize" : 10.0,
									"numinlets" : 2,
									"numoutlets" : 1
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "outlet",
									"id" : "obj-11",
									"patching_rect" : [ 55.0, 253.0, 25.0, 25.0 ],
									"numinlets" : 1,
									"numoutlets" : 0,
									"comment" : ""
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"source" : [ "obj-3", 0 ],
									"destination" : [ "obj-4", 1 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-4", 0 ],
									"destination" : [ "obj-9", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-8", 0 ],
									"destination" : [ "obj-3", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-9", 0 ],
									"destination" : [ "obj-11", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
 ]
					}
,
					"saved_object_attributes" : 					{
						"fontname" : "Arial",
						"default_fontface" : 0,
						"globalpatchername" : "",
						"default_fontname" : "Arial",
						"fontface" : 0,
						"fontsize" : 10.0,
						"default_fontsize" : 10.0
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "jcom.return /amplitude/follower @range/bounds 0. 1. @dataspace gain @description \"instant amplitude of the signal number #1\"",
					"linecount" : 4,
					"fontname" : "Verdana",
					"outlettype" : [ "", "" ],
					"id" : "obj-1",
					"patching_rect" : [ 40.0, 65.0, 216.0, 60.0 ],
					"fontsize" : 10.970939,
					"numinlets" : 1,
					"numoutlets" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "jcom.remote #1__meter__",
					"fontname" : "Verdana",
					"outlettype" : [ "", "" ],
					"id" : "obj-52",
					"patching_rect" : [ 20.0, 25.0, 161.0, 20.0 ],
					"fontsize" : 10.970939,
					"numinlets" : 1,
					"numoutlets" : 2
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"source" : [ "obj-52", 0 ],
					"destination" : [ "obj-13", 0 ],
					"hidden" : 0,
					"midpoints" : [ 29.5, 57.0, 29.5, 57.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-52", 0 ],
					"destination" : [ "obj-1", 0 ],
					"hidden" : 0,
					"midpoints" : [ 29.5, 56.0, 49.5, 56.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-12", 0 ],
					"destination" : [ "obj-1", 0 ],
					"hidden" : 0,
					"midpoints" : [ 199.5, 43.0, 199.0, 43.0, 199.0, 56.0, 49.0, 56.0, 49.0, 62.0, 49.5, 62.0 ]
				}

			}
 ]
	}

}
