max v2;#N vpatcher 547 70 1206 547;#P origin -583 -122;#P user jit.cellblock 482 224 600 342 3 9 1 1 45 17 0 1 1 0 0 0 1 1 1 0 0 0 255 255 255 0 0 0 0 0 0 191 191 191 0 0 0 215 215 240 1 1 1 0 4 0 0 0;#P window setfont "Sans Serif" 9.;#P window linecount 1;#P newex 462 132 27 196617 t b l;#P newex 462 111 73 196617 prepend setall;#P user swatch 462 75 128 32;#P newex 462 159 105 196617 jit.matrix 4 char 1 1;#P inlet 218 53 15 0;#P newex 218 139 27 196617 + 1;#P toggle 218 120 15 0;#P newex 218 160 55 196617 switch 2 1;#P inlet 262 53 15 0;#P newex 74 141 69 196617 speedlim 200;#P newex 74 120 65 196617 jcom.change;#P message 74 102 51 196617 \$2 \$3 \$4;#P newex 60 80 53 196617 jit.3m;#B color 5;#P outlet 200 439 15 0;#P inlet 42 56 15 0;#P hidden message 387 239 21 196617 0.1;#P hidden message 342 239 21 196617 0.2;#P hidden newex 342 216 44 196617 loadbang;#P newex 218 239 93 196617 unpack 0. 0. 0.;#P newex 218 216 77 196617 vexpr $i1/255.;#P user swatch 218 180 128 32;#P flonum 387 267 35 9 0 0 0 3 0 0 0 221 221 221 222 222 222 0 0 0;#P message 387 300 42 196617 fade \$1;#P flonum 342 267 35 9 0 0 0 3 0 0 0 221 221 221 222 222 222 0 0 0;#P message 342 301 35 196617 tol \$1;#P flonum 300 267 35 9 0 0 0 3 0 0 0 221 221 221 222 222 222 0 0 0;#P flonum 259 267 35 9 0 0 0 3 0 0 0 221 221 221 222 222 222 0 0 0;#P flonum 218 267 35 9 0 0 0 3 0 0 0 221 221 221 222 222 222 0 0 0;#P flonum 177 267 35 9 0 0 0 3 0 0 0 221 221 221 222 222 222 0 0 0;#P newex 136 301 177 196617 pak color 0. 0. 0. 0.;#P newex 200 386 71 196617 jit.chromakey;#B color 5;#P fasten 16 0 18 0 47 76 65 76;#P connect 18 1 19 0;#P connect 19 0 20 0;#P connect 20 0 21 0;#P connect 2 0 1 1;#P fasten 16 0 0 0 47 369 205 369;#P fasten 8 0 0 0 392 350 205 350;#P fasten 6 0 0 0 347 351 205 351;#P fasten 1 0 0 0 141 352 205 352;#P connect 0 0 17 0;#P connect 26 0 24 0;#P connect 24 0 25 0;#P connect 25 0 23 0;#P connect 23 0 10 0;#P connect 21 0 11 0;#P connect 10 0 11 0;#P connect 11 0 12 0;#P connect 12 0 3 0;#P connect 3 0 1 2;#P connect 21 0 23 1;#P connect 12 1 4 0;#P connect 4 0 1 3;#P fasten 27 0 0 1 467 375 266 375;#P connect 22 0 23 2;#P connect 12 2 5 0;#P connect 5 0 1 4;#P hidden connect 13 0 14 0;#P hidden connect 14 0 7 0;#P connect 7 0 6 0;#P hidden fasten 13 0 15 0 347 235 392 235;#P hidden connect 15 0 9 0;#P connect 9 0 8 0;#P connect 28 0 29 0;#P connect 29 0 30 0;#P connect 30 1 27 0;#P connect 30 0 27 0;#P connect 27 0 31 0;#P pop;