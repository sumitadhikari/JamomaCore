max v2;#N vpatcher 758 298 1154 549;#P origin -31 11;#P window setfont "Sans Serif" 9.;#N vpatcher 609 154 922 458;#P window setfont "Sans Serif" 9.;#P window linecount 0;#P newex 46 172 27 196617 + 1;#P newex 134 114 21 196617 t 1;#P newex 46 150 40 196617 change;#P newex 90 113 21 196617 t 2;#P newex 46 113 21 196617 t 0;#P outlet 248 234 15 0;#P outlet 147 235 15 0;#P outlet 46 235 15 0;#P inlet 249 51 15 0;#P window linecount 1;#P newex 46 197 213 196617 gate 3 1;#P newex 46 81 98 196617 sel 0. 1.;#P inlet 46 54 15 0;#P connect 0 0 1 0;#P connect 1 0 7 0;#P connect 10 0 9 0;#P connect 7 0 9 0;#P connect 8 0 9 0;#P connect 9 0 11 0;#P connect 11 0 2 0;#P connect 2 0 4 0;#P connect 1 1 8 0;#P connect 1 2 10 0;#P connect 2 1 5 0;#P connect 2 2 6 0;#P connect 3 0 2 1;#P pop;#P newobj 19 147 272 196617 p optimize;#P outlet 168 208 15 0;#P newex 168 177 102 196617 jit.op @op * @val 1.;#P newex 160 117 30 196617 !- 1.;#P newex 32 68 210 196617 jcom.oscroute /genframe /direct /yfade;#P inlet 281 47 15 0;#P inlet 32 44 15 0;#P comment 47 206 75 196617 VIDEO OUTPUT;#P outlet 32 206 15 0;#P newex 32 177 102 196617 jit.op @op * @val 1.;#P connect 5 2 9 0;#P connect 3 0 5 0;#P fasten 5 1 0 0 103 131 37 131;#P connect 5 0 0 0;#P connect 9 1 0 0;#P connect 0 0 1 0;#P fasten 9 0 1 0 24 198 37 198;#P connect 6 0 0 1;#P connect 5 2 6 0;#P connect 9 1 7 0;#P connect 7 0 8 0;#P fasten 9 2 8 0 286 199 173 199;#P connect 5 2 7 1;#P connect 4 0 9 1;#P pop;