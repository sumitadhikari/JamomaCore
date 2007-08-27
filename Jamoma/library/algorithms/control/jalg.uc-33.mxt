max v2;#N vpatcher 25 65 554 540;#P window setfont "Sans Serif" 9.;#P window linecount 1;#N vpatcher 10 59 554 312;#P window setfont "Sans Serif" 9.;#P window linecount 1;#P newex 46 167 62 196617 prepend set;#P inlet 46 27 15 0;#P window linecount 0;#P newex 69 27 64 196617 r $1_inport;#P window linecount 1;#P newex 69 103 61 196617 ctlin 10 $2;#P window linecount 2;#P newex 46 127 321 196617 jcom.return $2/rotary/lower @type msg_int @range 0 127 @clipmode both @repetitions 1 @description "Lower rotary control.";#P objectname $2/rotary/upper;#P outlet 46 194 15 0;#P connect 2 0 1 0;#P connect 4 0 1 0;#P connect 1 0 5 0;#P connect 5 0 0 0;#P connect 3 0 2 0;#P pop;#P hidden newobj 188 174 80 196617 p rotary_lower;#P objectname "sub patch[3]";#P hidden newex 188 195 57 196617 pvar Dial3;#N vpatcher 10 59 554 312;#P window setfont "Sans Serif" 9.;#P window linecount 1;#P newex 46 167 62 196617 prepend set;#P inlet 46 27 15 0;#P window linecount 0;#P newex 69 79 64 196617 r $1_inport;#P window linecount 1;#P newex 69 103 61 196617 ctlin 12 $2;#P window linecount 2;#P newex 46 127 322 196617 jcom.return $2/rotary/middle @type msg_int @range 0 127 @clipmode both @repetitions 1 @description "Middle rotary control.";#P objectname $2/rotary/upper;#P outlet 46 194 15 0;#P connect 2 0 1 0;#P connect 4 0 1 0;#P connect 1 0 5 0;#P connect 5 0 0 0;#P connect 3 0 2 0;#P pop;#P hidden newobj 188 122 83 196617 p rotary_middle;#P objectname "sub patch[2]";#P hidden newex 188 143 57 196617 pvar Dial2;#P user dial 11 64 27 27 128 1 0 0 202 270 1 0.484375 99 99 99 24 24 24 120 120 120 107 107 107 255 255 255 22 22 22;#P objectname Dial3;#P user dial 11 38 27 27 128 1 0 0 202 270 1 0.484375 99 99 99 24 24 24 120 120 120 107 107 107 255 255 255 22 22 22;#P objectname Dial2;#P user dial 11 12 27 27 128 1 0 0 202 270 1 0.484375 99 99 99 24 24 24 120 120 120 107 107 107 255 255 255 22 22 22;#P objectname Dial1;#P user multiSlider 17 99 16 131 0. 127. 1 2665 47 0 0 4 0 40 0;#M frgb 255 255 255;#M brgb 0 0 0;#M rgb2 127 127 127;#M rgb3 0 0 0;#M rgb4 37 52 91;#M rgb5 74 105 182;#M rgb6 112 158 18;#M rgb7 149 211 110;#M rgb8 187 9 201;#M rgb9 224 62 37;#M rgb10 7 114 128;#P objectname Fader;#P user panel 0 0 51 243;#X brgb 24 24 24;#X frgb 132 132 132;#X border 1;#X rounded 0;#X shadow 0;#X done;#N vpatcher 10 59 554 312;#P window setfont "Sans Serif" 9.;#P window linecount 1;#P newex 46 167 62 196617 prepend set;#P inlet 46 27 15 0;#P window linecount 0;#P newex 69 27 64 196617 r $1_inport;#P window linecount 1;#P newex 69 103 61 196617 ctlin 13 $2;#P window linecount 2;#P newex 46 127 319 196617 jcom.return $2/rotary/upper @type msg_int @range 0 127 @clipmode both @repetitions 1 @description "Upper rotary control.";#P objectname $2/rotary/upper;#P outlet 46 194 15 0;#P connect 4 0 1 0;#P connect 2 0 1 0;#P connect 1 0 5 0;#P connect 5 0 0 0;#P connect 3 0 2 0;#P pop;#P hidden newobj 188 70 79 196617 p rotary_upper;#P objectname "sub patch[1]";#N vpatcher 10 59 555 345;#P window setfont "Sans Serif" 9.;#P window linecount 1;#P newex 46 187 71 196617 prepend set 1;#P inlet 46 27 15 0;#P window linecount 0;#P newex 69 27 64 196617 r $1_inport;#P window linecount 1;#P newex 69 103 55 196617 ctlin 7 $2;#P window linecount 2;#P newex 46 127 250 196617 jcom.return $2/fader @type msg_int @range 0 127 @clipmode both @repetitions 1 @description "Fader.";#P objectname $2/fader;#P outlet 46 220 15 0;#P connect 2 0 1 0;#P connect 4 0 1 0;#P connect 1 0 5 0;#P connect 5 0 0 0;#P connect 3 0 2 0;#P pop;#P hidden newobj 188 235 43 196617 p Fader;#P objectname "sub patch";#P hidden newex 188 257 59 196617 pvar Fader;#P hidden newex 188 91 57 196617 pvar Dial1;#P comment 15 355 100 196617 DIM: 51 243;#P hidden fasten 1 0 4 0 193 113 182 113 182 111 182 110 182 63 193 63;#P hidden connect 4 0 1 0;#P hidden fasten 10 0 11 0 193 165 182 165 182 163 182 162 182 115 193 115;#P hidden connect 11 0 10 0;#P hidden fasten 12 0 13 0 193 217 182 217 182 215 182 214 182 167 193 167;#P hidden connect 13 0 12 0;#P hidden fasten 2 0 3 0 193 277 182 277 182 229 193 229;#P hidden connect 3 0 2 0;#P pop;