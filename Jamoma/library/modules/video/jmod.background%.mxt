max v2;#N vpatcher 302 82 1180 463;#P window setfont "Sans Serif" 9.;#P user umenu 14 28 100 196647 1 64 44 1;#X add mode;#X add color;#P objectname Mode;#P window linecount 1;#P hidden newex 144 294 49 196617 jcom.out;#P hidden inlet 144 165 13 0;#P hidden comment 159 166 65 196617 VIDEO INPUT;#P hidden newex 144 182 52 196617 jcom.in 1;#P hidden newex 44 228 47 196617 pcontrol;#P hidden newex 44 205 78 196617 jcom.pass open;#P hidden newex 445 92 57 196617 pvar Mode;#P window linecount 2;#P hidden newex 445 114 394 196617 jcom.parameter mode @type msg_int @ramp 0 @repetitions 1 @range 0 4 @clipmode none @description "Choose between four different background subtraction models";#P objectname mode;#P window linecount 1;#P hidden message 99 86 125 196617 /documentation/generate;#B color 3;#P hidden comment 159 321 75 196617 VIDEO OUTPUT;#P hidden outlet 144 321 13 0;#P hidden newex 44 257 110 196617 jalg.background%.mxt;#P hidden comment 15 84 79 196617 command input;#P window linecount 2;#P hidden newex 1 109 298 196617 jcom.hub jmod.background% @size 1U-half @module_type video @algorithm_type jitter @description "Background subtraction";#P objectname jcom.hub;#P hidden outlet 1 171 13 0;#P hidden inlet 1 84 13 0;#P bpatcher 0 0 256 60 0 0 jcom.gui.mxt 0;#P objectname jcom.gui;#P hidden connect 1 0 3 0;#P hidden fasten 8 0 3 0 104 105 6 105;#P hidden connect 3 0 2 0;#P hidden fasten 13 1 11 0 170 204 49 204;#P hidden connect 11 0 12 0;#P hidden fasten 11 1 5 0 117 250 49 250;#P hidden connect 12 0 5 0;#P hidden connect 15 0 13 0;#P hidden connect 13 0 5 1;#P hidden connect 5 1 16 0;#P hidden connect 16 0 6 0;#P hidden fasten 9 0 10 0 450 149 439 149 439 83 450 83;#P hidden connect 10 0 9 0;#P pop;