max v2;
#N vpatcher 116 58 791 501;
#P window setfont "Sans Serif" 9.;
#P hidden newex 91 205 43 196617 jcom.in;
#P hidden message 47 107 125 196617 /documentation/generate;
#P window linecount 3;
#P hidden newex 91 342 152 196617 jcom.return cpu @description "reports the cpu usage of the dsp processing";
#P window linecount 1;
#P hidden newex 91 320 48 196617 pvar cpu;
#P hidden newex 91 253 45 196617 pcontrol;
#P hidden newex 91 229 78 196617 jcom.pass open;
#P hidden comment 319 202 129 196617 Messages;
#P hidden newex 378 51 83 196617 r $0_xxx_audio;
#P hidden newex 318 245 308 196617 jcom.message refresh @description "Refresh all Max windows.";
#P objectname jcom.parameter.mxt[3];
#P hidden newex 318 361 304 196617 jcom.message init @description "Initialize all Jamoma modules.";
#P objectname jcom.parameter.mxt[2];
#N vpatcher 61 176 855 743;
#P origin 0 1;
#P window setfont "Sans Serif" 9.;
#P newex 490 106 30 196617 t b b;
#P newex 299 303 29 196617 t 1 l;
#P window linecount 1;
#P newex 279 329 49 196617 gate 1 1;
#P window linecount 0;
#P newex 299 101 29 196617 t i 0;
#P newex 490 79 106 196617 jcom.oscroute /panic;
#P newex 361 186 35 196617 del 15;
#P newex 279 386 83 196617 s $0_xxx_audio;
#P newex 279 362 50 196617 route set;
#P newex 361 240 21 196617 t 0;
#P newex 403 186 81 196617 s jcom.audio.off;
#P newex 299 270 80 196617 adstatus switch;
#P newex 299 158 44 196617 t 1 stop;
#P newex 299 137 134 196617 sel 1 0;
#P newex 299 79 106 196617 jcom.oscroute /audio;
#P comment 539 260 131 196617 Panic kill audio instantly;
#P window linecount 2;
#P comment 539 213 131 196617 Audio off is delayed briefly for a quick fade out.;
#P window linecount 3;
#P comment 539 154 131 196617 Smootth fade in when audio is turned on (this is handled in the audio modules).;
#P window linecount 2;
#P message 37 143 69 196617 \; max refresh;
#P message 102 110 72 196617 \; jcom.init bang;
#P outlet 37 447 15 0;
#P window linecount 1;
#P newex 37 79 141 196617 jcom.oscroute /refresh /init;
#P inlet 37 39 15 0;
#P newex 37 374 53 196617 dspstate~;
#P newex 37 395 55 196617 metro 250;
#P newex 37 415 64 196617 adstatus cpu;
#P window linecount 0;
#P comment 337 307 206 196617 This gate prevents audio from being turned on or of twice if audio state is changed using the Audio button or an /audio message.;
#P connect 4 0 5 0;
#P connect 5 0 8 0;
#P connect 3 0 2 0;
#P connect 2 0 1 0;
#P connect 1 0 6 0;
#P connect 5 1 7 0;
#P connect 24 0 23 0;
#P fasten 22 1 23 0 323 127 284 127;
#P connect 23 0 18 0;
#P connect 18 0 19 0;
#P connect 5 2 12 0;
#P connect 12 0 22 0;
#P connect 22 0 13 0;
#P connect 13 0 14 0;
#P connect 14 0 15 0;
#P connect 17 0 15 0;
#P connect 15 0 24 0;
#P connect 24 1 23 1;
#P connect 13 1 20 0;
#P connect 14 1 20 0;
#P connect 20 0 17 0;
#P fasten 25 1 17 0 515 225 366 225;
#P connect 13 1 16 0;
#P connect 25 0 16 0;
#P connect 12 1 21 0;
#P connect 21 0 25 0;
#P pop;
#P hidden newobj 91 284 109 196617 p Control_Components;
#P window linecount 2;
#P hidden newex 24 132 322 196617 jcom.hub jmod.control @size 1U-half @module_type control @description "Master control module for the Jamoma environment";
#P objectname jcom.hub;
#P window linecount 1;
#P hidden newex 318 77 378 196617 jcom.parameter audio @type msg_toggle @description "Toggle audio on and off.";
#P objectname audio[1];
#P hidden newex 318 301 285 196617 jcom.message panic @description "Stop audio immediately.";
#P objectname jcom.parameter.mxt;
#P hidden outlet 24 174 15 0;
#P hidden inlet 24 107 15 0;
#P hidden newex 318 223 68 196617 pvar Refresh;
#P hidden newex 318 338 48 196617 pvar Init;
#P user multiSlider 144 3 75 13 0. 100. 1 2680 15 0 0 2 0 30 0;
#M frgb 255 9 14;
#M brgb 181 181 181;
#M rgb2 127 127 127;
#M rgb3 0 0 0;
#M rgb4 37 52 91;
#M rgb5 74 105 182;
#M rgb6 112 158 18;
#M rgb7 149 211 110;
#M rgb8 187 9 201;
#M rgb9 224 62 37;
#M rgb10 7 114 128;
#P objectname cpu;
#P comment 220 4 32 196617 CPU;
#B frgb 181 181 181;
#P hidden newex 318 280 55 196617 pvar Panic;
#P hidden newex 318 51 55 196617 pvar audio;
#P user jsui 93 19 68 20 1 0 0 jsui_textbutton.js Refresh;
#P objectname Refresh;
#P user jsui 168 25 80 24 1 0 0 jsui_textbutton.js Init;
#P objectname Init;
#P user jsui 93 40 68 20 1 0 0 jsui_textbutton.js Panic!;
#P objectname Panic;
#P user jsui 6 25 80 24 1 0 0 jcom.jsui_texttoggle.js "Audio Off" "Audio On";
#P objectname audio;
#P hidden comment 318 24 100 196617 Parameters;
#N vpatcher 506 170 907 390;
#P origin 35 0;
#P window setfont "Sans Serif" 9.;
#P window linecount 1;
#P newex 65 140 27 196617 qlim;
#P newex 65 74 27 196617 qlim;
#P newex 65 96 27 196617 qlim;
#P outlet 65 162 15 0;
#P window linecount 0;
#P newex 65 118 27 196617 qlim;
#P newex 65 52 45 196617 loadbang;
#P connect 0 0 4 0;
#P connect 4 0 3 0;
#P connect 3 0 1 0;
#P connect 1 0 5 0;
#P connect 5 0 2 0;
#P pop;
#P hidden newobj 280 198 35 196617 p INIT;
#P bpatcher 0 0 255 62 0 0 jcom.gui.mxt 0;
#P objectname jcom.gui.mxt;
#P hidden connect 13 0 17 0;
#P hidden connect 27 0 17 0;
#P hidden connect 17 0 14 0;
#P hidden connect 28 0 23 0;
#P hidden connect 23 0 24 0;
#P hidden connect 24 0 18 0;
#P hidden fasten 23 1 18 0 164 278 96 278;
#P hidden connect 18 0 25 0;
#P hidden connect 25 0 26 0;
#P hidden fasten 16 0 7 0 323 109 313 109 313 47 323 47;
#P hidden connect 7 0 16 0;
#P hidden fasten 21 0 16 0 383 73 323 73;
#P hidden fasten 1 0 12 0 285 219 323 219;
#P hidden connect 12 0 20 0;
#P hidden connect 8 0 15 0;
#P hidden connect 11 0 19 0;
#P pop;
