max v2;#N vpatcher 352 137 1170 533;#P origin 10 -85;#P window setfont "Sans Serif" 9.;#P hidden newex 175 129 43 196617 jcom.in;#P user jsui 58 28 51 15 1 0 0 jcom.jsui_texttoggle.js pointer nopointer;#P objectname nopointer;#P hidden newex 495 188 76 196617 pvar nopointer;#P window linecount 2;#P hidden newex 495 210 244 196617 jcom.parameter nopointer @type msg_toggle @clipmode none @description "Move mouse pointer";#P objectname nopointer[1];#P user jsui 35 28 20 15 1 0 0 jcom.jsui_texttoggle.js off on;#P objectname on;#P user jsui 7 28 25 15 1 0 0 jsui_textbutton.js init;#P objectname init;#P window linecount 1;#P hidden newex 497 114 49 196617 pvar init;#P window linecount 2;#P hidden newex 497 136 257 196617 jcom.message init @type generic @clipmode none @description "Initialization of wacom object";#P objectname jcom.parameter[3];#P window linecount 1;#P hidden newex 495 46 44 196617 pvar on;#P window linecount 2;#P hidden newex 495 68 220 196617 jcom.parameter on @type msg_toggle @clipmode none @description "Turn polling on";#P objectname on[1];#P user umenu 148 28 100 196647 1 64 44 1;#X add "All tablets and tools";#P objectname menu;#P window linecount 1;#P comment 113 30 38 196617 Tablet;#P hidden newex 496 283 57 196617 pvar menu;#P window linecount 2;#P hidden newex 496 305 264 196617 jcom.parameter menu @type msg_menu @clipmode none @description "Choose which wacom device to use";#P objectname menu[1];#P window linecount 1;#P hidden newex 175 171 45 196617 pcontrol;#P hidden newex 175 150 91 196617 jcom.pass open;#P hidden message 38 69 125 196617 /documentation/generate;#P window linecount 2;#P hidden message 16 229 66 196617 \; max refresh;#P hidden message 16 195 75 196617 \; jcom.init bang;#P window linecount 1;#P hidden newex 175 247 104 196617 jalg.wacom.mxt;#P window linecount 2;#P hidden newex 16 94 265 196617 jcom.hub jmod.wacom @size 1U-half @module_type control @description "Use Wacom graphic tablets";#P objectname jcom.hub;#P hidden inlet 16 70 13 0;#P hidden outlet 16 132 13 0;#P window linecount 1;#P hidden message 281 223 153 196617 /documentation/html;#P hidden newex 281 201 61 196617 prepend set;#P bpatcher 0 0 256 62 0 0 jcom.gui.mxt 0;#P objectname jcom.gui.1Uh.a.stereo.mxt;#P hidden connect 4 0 5 0;#P hidden fasten 9 0 5 0 43 88 21 88;#P hidden connect 5 0 3 0;#P hidden connect 25 0 10 0;#P hidden connect 10 0 11 0;#P hidden connect 11 0 6 0;#P hidden fasten 10 1 6 0 261 192 180 192;#P hidden fasten 10 1 1 0 261 192 286 192;#P hidden connect 1 0 2 0;#P hidden fasten 16 0 17 0 500 101 488 101 488 41 500 41;#P hidden connect 17 0 16 0;#P hidden fasten 22 0 23 0 500 243 488 243 488 183 500 183;#P hidden connect 23 0 22 0;#P hidden fasten 6 1 13 0 274 273 501 273;#P hidden fasten 12 0 13 0 501 338 489 338 489 278 501 278;#P hidden connect 13 0 12 0;#P hidden connect 19 0 18 0;#P pop;