max v2;
#N vpatcher 79 119 465 518;
#P window setfont "Sans Serif" 9.;
#P window linecount 1;
#N vpatcher 33 59 633 459;
#P window setfont "Sans Serif" 9.;
#P newex 67 247 80 196617 prepend symbol;
#P window linecount 1;
#P newex 281 191 25 196617 iter;
#P newex 281 215 78 196617 prepend append;
#P user umenu 67 288 100 196647 1 64 304 1;
#X add;
#P newex 188 161 196 196617 t 2 l clear;
#P window linecount 0;
#P newex 188 135 70 196617 route choices;
#P newex 30 210 47 196617 gate 2 1;
#P outlet 30 366 15 0;
#P inlet 188 111 15 0;
#P inlet 67 111 15 0;
#P comment 28 42 259 196617 In case of a menu: handle symbol;
#P fasten 6 0 4 0 193 199 35 199;
#P connect 4 0 3 0;
#P connect 7 0 3 0;
#P connect 1 0 4 1;
#P connect 4 1 10 0;
#P connect 10 0 7 0;
#P fasten 8 0 7 0 286 277 72 277;
#P fasten 6 2 7 0 379 277 72 277;
#P connect 2 0 5 0;
#P connect 5 0 6 0;
#P connect 6 1 9 0;
#P connect 9 0 8 0;
#P pop;
#P newobj 124 305 51 196617 p choices;
#N vpatcher 33 59 633 459;
#P window setfont "Sans Serif" 9.;
#P window linecount 1;
#P comment 35 49 259 196617 In case of a menu: converts symbol to int;
#P window linecount 0;
#P newex 188 132 70 196617 route choices;
#P newex 30 210 47 196617 gate 2 1;
#P outlet 30 333 15 0;
#P newex 281 184 25 196617 iter;
#P newex 281 208 78 196617 prepend append;
#P user umenu 67 293 100 196647 1 64 309 1;
#X add;
#P newex 188 154 196 196617 t 2 l clear;
#P inlet 188 109 15 0;
#P inlet 67 111 15 0;
#P fasten 2 0 7 0 193 175 35 175;
#P connect 7 0 6 0;
#P connect 3 1 6 0;
#P connect 0 0 7 1;
#P fasten 2 2 3 0 379 282 72 282;
#P fasten 4 0 3 0 286 278 72 278;
#P connect 7 1 3 0;
#P connect 1 0 8 0;
#P connect 8 0 2 0;
#P connect 2 1 5 0;
#P connect 5 0 4 0;
#P pop;
#P newobj 126 125 51 196617 p choices;
#P newex 273 40 64 196617 patcherargs;
#P objectname u865000035;
#P newex 124 269 138 196617 route $1;
#P outlet 49 352 15 0;
#P inlet 49 40 15 0;
#P newex 126 149 138 196617 prepend $1;
#P newex 126 169 138 196617 s ---parameter_set;
#P newex 124 248 138 196617 r ---parameter_get;
#N pp $2 $3 $4 $5;
#P newobj 49 203 167 196617 pp $2 $3 $4 $5;
#P connect 4 0 0 0;
#P connect 9 0 5 0;
#P connect 0 0 5 0;
#P connect 1 0 6 0;
#P connect 6 0 9 0;
#P connect 4 0 8 0;
#P connect 8 0 3 0;
#P connect 3 0 2 0;
#P fasten 7 1 9 1 332 300 170 300;
#P fasten 7 1 8 1 332 96 172 96;
#P pop;
