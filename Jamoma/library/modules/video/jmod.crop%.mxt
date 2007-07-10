max v2;#N vpatcher 594 214 1117 808;#P origin 0 -1024;#P window setfont "Sans Serif" 9.;#P window linecount 1;#P hidden comment 386 242 75 196617 VIDEO OUTPUT;#P hidden outlet 371 242 13 0;#P hidden newex 17 412 58 196617 pvar reset;#P hidden newex 17 440 398 196617 jmod.parameter $0_ /reset @type toggle @description "Reset automatic contraction";#P objectname jmod.parameter.mxt[2];#P button 132 40 15 0;#P objectname reset;#P comment 92 41 34 196617 reset;#P window linecount 2;#P hidden user com 321 519 146 196617 28;#K set 0 16748 25976 24942 25701 29216 21093 26227 30061 8266 25966 29541 28265 30067 3432 29812 28730 12079 28021 29545 25441 27751 25971 29813 29285 29486 30057 28462 28271;#K end;#P window linecount 1;#P hidden newex 183 171 47 196617 pcontrol;#P hidden newex 183 148 78 196617 jmod.pass open;#P comment 4 41 72 196617 auto-contract;#P user radiogroup 75 39 18 16;#X size 1;#X offset 16;#X inactive 0;#X itemtype 1;#X flagmode 0;#X set 0;#X done;#P objectname auto_contract;#P flonum 56 22 35 9 0. 0 8225 3 0 0 0 221 221 221 222 222 222 0 0 0;#P objectname threshold;#P comment 4 24 57 196617 threshold;#P hidden newex 16 329 97 196617 pvar auto_contract;#P hidden message 99 86 50 196617 /autodoc;#B color 3;#P window linecount 2;#P hidden newex 16 357 211 196617 jmod.parameter $0_ /auto_contract @type toggle @description "Automatic contraction";#P objectname jmod.parameter.mxt[1];#P hidden newex 16 277 346 196617 jmod.parameter $0_ /threshold @type msg_float @ramp 1 @repetitions 0 @range 0. 1. @clipmode none @description "Threshold of motion analysis";#P objectname jmod.parameter.mxt;#P window linecount 1;#P hidden newex 16 251 76 196617 pvar threshold;#P window linecount 3;#P hidden newex 396 106 79 196617 pattrstorage @autorestore 0 @savemode 0;#X client_rect 782 465 1336 822;#X storage_rect 0 0 640 240;#P objectname jmod.crop%;#P window linecount 1;#P hidden comment 292 244 75 196617 VIDEO OUTPUT;#P hidden outlet 277 244 13 0;#P hidden inlet 372 172 13 0;#P hidden comment 387 173 65 196617 VIDEO INPUT;#P hidden newex 183 200 199 196617 jmod.crop%.alg;#P objectname jmod.crop%.alg;#P window linecount 2;#P hidden message 393 474 72 196617 \; jmod.init bang;#B color 3;#P window linecount 1;#P hidden comment 15 84 79 196617 command input;#P window linecount 2;#P hidden newex 1 109 374 196617 jmod.hub $0_ jmod.crop% $1 @size 1U-half @module_type video @library_type jitter @num_inputs 1 @num_outputs 1 @description "Crop video";#P objectname jmod.hub;#P hidden outlet 1 171 13 0;#P hidden inlet 1 84 13 0;#P bpatcher 0 0 256 60 0 0 jmod.gui.mxt 0 $0_;#P objectname jmod.gui;#P hidden fasten 6 1 0 0 377 223 484 223 484 -5 5 -5;#P hidden connect 1 0 3 0;#P hidden fasten 15 0 3 0 104 105 6 105;#P hidden connect 3 0 2 0;#P hidden fasten 13 0 12 0 21 311 11 311 11 248 21 248;#P hidden connect 12 0 13 0;#P hidden fasten 14 0 16 0 21 395 10 395 10 325 21 325;#P hidden connect 16 0 14 0;#P hidden fasten 26 0 27 0 22 478 11 478 11 408 22 408;#P hidden connect 27 0 26 0;#P hidden connect 3 1 21 0;#P hidden connect 21 0 22 0;#P hidden connect 22 0 6 0;#P hidden fasten 21 1 6 0 256 193 188 193;#P hidden connect 6 1 9 0;#P hidden connect 11 0 3 1;#P connect 6 2 28 0;#P hidden connect 8 0 6 1;#P hidden connect 3 2 11 0;#P pop;