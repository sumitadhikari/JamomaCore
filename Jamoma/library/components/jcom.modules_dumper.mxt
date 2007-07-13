max v2;#N vpatcher 10 59 270 355;#N comlet number of module instances for each module;#P outlet 158 236 15 0;#N comlet sends a clear message everytime a new module is added;#P outlet 183 236 17 0;#N comlet send anything to retrieve all the module names;#P inlet 39 47 15 0;#P window setfont "Sans Serif" 9.;#P window linecount 1;#P newex 72 28 50 196617 jcom.init;#P newex 72 72 29 196617 qlim;#P newex 72 53 29 196617 qlim;#P newex 124 28 48 196617 loadbang;#P window setfont "Sans Serif" 18.;#N vpatcher 830 96 1401 657;#P origin 0 -37;#P window setfont "Sans Serif" 9.;#P window linecount 1;#P newex 12 212 48 196617 t b s;#P outlet 12 242 15 0;#P comment 198 254 241 196617 NB : there is a bug when module names contain dots;#B color 1;#P inlet 276 52 15 0;#P newex 276 70 240 196617 t b clear;#P window linecount 2;#P comment 51 55 190 196617 This part allows instant registration when a module is created;#B color 1;#P window linecount 1;#P newex 46 144 188 196617 jcom.receive jcom.remote.module.from;#P newex 46 171 156 196617 jcom.oscroute /*/module_name;#P newex 328 338 69 196617 t f 1;#P button 311 370 15 0;#P newex 328 369 35 196617 * 10.;#P newex 156 438 72 196617 prepend store;#P newex 156 416 50 196617 zl join;#P newex 156 390 86 196617 t s s;#P newex 288 392 50 196617 maximum;#N coll jcom.modules_instances 1;#P newobj 50 473 147 196617 coll jcom.modules_instances 1;#P newex 50 445 72 196617 prepend store;#P newex 50 424 50 196617 append 0;#N vpatcher 151 59 344 335;#P window setfont "Sans Serif" 9.;#P newex 99 105 47 196617 zl sub 46;#P outlet 55 212 15 0;#P newex 15 188 50 196617 gate 2;#P newex 99 157 27 196617 + 1;#P newex 99 133 27 196617 > 0;#P newex 55 59 54 196617 t s s;#P newex 99 83 40 196617 atoi;#P outlet 15 211 15 0;#P inlet 55 37 15 0;#P connect 5 0 6 0;#P connect 6 0 1 0;#P connect 0 0 3 0;#P connect 3 0 6 1;#P connect 6 1 7 0;#P connect 3 1 2 0;#P connect 2 0 8 0;#P fasten 8 1 4 0 141 127 104 127;#P connect 4 0 5 0;#P pop;#P newobj 50 262 94 196617 p instances?;#P newex 50 239 50 196617 tosymbol;#P newex 134 287 98 196617 regexp (.*)(\\\\..*);#P newex 156 313 182 196617 zl ecils 1;#P newex 276 209 51 196617 zl slice 1;#P message 352 138 152 196617 name jcom.remote.module.from;#P message 276 139 59 196617 name dumb;#P newex 276 115 86 196617 t b s b;#P message 276 96 109 196617 /*/module_name/get;#P newex 276 188 188 196617 jcom.receive dumb;#P newex 314 159 161 196617 jcom.send jcom.remote.module.to;#P window linecount 4;#P comment 49 81 192 196617 -> to be replaced with dedicated jcom.receive ?: \; - to avoid risks of overhead due to useless global receive;#P user panel 35 48 215 150;#X brgb 191 191 191;#X frgb 0 0 0;#X border 1;#X rounded 0;#X shadow 0;#X done;#P fasten 23 0 30 0 51 204 17 204;#P connect 30 0 29 0;#P fasten 8 1 11 0 322 235 55 235;#P connect 30 1 11 0;#P connect 11 0 12 0;#P connect 12 0 13 0;#P connect 13 0 14 0;#P fasten 26 1 15 0 511 466 55 466;#P fasten 19 0 15 0 161 466 55 466;#P fasten 17 1 15 0 237 466 55 466;#P connect 14 0 15 0;#P connect 12 1 10 0;#P connect 10 1 9 0;#P connect 9 0 17 0;#P connect 17 0 18 0;#P connect 18 0 19 0;#P fasten 16 0 18 1 293 412 201 412;#P connect 27 0 26 0;#P connect 26 0 4 0;#P connect 4 0 5 0;#P connect 5 0 6 0;#P fasten 7 0 3 0 357 181 281 181;#P connect 6 0 3 0;#P connect 3 0 8 0;#P fasten 22 1 16 0 392 359 293 359;#P fasten 15 0 16 0 55 494 275 494 275 380 293 380;#P connect 21 0 16 0;#P connect 20 0 21 0;#P connect 5 1 2 0;#P connect 9 1 22 0;#P connect 22 0 20 0;#P connect 20 0 16 1;#P fasten 22 1 16 1 392 388 333 388;#P connect 5 2 7 0;#P pop;#P newobj 72 102 122 196626 p analyze0.4;#P window setfont "Sans Serif" 9.;#N coll jcom.modules_instances 1;#P newobj 39 188 147 196617 coll jcom.modules_instances 1;#P button 39 68 15 0;#P newex 84 210 69 196617 route symbol;#P newex 39 145 72 196617 qlim;#P newex 39 166 154 196617 t dump clear;#N comlet module names;#P outlet 84 236 15 0;#P connect 11 0 4 0;#P fasten 9 0 2 0 77 97 44 97;#P fasten 4 0 2 0 44 97 44 97;#P fasten 6 0 2 0 77 137 44 137;#P fasten 2 0 1 0 44 155 44 155;#P connect 1 0 5 0;#P fasten 7 0 8 0 129 48 77 48;#P fasten 10 0 8 0 77 49 77 49;#P connect 8 0 9 0;#P fasten 9 0 6 0 77 97 77 97;#P fasten 4 0 6 0 44 97 77 97;#P connect 5 1 3 0;#P connect 3 0 0 0;#P fasten 5 0 13 0 44 207 163 207;#P connect 1 1 12 0;#P pop;