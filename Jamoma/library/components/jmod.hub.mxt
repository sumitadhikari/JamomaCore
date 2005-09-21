max v2;
#N vpatcher 88 124 943 638;
#P origin 116 0;
#P window setfont "Sans Serif" 9.;
#P window linecount 1;
#P newex 668 356 126 9109513 send $1_freeze_display;
#P toggle 766 329 15 0;
#P window linecount 3;
#P newex 489 279 316 9109513 jmod.parameter $1 disable_ui_updates @type toggle @description "Turn off the updating of user interface elements when parameters change.  This may be done to conserve CPU resources.";
#P objectname jmod.parameter;
#P window linecount 1;
#N vpatcher 308 81 1004 496;
#P window setfont "Sans Serif" 9.;
#P window linecount 0;
#P newex 283 193 134 9109513 prepend module_description;
#P newex 283 170 160 9109513 route description;
#P newex 460 175 65 9109513 prepend title;
#P newex 283 147 364 9109513 route ATTRIBUTES MODULE_TITLE;
#P newex 283 121 93 9109513 r $1_FROM_MHUB;
#P inlet 70 46 15 0;
#P newex 70 83 20 9109513 t b;
#P window linecount 1;
#P newex 359 298 40 9109513 text;
#P newex 70 253 299 9109513 js jmod.js_docmaker.js;
#P newex 145 121 129 9109513 r $1_register_doc;
#P newex 143 332 118 9109513 s $1_query_doc;
#P newex 143 311 68 9109513 route symbol;
#N coll $1_registered_parameters 1;
#P newobj 70 283 229 9109513 coll $1_registered_parameters 1;
#P connect 7 0 6 0;
#P fasten 11 1 4 0 438 234 75 234;
#P fasten 10 0 4 0 465 234 75 234;
#P fasten 3 0 4 0 150 165 75 165;
#P connect 6 0 4 0;
#P fasten 12 0 4 0 288 234 75 234;
#P connect 4 0 0 0;
#P connect 0 1 1 0;
#P connect 1 0 2 0;
#P connect 8 0 9 0;
#P connect 9 0 11 0;
#P connect 11 0 12 0;
#P connect 4 1 5 0;
#P connect 9 1 10 0;
#P pop;
#P newobj 176 110 51 9109513 p autodoc;
#P window linecount 2;
#P newex 125 219 273 9109513 patcherargs @size 1U @library_type poly @module_type audio @skin default @description "no info provided";
#P window linecount 1;
#N vpatcher 24 74 846 293;
#P window setfont "Sans Serif" 9.;
#P window linecount 1;
#P newex 56 124 35 9109513 t open;
#P window linecount 2;
#P newex 56 61 596 9109513 jmod.message.mxt $1 view_internals @type n/a @range n/a @description "Attempts to open the internal algorithm for viewing.  This works for most modules.  Some modules may choose to cloak the algorithms - preventing this message from functioning";
#P outlet 56 152 15 0;
#P fasten 1 1 2 0 647 103 61 103;
#P connect 2 0 0 0;
#P pop;
#P newobj 255 426 85 9109513 p view_internals;
#N vpatcher 644 337 1062 634;
#P window setfont "Sans Serif" 9.;
#P newex 123 92 200 9109513 loadmess $2;
#P inlet 68 92 15 0;
#P window linecount 1;
#P newex 68 146 114 9109513 prepend MODULE_TITLE;
#P newex 68 197 93 9109513 s $1_FROM_MHUB;
#P window linecount 0;
#P comment 67 47 210 9109513 set title of module in top bar of gui;
#P connect 3 0 2 0;
#P connect 4 0 2 0;
#P connect 2 0 1 0;
#P pop;
#P newobj 121 110 35 9109513 p title;
#N vpatcher 24 74 263 358;
#P window setfont "Sans Serif" 9.;
#P window linecount 1;
#P newex 57 92 45 9109513 loadbang;
#P message 57 119 115 9109513 name $2 \, outputmode 1;
#P window linecount 3;
#P comment 57 51 76 9109513 tell pattrstorage to send feedback;
#P outlet 57 201 15 0;
#P connect 3 0 2 0;
#P connect 2 0 0 0;
#P pop;
#P newobj 513 395 95 9109513 p provide_feedback;
#P newex 230 401 134 9109513 r $1_message;
#P window linecount 2;
#P message 575 117 130 9109513 \; max htmlref $2;
#P window linecount 1;
#P newex 35 33 90 9109513 r $1_FROM_MGUI;
#P window linecount 2;
#P newex 459 78 245 9109513 jmod.message.mxt $1 help @range n/a @description "open the online html reference for this module";
#P window linecount 1;
#P comment 443 459 100 9109513 to pattrstorage;
#N comlet to pattrstorage;
#P outlet 424 459 15 0;
#N comlet connect to pattrstorage;
#P inlet 424 39 15 0;
#N comlet connect to a poly~ object;
#P outlet 214 459 15 0;
#P window linecount 3;
#P newex 11 59 231 9109513 route _MGUI_FEEDBACK _GET_MODULE_INSTALL_SIZE MODULE_TITLE autodoc;
#P window linecount 1;
#P newex 231 133 27 9109513 t l l;
#P newex 248 156 100 9109513 send $1_instruction;
#N comlet module feedback - connect to 1st outlet;
#P outlet 11 459 15 0;
#N comlet connect to mgui (1st outlet);
#P inlet 11 34 15 0;
#N vpatcher 33 370 840 890;
#P window setfont "Sans Serif" 9.;
#P window linecount 1;
#P newex 525 176 27 9109513 t l l;
#P newex 525 262 38 9109513 gate;
#P newex 525 235 27 9109513 > 1;
#P newex 525 209 29 9109513 zl len;
#P newex 659 202 83 9109513 regexp (\\\\S+::);
#P window linecount 0;
#P newex 565 108 115 9109513 loadmess substitute %0;
#P window linecount 2;
#P newex 317 247 89 9109513 t MENU_REBUILD;
#P window linecount 1;
#P newex 344 158 112 9109513 prepend NEW_PRESETS;
#P newex 90 450 71 9109513 prepend store;
#P window linecount 3;
#P newex 90 401 331 9109513 jmod.message.mxt 0 preset_store @type msg_int @description "Store a preset by number in memory.  All presets present in memory will be written to disk when you send a save_settings message to the module.";
#P window linecount 1;
#P newex 71 377 73 9109513 prepend recall;
#P window linecount 2;
#P newex 71 338 340 9109513 jmod.message.mxt $1 preset_recall @type msg_int @description "Recall a preset by number - you can also choose presets from the module menu";
#P window linecount 1;
#P newex 344 311 93 9109513 s $1_FROM_MHUB;
#P newex 290 128 65 9109513 route 0 done;
#P window linecount 2;
#P newex 55 247 110 9109513 t getslotnamelist NEW_PRESETS_START;
#P window linecount 1;
#P newex 55 97 480 9109513 route read slotname;
#P newex 565 313 50 9109513 tosymbol;
#P newex 565 335 63 9109513 fromsymbol;
#P newex 525 357 50 9109513 zl join;
#P newex 525 291 50 9109513 zl slice 1;
#P newex 525 381 35 9109513 zl reg;
#P newex 525 153 77 9109513 regexp (.+::)* \\\\d;
#P window setfont "Sans Serif" 12.;
#P comment 55 37 103 9109516 Preset Handling;
#P window setfont "Sans Serif" 9.;
#P comment 78 66 100 9109513 from pattrstorage;
#P window linecount 3;
#P comment 620 226 172 9109513 filter out the part of the feedback symbol preceeding the double-colon. Then send to the feedback outlet;
#N comlet from pattrstorage;
#P inlet 55 65 15 0;
#P outlet 55 474 15 0;
#P outlet 525 474 15 0;
#P connect 2 0 12 0;
#P connect 12 0 13 0;
#P connect 13 0 1 0;
#P connect 17 0 1 0;
#P connect 19 0 1 0;
#P fasten 16 1 17 0 406 371 76 371;
#P fasten 18 1 19 0 416 445 95 445;
#P connect 12 1 14 0;
#P connect 14 1 21 0;
#P connect 14 2 20 0;
#P connect 21 0 15 0;
#P connect 13 1 15 0;
#P connect 20 0 15 0;
#P connect 12 2 6 0;
#P connect 22 0 6 0;
#P connect 6 0 27 0;
#P connect 27 1 24 0;
#P connect 24 0 25 0;
#P connect 25 0 26 0;
#P connect 26 0 8 0;
#P connect 8 0 9 0;
#P connect 9 0 7 0;
#P connect 7 0 0 0;
#P connect 27 0 26 1;
#P connect 8 1 11 0;
#P connect 11 0 10 0;
#P connect 10 0 9 1;
#P pop;
#P newobj 424 162 179 9109513 p preset_handling_from_pattrstorage;
#N vpatcher 14 59 568 430;
#P window setfont "Sans Serif" 9.;
#N vpatcher 227 303 740 708;
#P window setfont "Sans Serif" 9.;
#P newex 327 141 20 9109513 t b;
#P outlet 327 363 15 0;
#P newex 327 71 135 9109513 jmod.message.mxt 0 force;
#P objectname jmod.parameter.mxb[4];
#P newex 97 252 27 9109513 qlim;
#P newex 55 202 35 9109513 t open;
#P message 112 280 14 9109513 1;
#B color 4;
#P message 97 224 14 9109513 2;
#B color 4;
#P message 154 280 14 9109513 1;
#B color 4;
#P message 139 224 14 9109513 3;
#B color 4;
#P message 196 280 14 9109513 1;
#B color 4;
#P message 181 224 14 9109513 0;
#B color 4;
#P number 113 306 35 9 0 0 0 139 0 0 0 59 62 255 222 222 222 0 0 0;
#P newex 181 202 40 9109513 sel 1 0;
#B color 4;
#P newex 139 202 40 9109513 sel 1 0;
#B color 4;
#P newex 97 202 40 9109513 sel 1 0;
#B color 4;
#P message 113 324 74 9109513 outputmode \$1;
#B color 4;
#P comment 106 33 100 9109513 'mute' just passes through;
#P newex 55 70 222 9109513 route view_internals bypass freeze mute force;
#P outlet 55 363 15 0;
#P inlet 55 45 15 0;
#P connect 0 0 2 0;
#P connect 2 0 15 0;
#P fasten 2 5 1 0 270 351 60 351;
#P connect 15 0 1 0;
#P fasten 4 0 1 0 118 351 60 351;
#P connect 2 1 5 0;
#P connect 5 0 13 0;
#P lcolor 5;
#P fasten 9 0 16 0 186 245 102 245;
#P fasten 11 0 16 0 144 245 102 245;
#P connect 13 0 16 0;
#P connect 5 1 14 0;
#P lcolor 5;
#P fasten 16 0 8 0 102 301 118 301;
#P connect 14 0 8 0;
#P lcolor 5;
#P fasten 12 0 8 0 159 298 118 298;
#P lcolor 5;
#P fasten 10 0 8 0 201 298 118 298;
#P lcolor 5;
#P connect 8 0 4 0;
#P lcolor 5;
#P connect 2 2 6 0;
#P connect 6 0 11 0;
#P lcolor 5;
#P connect 6 1 12 0;
#P lcolor 5;
#P connect 2 3 7 0;
#P connect 7 0 9 0;
#P lcolor 5;
#P connect 7 1 10 0;
#P lcolor 5;
#P connect 17 0 19 0;
#P connect 2 4 19 0;
#P connect 19 0 18 0;
#P pop;
#P newobj 398 182 73 9109513 p parse_jitter;
#N vpatcher 90 257 281 401;
#P window setfont "Sans Serif" 9.;
#P comment 57 36 100 9109513 'mute' just passes through;
#P outlet 34 95 15 0;
#P inlet 34 36 15 0;
#P connect 0 0 1 0;
#P pop;
#P newobj 313 182 80 9109513 p parse_control;
#P message 170 113 14 9109513 5;
#P message 142 113 14 9109513 4;
#N vpatcher 231 194 756 697;
#P window setfont "Sans Serif" 9.;
#P newex 233 135 78 9109513 prepend mute 0;
#P newex 59 112 59 9109513 jmod.round;
#P newex 77 194 27 9109513 - 2;
#P newex 28 168 59 9109513 sel setitem;
#P newex 28 137 88 9109513 jmod.core.sr.mxt;
#P newex 28 88 72 9109513 route int float;
#P newex 182 257 215 9109513 jmod.post.mxt "parse_poly: bad sample rate";
#P message 161 291 27 9109513 up 4;
#P message 140 316 27 9109513 up 2;
#P message 77 377 41 9109513 down 4;
#P message 98 357 41 9109513 down 2;
#P message 119 334 41 9109513 down 1;
#P newex 77 230 119 9109513 sel -2 -1 0 1 2;
#P newex 28 46 420 9109513 route sr mute;
#P outlet 233 417 15 0;
#P inlet 28 26 15 0;
#P connect 0 0 2 0;
#P connect 2 0 10 0;
#P connect 14 0 11 0;
#P connect 10 0 11 0;
#P connect 11 0 12 0;
#P connect 10 1 14 0;
#P connect 12 1 13 0;
#P connect 13 0 3 0;
#P connect 3 0 6 0;
#P connect 3 1 5 0;
#P connect 3 2 4 0;
#P connect 3 3 7 0;
#P connect 3 4 8 0;
#P connect 3 5 9 0;
#P connect 2 1 15 0;
#P fasten 2 2 1 0 443 400 238 400;
#P connect 7 0 1 0;
#P connect 8 0 1 0;
#P connect 6 0 1 0;
#P connect 5 0 1 0;
#P connect 4 0 1 0;
#P connect 15 0 1 0;
#P pop;
#P newobj 58 182 65 9109513 p parse_poly;
#N vpatcher 237 245 596 667;
#P window setfont "Sans Serif" 9.;
#P newex 51 109 59 9109513 jmod.round;
#P newex 20 185 27 9109513 - 2;
#P newex 20 158 59 9109513 sel setitem;
#P newex 20 88 72 9109513 route int float;
#P newex 20 137 88 9109513 jmod.core.sr.mxt;
#P newex 68 239 214 9109513 jmod.post.mxt "parse_blue: bad sample rate";
#P message 20 310 72 9109513 downsample 2;
#P message 36 292 72 9109513 downsample 1;
#P message 52 274 72 9109513 downsample 0;
#P newex 20 215 59 9109513 sel -2 -1 0;
#P newex 20 52 161 9109513 route sr gain_midi defeat_meters;
#P outlet 170 360 15 0;
#P inlet 20 27 15 0;
#P connect 0 0 2 0;
#P connect 2 0 9 0;
#P connect 12 0 8 0;
#P connect 9 0 8 0;
#P connect 8 0 10 0;
#P connect 10 1 11 0;
#P connect 11 0 3 0;
#P connect 3 0 6 0;
#P connect 3 1 5 0;
#P connect 9 1 12 0;
#P connect 3 2 4 0;
#P connect 3 3 7 0;
#P connect 4 0 1 0;
#P connect 5 0 1 0;
#P connect 6 0 1 0;
#P connect 2 3 1 0;
#P pop;
#P newobj 143 182 65 9109513 p parse_blue;
#P message 114 113 14 9109513 3;
#P newex 58 141 352 9109513 gate 5 1;
#P newex 58 239 35 9109513 zl reg;
#P message 86 113 14 9109513 2;
#P newex 58 87 151 9109513 sel poly blue none control jitter;
#P message 58 113 14 9109513 1;
#P inlet 400 51 15 0;
#P inlet 58 51 15 0;
#P outlet 58 316 15 0;
#P connect 1 0 4 0;
#P connect 4 0 3 0;
#P fasten 12 0 7 0 175 134 63 134;
#P fasten 11 0 7 0 147 134 63 134;
#P fasten 8 0 7 0 119 134 63 134;
#P connect 3 0 7 0;
#P fasten 5 0 7 0 91 134 63 134;
#P connect 7 0 10 0;
#P connect 9 0 6 0;
#P connect 10 0 6 0;
#P connect 13 0 6 0;
#P connect 14 0 6 0;
#P connect 6 0 0 0;
#P fasten 7 2 0 0 233 292 63 292;
#P fasten 14 1 0 0 466 298 63 298;
#P connect 4 1 5 0;
#P connect 4 2 8 0;
#P connect 4 3 11 0;
#P connect 7 1 9 0;
#P connect 4 4 12 0;
#P connect 7 3 13 0;
#P connect 7 4 14 0;
#P connect 2 0 7 1;
#P pop;
#P newobj 214 375 88 9109513 p library_handler;
#N vpatcher 14 59 407 339;
#P window setfont "Sans Serif" 9.;
#P newex 101 130 68 9109513 route symbol;
#P newex 101 177 123 9109513 prepend parameter_name;
#P newex 51 76 39 9109513 t dump;
#N coll $1_registered_parameters 1;
#P newobj 51 100 161 9109513 coll $1_registered_parameters 1;
#P newex 51 26 299 9109513 jmod.message.mxt $1 get_parameter_names @type n/a @range n/a @description "returns a dump of symbols out the feedback outlet with the names of parameters accessible in this module";
#P outlet 101 216 15 0;
#P fasten 1 1 3 0 345 72 56 72;
#P connect 3 0 2 0;
#P connect 2 1 5 0;
#P connect 5 1 4 0;
#P connect 5 0 4 0;
#P connect 4 0 0 0;
#P pop;
#P newobj 25 376 98 9109513 p parameter_names;
#N vpatcher 232 201 1164 650;
#P window setfont "Sans Serif" 9.;
#P window linecount 2;
#P comment 129 373 486 9109513 The first outlet is intended for display update only \, and has the message qlim-ed and prepended by "set". 2nd outlet returns proper message instantly.;
#B color 12;
#P window linecount 1;
#P comment 129 359 322 9109513 Here we have to use the 2nd outlet of jmod.message \, not the first.;
#B color 12;
#P newex 121 190 100 9109513 sprintf read %s.xml;
#P newex 508 211 45 9109513 sel bang;
#P newex 332 199 45 9109513 sel bang;
#N vpatcher 287 116 693 532;
#P origin 0 -110;
#P window setfont "Sans Serif" 9.;
#P newex 107 229 50 9109513 tosymbol;
#P newex 232 230 50 9109513 tosymbol;
#P inlet 147 34 15 0;
#P inlet 130 34 15 0;
#P newex 177 95 192 9109513 jmod.route @searchstring save_settings;
#P newex 232 273 27 9109513 t l b;
#P message 249 308 42 9109513 store 1;
#P newex 177 225 49 9109513 t write b;
#P newex 192 205 50 9109513 zl slice 1;
#P newex 232 253 72 9109513 prepend write;
#P newex 177 125 50 9109513 t l l;
#P newex 192 185 35 9109513 zl reg;
#P newex 177 165 40 9109513 sel 1 2;
#P newex 177 145 33 9109513 zl len;
#P newex 107 273 27 9109513 t b l;
#P message 52 307 35 9109513 recall 1;
#P newex 52 225 44 9109513 t b read;
#P newex 67 205 50 9109513 zl slice 1;
#P newex 107 253 65 9109513 prepend read;
#P newex 52 125 50 9109513 t l l;
#P newex 67 185 35 9109513 zl reg;
#P newex 52 165 40 9109513 sel 1 2;
#P newex 52 145 33 9109513 zl len;
#P newex 52 72 189 9109513 jmod.route @searchstring load_settings;
#P outlet 86 367 15 0;
#P inlet 52 45 15 0;
#P connect 0 0 2 0;
#P connect 2 0 6 0;
#P connect 6 0 3 0;
#P connect 3 0 4 0;
#P connect 22 0 9 0;
#P connect 4 0 9 0;
#P connect 9 0 10 0;
#P connect 11 0 10 0;
#P connect 4 1 5 0;
#P connect 5 0 8 0;
#P fasten 18 0 1 0 182 358 91 358;
#P fasten 20 0 1 0 237 358 91 358;
#P fasten 19 0 1 0 254 358 91 358;
#P connect 9 1 1 0;
#P connect 10 0 1 0;
#P fasten 11 1 1 0 129 358 91 358;
#P connect 6 1 5 1;
#P connect 8 1 25 0;
#P connect 25 0 7 0;
#P connect 7 0 11 0;
#P connect 2 1 21 0;
#P connect 21 0 15 0;
#P connect 15 0 12 0;
#P connect 12 0 13 0;
#P connect 23 0 18 0;
#P connect 13 0 18 0;
#P connect 13 1 14 0;
#P connect 14 0 17 0;
#P connect 15 1 14 1;
#P connect 17 1 24 0;
#P connect 24 0 16 0;
#P connect 16 0 20 0;
#P connect 20 1 19 0;
#P fasten 18 1 19 0 221 303 254 303;
#P lcolor 2;
#P pop;
#P newobj 311 293 53 9109513 p settings;
#P newex 367 222 105 9109513 prepend load_settings;
#P window linecount 3;
#P newex 332 103 302 9109513 jmod.message.mxt $1 load_settings @type msg_symbol @range n/a @description "open an xml-preset file and recall the first preset in that file.  An optional argument defines the file to open";
#P window linecount 1;
#P newex 543 234 110 9109513 prepend save_settings;
#P window linecount 2;
#P newex 508 165 381 9109513 jmod.message.mxt $1 save_settings @type msg_symbol @range n/a @description "write an xml-preset file to disk.  An optional argument defines the file to open";
#P newex 109 46 354 9109513 jmod.message.mxt $1 restore_defaults @type n/a @range n/a @description "Open the default preset file and recall the first preset in that file.";
#P comment 10 160 62 9109513 load the first preset;
#P window linecount 1;
#P message 76 160 44 9109513 recall 1;
#P message 121 160 110 9109513 $2;
#P window linecount 2;
#P comment 139 213 100 9109513 read the default preset(s);
#P window linecount 1;
#P newex 76 97 55 9109513 t b b;
#P newex 76 27 55 9109513 r jmod.init;
#P outlet 76 339 15 0;
#P window setfont "Sans Serif" 12.;
#P window linecount 0;
#P comment 129 339 143 9109516 // Important:;
#B color 12;
#P fasten 8 1 3 0 458 84 81 84;
#P connect 2 0 3 0;
#P connect 3 0 6 0;
#P fasten 13 0 1 0 316 317 81 317;
#P connect 6 0 1 0;
#P fasten 16 0 1 0 126 314 81 314;
#P fasten 3 1 5 0 126 133 126 133;
#P connect 5 0 16 0;
#P fasten 12 0 13 0 372 258 316 258;
#P fasten 10 0 13 0 548 261 316 261;
#P fasten 11 1 14 0 629 155 337 155;
#P connect 14 0 13 1;
#P fasten 15 0 13 2 513 287 358 287;
#P connect 14 1 12 0;
#P fasten 9 1 15 0 884 206 513 206;
#P connect 15 1 10 0;
#P pop;
#P newobj 443 373 165 9109513 p preset_handling_to_pattrstorage;
#N vpatcher 214 150 844 583;
#P inlet 431 55 15 0;
#P window setfont "Sans Serif" 9.;
#P window linecount 1;
#P newex 431 359 93 9109513 s $1_FROM_MHUB;
#P newex 431 285 42 9109513 t BUILD;
#P newex 431 264 57 9109513 sel done;
#P newex 478 286 104 9109513 prepend ATTRIBUTES;
#P newex 97 270 71 9109513 pack 1 half;
#P message 137 224 23 9109513 full;
#P newex 137 204 31 9109513 sel 0;
#P newex 97 177 50 9109513 zl slice 1;
#P newex 61 136 118 9109513 regexp (\\\\d)U-?(\\\\S*);
#P newex 97 290 185 9109513 prepend set \\\; _MODULE_INSTALL_SIZE;
#P window setfont "Sans Serif" 12.;
#P comment 47 31 131 9109516 Attribute Handling;
#P window setfont "Sans Serif" 9.;
#P newex 215 136 71 9109513 prepend refer;
#P newex 61 105 321 9109513 route size xxxx presets library_type;
#P outlet 292 367 15 0;
#P outlet 97 367 15 0;
#P window linecount 0;
#P comment 451 55 151 9109513 patcherargs unfortunately has to stay at top level to work properly;
#P fasten 16 0 3 0 436 87 66 87;
#P connect 3 0 7 0;
#P connect 7 1 8 0;
#P connect 8 0 11 0;
#P connect 11 0 6 0;
#P connect 6 0 1 0;
#P connect 8 1 9 0;
#P connect 9 0 10 0;
#P connect 10 0 11 1;
#P connect 9 1 11 1;
#P connect 3 2 4 0;
#P connect 3 3 2 0;
#P connect 16 0 13 0;
#P connect 13 0 14 0;
#P connect 14 0 15 0;
#P connect 12 0 15 0;
#P connect 13 1 12 0;
#P pop;
#P newobj 125 275 99 9109513 p attribute_handling;
#N vpatcher 14 59 324 294;
#P window setfont "Sans Serif" 9.;
#P window linecount 0;
#P newex 63 76 27 9109513 qlim;
#P window linecount 2;
#P message 63 139 149 9109513 \; _MODULE_INSTALL_SIZE 1 full;
#P window linecount 1;
#P newex 63 97 22 9109513 b 1;
#P inlet 172 61 15 0;
#P inlet 63 56 15 0;
#P connect 0 0 4 0;
#P connect 4 0 2 0;
#P connect 1 0 3 0;
#P connect 2 0 3 0;
#P pop;
#P newobj 66 297 69 9109513 p install_size;
#N vpatcher 14 59 347 414;
#P origin 68 0;
#P window setfont "Sans Serif" 9.;
#P newex 39 78 51 9109513 route list;
#P message 129 171 52 9109513 target \$1;
#P newex 112 150 27 9109513 t b i;
#P newex 112 221 117 9109513 zl reg;
#P newex 112 130 117 9109513 zl slice 1;
#P window setfont "Sans Serif" 12.;
#P comment 47 28 131 9109516 Poly Handling;
#P inlet 39 58 15 0;
#P outlet 80 284 15 0;
#P connect 1 0 7 0;
#P connect 7 1 0 0;
#P connect 4 0 0 0;
#P fasten 6 0 0 0 134 208 85 208;
#P connect 7 0 3 0;
#P connect 3 0 5 0;
#P connect 5 0 4 0;
#P connect 5 1 6 0;
#P connect 3 1 4 1;
#P pop;
#P newobj 231 110 78 9109513 p poly_handling;
#N vpatcher 273 125 703 513;
#P inlet 48 48 15 0;
#P window setfont "Sans Serif" 9.;
#P window linecount 1;
#P newex 47 72 294 9109513 t l l;
#P newex 47 252 294 9109513 zl reg;
#P window linecount 2;
#P newex 47 286 125 9109513 jmod.post.mxt $2-SyntaxError;
#P window linecount 1;
#P newex 47 226 31 9109513 sel 0;
#P newex 47 206 27 9109513 i;
#P newex 47 118 44 9109513 t b l 0;
#P newex 47 96 50 9109513 zl slice 1;
#N coll $1_registered_parameters 1;
#P newobj 64 160 203 9109513 coll $1_registered_parameters 1;
#P window linecount 0;
#N vpatcher 14 59 539 498;
#P window setfont "Sans Serif" 9.;
#P window linecount 1;
#P newex 117 252 109 9109513 prepend PARAMETERS;
#P newex 117 273 122 9109513 s $1_FROM_MHUB;
#P newex 69 368 71 9109513 prepend store;
#P newex 69 347 35 9109513 zl rev;
#P newex 69 326 48 9109513 zl join;
#P newex 69 221 48 9109513 t b l;
#N counter;
#X flags 0 0;
#P newobj 69 303 352 9109513 counter;
#P newex 69 103 55 9109513 t b clear 1;
#P newex 69 201 159 9109513 receive $1_register;
#P newex 69 168 132 9109513 send $1_query;
#P newex 69 72 55 9109513 r jmod.init;
#P outlet 47 394 15 0;
#P window linecount 0;
#P comment 37 33 300 9109513 query for valid syntax \, and register in coll;
#P connect 10 0 1 0;
#P fasten 5 1 1 0 96 138 52 138;
#P connect 2 0 5 0;
#P connect 5 0 3 0;
#P connect 4 0 7 0;
#P connect 7 0 6 0;
#P connect 6 0 8 0;
#P connect 8 0 9 0;
#P connect 9 0 10 0;
#P connect 7 1 8 1;
#P fasten 7 1 12 0 112 242 122 242;
#P lcolor 13;
#P connect 12 0 11 0;
#P fasten 5 2 6 2 118 127 244 127;
#P pop;
#P newobj 111 119 91 9109513 p syntax_register;
#B color 12;
#P comment 205 116 124 9109513 query for valid syntax \, and register in coll;
#B color 12;
#P comment 69 50 114 9109513 check if syntax is valid;
#P connect 11 0 10 0;
#P connect 10 0 4 0;
#P connect 4 0 5 0;
#P connect 5 0 6 0;
#P connect 6 0 7 0;
#P connect 7 0 9 0;
#P connect 9 0 8 0;
#P connect 5 1 3 0;
#P connect 2 0 3 0;
#P lcolor 13;
#P connect 3 0 6 1;
#P fasten 5 2 6 1 86 191 69 191;
#P connect 10 1 9 1;
#P pop;
#P newobj 231 177 85 9109513 p syntax_handler;
#P comment 443 39 100 9109513 from pattrstorage;
#P connect 19 0 13 0;
#P connect 9 0 13 0;
#P connect 8 1 10 0;
#P connect 6 0 10 0;
#P connect 13 0 10 0;
#P connect 13 1 3 0;
#P connect 13 2 23 0;
#P fasten 25 1 4 0 369 268 130 268;
#P connect 4 0 3 1;
#P connect 13 3 26 0;
#P connect 4 1 7 0;
#P connect 24 0 14 0;
#P connect 21 0 14 0;
#P connect 7 0 14 0;
#P connect 13 4 2 0;
#P connect 2 0 12 0;
#P connect 12 0 1 0;
#P connect 12 1 11 0;
#P connect 8 1 7 1;
#P connect 15 0 8 0;
#P connect 5 0 16 0;
#P connect 8 0 16 0;
#P connect 22 0 16 0;
#P fasten 18 1 20 0 699 113 580 113;
#P fasten 28 0 29 0 771 352 673 352;
#P connect 27 1 28 0;
#P pop;
