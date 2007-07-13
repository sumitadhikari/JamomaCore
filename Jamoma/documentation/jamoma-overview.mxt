max v2;#N vpatcher 9 49 233 284;#P window setfont "Sans Serif" 9.;#P window linecount 1;#N vpatcher 309 61 765 351;#P origin 0 14;#P window setfont "Sans Serif" 9.;#P window linecount 1;#P message 211 224 73 196617 jcom.slider.js;#P message 211 206 101 196617 jcom.jsui_3dknob.js;#P hidden newex 267 265 64 196617 prepend help;#P hidden newex 267 289 45 196617 pcontrol;#P message 211 189 116 196617 jcom.jsui_texttoggle.js;#P message 211 171 111 196617 jcom.jsui_multigain.js;#P window linecount 2;#P comment 45 94 373 196617 Some of the scripts are used for particular purposes in specific modules or components. Only javascripts that might be of more general use are listed here.;#B frgb 67 65 107;#P window linecount 1;#P message 58 189 112 196617 jcom.js_systeminfo.js;#P window linecount 0;#P message 58 171 78 196617 jcom.js_link.js;#P window setfont "Sans Serif" 18.;#P window linecount 1;#P comment 44 38 189 196626 Jamoma javascripts;#B frgb 255 255 255;#P window setfont "Sans Serif" 9.;#P comment 45 64 277 196617 Overview of javascripts used in Jamoma;#B frgb 255 255 255;#P user panel 38 22 292 63;#X brgb 67 65 107;#X frgb 128 11 10;#X border 0;#X rounded 0;#X shadow 0;#X done;#P window setfont "Sans Serif" 18.;#P window linecount 0;#P comment 196 139 189 196626 JSUI;#B frgb 67 65 107;#P comment 44 139 113 196626 JS;#B frgb 67 65 107;#P hidden connect 5 0 11 0;#P hidden connect 6 0 11 0;#P hidden connect 8 0 11 0;#P hidden connect 9 0 11 0;#P hidden connect 12 0 11 0;#P hidden connect 13 0 11 0;#P hidden connect 11 0 10 0;#P pop;#P newobj 32 161 75 196617 p javascripts;#N vpatcher 301 220 1277 770;#P window setfont "Sans Serif" 9.;#P window linecount 1;#P message 47 387 126 196617 jcom.modules_dumper;#P message 47 404 126 196617 jcom.parameters_dumper;#P message 47 421 119 196617 jcom.messages_dumper;#P message 47 439 119 196617 jcom.returns_dumper;#P hidden button 31 473 15 0;#P message 47 456 119 196617 jcom.attributes_dumper;#P message 47 473 103 196617 jcom.*_dumper;#P window setfont "Sans Serif" 18.;#P comment 28 358 210 196626 Namespace analysis;#B frgb 67 65 107;#P window setfont "Sans Serif" 9.;#P window linecount 0;#P message 300 258 81 196617 jcom.cpu_timer;#P message 496 382 94 196617 jcom.numberslider;#P message 746 420 81 196617 jcom.multi.out%;#P message 746 399 75 196617 jcom.multi.in%;#P comment 746 382 192 196617 Audio multi cable;#B frgb 67 65 107;#P message 740 331 70 196617 jcom.spray%;#P message 833 290 91 196617 jcom.float2char%;#P message 739 290 91 196617 jcom.char2float%;#P comment 732 190 192 196617 Jitter related things:;#B frgb 67 65 107;#P window setfont "Sans Serif" 18.;#P comment 732 160 164 196626 Video;#B frgb 67 65 107;#P window setfont "Sans Serif" 9.;#P message 300 348 103 196617 jcom.list2parameter;#P message 739 270 97 196617 jcom.checkplanes%;#P message 828 311 86 196617 jcom.luma2rgb%;#P message 740 311 86 196617 jcom.rgb2luma%;#P message 496 400 60 196617 jcom.vtext;#P message 497 477 55 196617 jcom.dbap;#P comment 490 453 192 196617 Distance based amplitude panning:;#B frgb 67 65 107;#P window setfont "Sans Serif" 18.;#P comment 490 421 164 196626 Spatialisation;#B frgb 67 65 107;#P window setfont "Sans Serif" 9.;#P message 300 312 50 196617 jcom.init;#P message 496 363 80 196617 jcom.textslider;#P comment 489 341 192 196617 LCD-based widgets:;#B frgb 67 65 107;#P window setfont "Sans Serif" 18.;#P comment 489 311 164 196626 Widgets;#B frgb 67 65 107;#P window setfont "Sans Serif" 9.;#P comment 489 190 192 196617 Geometric convertions:;#B frgb 67 65 107;#P hidden newex 651 477 64 196617 prepend help;#P hidden newex 651 501 45 196617 pcontrol;#P message 572 240 73 196617 jcom.aed2xyz;#P message 496 240 73 196617 jcom.xyz2aed;#P message 570 222 71 196617 jcom.deg2rad;#P message 496 222 71 196617 jcom.rad2deg;#P window setfont "Sans Serif" 18.;#P comment 489 160 164 196626 Geometry;#B frgb 67 65 107;#P window setfont "Sans Serif" 9.;#P message 299 404 60 196617 jcom.thru~;#P message 299 468 81 196617 jcom.multi.out~;#P message 299 450 75 196617 jcom.multi.in~;#P comment 264 435 192 196617 Audio multi cable;#B frgb 67 65 107;#P message 48 337 120 196617 jcom.pluggo.configassist;#P hidden newex 146 519 64 196617 prepend help;#P hidden newex 146 543 45 196617 pcontrol;#P comment 265 190 192 196617 Stuff that might come in handy:;#B frgb 67 65 107;#P window setfont "Sans Serif" 18.;#P comment 265 160 210 196626 Utilities;#B frgb 67 65 107;#P window setfont "Sans Serif" 9.;#P comment 27 297 192 196617 Turning modules into pluggos;#B frgb 67 65 107;#P window setfont "Sans Serif" 18.;#P comment 27 267 210 196626 Pluggo;#B frgb 67 65 107;#P window setfont "Sans Serif" 9.;#P comment 24 190 192 196617 Components required:;#B frgb 67 65 107;#P window setfont "Sans Serif" 18.;#P comment 24 160 210 196626 Building new modules;#B frgb 67 65 107;#P window setfont "Sans Serif" 9.;#P message 299 386 54 196617 jcom.thru;#P message 48 319 45 196617 jcom.pp;#P message 299 368 54 196617 jcom.post;#P message 300 330 51 196617 jcom.line;#P message 45 222 48 196617 jcom.gui;#P message 300 294 87 196617 jcom.filewatcher;#P message 300 276 76 196617 jcom.filesaver;#P message 739 252 81 196617 jcom.autosize%;#P message 300 240 77 196617 jcom.autoscale;#P message 739 233 105 196617 jcom.pwindow.mouse;#P message 496 276 43 196617 jcom.pi;#P message 45 240 103 196617 jcom.parameter.gain;#P message 739 215 83 196617 jcom.autocrop%;#P message 610 258 112 196617 jcom.ambimonitor2aed;#P message 496 258 112 196617 jcom.aed2ambimonitor;#P message 300 222 66 196617 jcom.absdiff;#P window linecount 2;#P comment 15 77 402 196617 "component" is a Jamoma nickname for a functionality used in one or more algorithms or modules \, implemented as a patch abstraction rather than an external or javascript.;#B frgb 67 65 107;#P comment 15 107 373 196617 Some of the components are used for particular purposes in specific modules. Only components that might be of more general use are listed here.;#B frgb 67 65 107;#P window setfont "Sans Serif" 18.;#P window linecount 1;#P comment 14 26 203 196626 Jamoma components;#B frgb 255 255 255;#P window setfont "Sans Serif" 9.;#P comment 15 52 277 196617 Overview of components used in Jamoma;#B frgb 255 255 255;#P user panel 8 10 292 63;#X brgb 67 65 107;#X frgb 128 11 10;#X border 0;#X rounded 0;#X shadow 0;#X done;#P hidden connect 69 0 67 0;#P hidden connect 70 0 67 0;#P hidden connect 71 0 67 0;#P hidden connect 68 0 67 0;#P hidden connect 66 0 67 0;#P hidden connect 67 0 65 0;#P hidden connect 65 0 28 0;#P hidden connect 63 0 28 0;#P hidden connect 45 0 28 0;#P hidden connect 16 0 28 0;#P hidden connect 19 0 28 0;#P hidden connect 20 0 28 0;#P hidden connect 18 0 28 0;#P hidden connect 17 0 28 0;#P hidden connect 15 0 28 0;#P hidden connect 14 0 28 0;#P hidden connect 12 0 28 0;#P hidden connect 29 0 28 0;#P hidden connect 32 0 28 0;#P hidden connect 31 0 28 0;#P hidden connect 33 0 28 0;#P hidden connect 53 0 28 0;#P hidden connect 5 0 28 0;#P hidden connect 9 0 28 0;#P hidden connect 28 0 27 0;#P hidden connect 62 0 40 0;#P hidden connect 60 0 40 0;#P hidden connect 61 0 40 0;#P hidden connect 49 0 40 0;#P hidden connect 48 0 40 0;#P hidden connect 35 0 40 0;#P hidden connect 36 0 40 0;#P hidden connect 37 0 40 0;#P hidden connect 38 0 40 0;#P hidden connect 44 0 40 0;#P hidden connect 10 0 40 0;#P hidden connect 6 0 40 0;#P hidden connect 7 0 40 0;#P hidden connect 11 0 40 0;#P hidden connect 8 0 40 0;#P hidden connect 50 0 40 0;#P hidden connect 51 0 40 0;#P hidden connect 13 0 40 0;#P hidden connect 52 0 40 0;#P hidden connect 56 0 40 0;#P hidden connect 57 0 40 0;#P hidden connect 58 0 40 0;#P hidden connect 40 0 39 0;#P pop;#P newobj 32 187 75 196617 p components;#N vpatcher 310 62 919 556;#P window setfont "Sans Serif" 9.;#P window linecount 0;#P message 186 153 83 196617 jcom.colorspace;#P message 186 333 58 196617 jcom.stats;#P message 186 171 113 196617 jcom.cubic_interpolate;#P message 186 351 72 196617 jcom.velocity;#P message 186 207 63 196617 jcom.delta2;#P message 186 189 57 196617 jcom.delta;#P message 186 243 55 196617 jcom.gang;#P hidden newex 69 480 64 196617 prepend help;#P hidden newex 69 500 45 196617 pcontrol;#P window setfont "Sans Serif" 18.;#P comment 25 92 129 196626 Jamoma Core;#B frgb 67 65 107;#P window setfont "Sans Serif" 9.;#P message 186 439 71 196617 jcom.teabox~;#P message 186 422 98 196617 jcom.teabox.count~;#P message 186 405 91 196617 jcom.teabox.bits~;#P message 37 351 55 196617 jcom.send;#P message 37 333 64 196617 jcom.return;#P message 37 315 67 196617 jcom.remote;#P message 37 297 69 196617 jcom.receive;#P message 37 279 58 196617 jcom.ramp;#P message 37 261 82 196617 jcom.parameter;#P message 37 243 55 196617 jcom.out~;#P message 37 225 49 196617 jcom.out;#P message 37 207 73 196617 jcom.message;#P message 37 189 50 196617 jcom.init;#P message 37 153 43 196617 jcom.in;#P message 37 171 49 196617 jcom.in~;#P message 37 135 50 196617 jcom.hub;#P window setfont "Sans Serif" 18.;#P comment 466 92 112 196626 Video;#B frgb 67 65 107;#P window setfont "Sans Serif" 9.;#P message 484 135 62 196617 jcom.sum%;#P window setfont "Sans Serif" 18.;#P comment 25 32 189 196626 Jamoma externals;#B frgb 255 255 255;#P window setfont "Sans Serif" 9.;#P comment 26 58 277 196617 Overview of externals included in the Jamoma distribution.;#B frgb 255 255 255;#P user panel 19 16 292 63;#X brgb 67 65 107;#X frgb 128 11 10;#X border 0;#X rounded 0;#X shadow 0;#X done;#P window setfont "Sans Serif" 18.;#P comment 172 92 112 196626 Control;#B frgb 67 65 107;#P comment 319 92 112 196626 Audio;#B frgb 67 65 107;#P window setfont "Sans Serif" 9.;#P hidden newex 356 305 64 196617 prepend help;#P hidden newex 356 325 45 196617 pcontrol;#P message 186 225 63 196617 jcom.equals;#P message 186 261 74 196617 jcom.oscroute;#P message 186 297 60 196617 jcom.round;#P message 186 315 59 196617 jcom.route;#P message 186 279 55 196617 jcom.pass;#P message 186 135 65 196617 jcom.change;#P window linecount 1;#P message 335 171 68 196617 jcom.meter~;#P message 335 189 87 196617 jcom.saturation~;#P message 335 135 59 196617 jcom.gain~;#P message 335 153 72 196617 jcom.limiter~;#P message 335 207 66 196617 jcom.xfade~;#P hidden connect 32 0 38 0;#P hidden connect 31 0 38 0;#P hidden connect 30 0 38 0;#P hidden connect 29 0 38 0;#P hidden connect 28 0 38 0;#P hidden connect 27 0 38 0;#P hidden connect 26 0 38 0;#P hidden connect 25 0 38 0;#P hidden connect 24 0 38 0;#P hidden connect 23 0 38 0;#P hidden connect 21 0 38 0;#P hidden connect 22 0 38 0;#P hidden connect 20 0 38 0;#P hidden connect 38 0 37 0;#P hidden connect 42 0 12 0;#P hidden connect 44 0 12 0;#P hidden connect 41 0 12 0;#P hidden connect 40 0 12 0;#P hidden connect 43 0 12 0;#P hidden connect 45 0 12 0;#P hidden connect 18 0 12 0;#P hidden connect 10 0 12 0;#P hidden connect 9 0 12 0;#P hidden connect 8 0 12 0;#P hidden connect 7 0 12 0;#P hidden connect 6 0 12 0;#P hidden connect 5 0 12 0;#P hidden connect 0 0 12 0;#P hidden connect 1 0 12 0;#P hidden connect 2 0 12 0;#P hidden connect 3 0 12 0;#P hidden connect 4 0 12 0;#P hidden connect 33 0 12 0;#P hidden connect 34 0 12 0;#P hidden connect 35 0 12 0;#P hidden connect 39 0 12 0;#P hidden connect 12 0 11 0;#P pop;#P newobj 33 135 74 196617 p externals;#N vpatcher 339 141 989 466;#P origin 0 15;#P window setfont "Sans Serif" 9.;#P window linecount 1;#P comment 437 118 192 196617 Communication in Jamoma;#B frgb 67 65 107;#P comment 437 249 192 196617 Mapping example;#B frgb 67 65 107;#P comment 28 118 192 196617 Jamoma and Pluggo;#B frgb 67 65 107;#P window setfont "Sans Serif" 18.;#P comment 229 22 189 196626 Video;#B frgb 67 65 107;#P window setfont "Sans Serif" 9.;#P message 437 84 91 196617 WindowShade.mxt;#P message 437 159 99 196617 wildcard_demo.mxt;#P message 229 60 98 196617 Video_Example.mxt;#P message 437 267 63 196617 teatrix.mxt;#P message 28 60 107 196617 simpleRecorder~.mxt;#P message 437 137 116 196617 separate-interface.mxt;#P message 437 60 115 196617 Scripting_Example.mxt;#P message 28 137 96 196617 Pluggo_Simple.mxt;#P message 28 159 104 196617 Pluggo_Complex.mxt;#P message 437 223 116 196617 jmod.qlist.example.mxt;#P message 437 181 119 196617 jmod.pattr.example.mxt;#P window linecount 0;#P hidden newex 283 313 66 196617 prepend load;#P window linecount 1;#P message 437 202 148 196617 jmod.pattr.communication.mxt;#P hidden newex 283 334 45 196617 pcontrol;#P window setfont "Sans Serif" 18.;#P window linecount 0;#P comment 437 22 189 196626 Control;#B frgb 67 65 107;#P comment 28 22 189 196626 Audio;#B frgb 67 65 107;#P hidden connect 3 0 4 0;#P hidden connect 6 0 4 0;#P hidden connect 5 0 4 0;#P hidden connect 7 0 4 0;#P hidden connect 8 0 4 0;#P hidden connect 9 0 4 0;#P hidden connect 10 0 4 0;#P hidden connect 11 0 4 0;#P hidden connect 12 0 4 0;#P hidden connect 13 0 4 0;#P hidden connect 15 0 4 0;#P hidden connect 14 0 4 0;#P hidden connect 4 0 2 0;#P pop;#P newobj 33 109 74 196617 p examples;#N vpatcher 360 61 1237 786;#P origin 30 6;#P window setfont "Sans Serif" 9.;#P message 707 192 83 196617 jmod.mouse.gdif;#P message 707 138 73 196617 jmod.bcf2000;#P window linecount 1;#P message 262 156 88 196617 jmod.sur.rolloff~;#P message 491 200 62 196617 jmod.blur%;#P window linecount 0;#P message 38 396 88 196617 jmod.multidelay~;#P window linecount 1;#P comment 469 590 155 196617 Others;#B frgb 67 65 107;#P message 491 624 94 196617 jmod.background%;#P message 491 606 89 196617 jmod.similarity%;#P message 491 660 97 196617 jmod.motiongram%;#P message 707 434 94 196617 jmod.file_browser;#P message 41 511 64 196617 jmod.noise~;#P message 41 493 59 196617 jmod.sine~;#P message 41 476 86 196617 jmod.fluidsynth~;#P comment 17 455 192 196617 Synths;#B frgb 67 65 107;#P message 491 561 102 196617 jmod.gl.videoplane%;#P comment 469 546 192 196617 OpenGL;#B frgb 67 65 107;#P message 491 520 66 196617 jmod.palette;#P message 491 502 86 196617 jmod.colorpicker;#P comment 469 487 192 196617 Colors;#B frgb 67 65 107;#P message 491 426 69 196617 jmod.yfade%;#P message 491 148 74 196617 jmod.record%;#P window linecount 0;#P message 491 462 90 196617 jmod.keyscreen%;#P message 491 444 93 196617 jmod.chromakey%;#P message 707 228 66 196617 jmod.wacom;#P message 707 373 91 196617 jmod.trig_mapper;#P message 38 360 82 196617 jmod.equalizer~;#P message 707 355 93 196617 jmod.cont_mapper;#P message 38 324 61 196617 jmod.echo~;#P message 262 207 115 196617 jmod.sur.speaker.setup;#P comment 236 188 192 196617 Loudspeaker setup and correction;#B frgb 67 65 107;#P hidden newex 377 445 64 196617 prepend help;#P hidden newex 377 469 45 196617 pcontrol;#P window setfont "Sans Serif" 18.;#P comment 226 85 189 196626 Audio - spatialisation;#B frgb 67 65 107;#P window setfont "Sans Serif" 9.;#P comment 236 115 192 196617 General modules;#B frgb 67 65 107;#P message 262 399 111 196617 jmod.sur.ambi.adjust~;#P message 262 312 87 196617 jmod.sur.output~;#P message 262 294 99 196617 jmod.sur.multi.out~;#P message 262 276 93 196617 jmod.sur.multi.in~;#P comment 236 259 192 196617 Multicable;#B frgb 67 65 107;#P comment 236 346 192 196617 Ambisonics;#B frgb 67 65 107;#P message 262 225 121 196617 jmod.sur.speaker.delay~;#P message 262 138 92 196617 jmod.sur.doppler~;#P message 262 381 113 196617 jmod.sur.ambi.decode~;#P message 262 363 121 196617 jmod.sur.ambi.encodeM~;#P message 38 233 66 196617 jmod.scope~;#P message 491 182 66 196617 jmod.avg4%;#P message 491 273 79 196617 jmod.fluoride%;#P message 491 255 77 196617 jmod.emboss%;#P hidden newex 178 547 64 196617 prepend help;#P hidden newex 178 571 45 196617 pcontrol;#P comment 469 375 192 196617 Compositing;#B frgb 67 65 107;#P comment 469 164 192 196617 Filters;#B frgb 67 65 107;#P comment 469 115 192 196617 Video I/O;#B frgb 67 65 107;#P message 491 408 69 196617 jmod.xfade%;#P message 491 129 66 196617 jmod.input%;#P message 491 237 64 196617 jmod.edge%;#P message 491 327 62 196617 jmod.plur%;#P comment 683 394 155 196617 Others;#B frgb 67 65 107;#P comment 683 280 155 196617 Controlling Jamoma;#B frgb 67 65 107;#P message 707 156 62 196617 jmod.midiin;#P comment 683 115 155 196617 Data I/O;#B frgb 67 65 107;#P message 707 174 63 196617 jmod.mouse;#P message 491 309 72 196617 jmod.orsize%;#P window setfont "Sans Serif" 18.;#P comment 683 85 152 196626 Control;#B frgb 67 65 107;#P comment 469 85 189 196626 Video;#B frgb 67 65 107;#P window setfont "Sans Serif" 9.;#P comment 17 269 192 196617 Audio FX;#B frgb 67 65 107;#P comment 17 190 192 196617 Mixing and Metering;#B frgb 67 65 107;#P comment 17 115 192 196617 Audio I/O;#B frgb 67 65 107;#P window setfont "Sans Serif" 18.;#P comment 17 85 189 196626 Audio;#B frgb 67 65 107;#P window setfont "Sans Serif" 9.;#P message 707 247 64 196617 jmod.oscnet;#P message 491 291 70 196617 jmod.mblur%;#P message 707 337 68 196617 jmod.mapper;#P message 707 210 43 196617 jmod.hi;#P message 38 378 72 196617 jmod.limiter~;#P message 38 138 63 196617 jmod.input~;#P message 491 345 67 196617 jmod.wake%;#P message 38 432 87 196617 jmod.saturation~;#P message 38 288 76 196617 jmod.degrade~;#P message 707 416 67 196617 jmod.qmetro;#P message 38 156 69 196617 jmod.output~;#P message 707 301 67 196617 jmod.control;#P message 38 306 65 196617 jmod.delay~;#P message 38 342 65 196617 jmod.filter~;#P message 707 319 65 196617 jmod.cuelist;#P message 491 390 54 196617 jmod.op%;#P message 38 414 83 196617 jmod.noisegate~;#P message 491 219 74 196617 jmod.brcosa%;#P message 491 642 74 196617 jmod.motion%;#P message 38 215 85 196617 jmod.crossfade~;#P hidden newex 707 519 64 196617 prepend help;#P hidden newex 707 543 45 196617 pcontrol;#P window setfont "Sans Serif" 18.;#P comment 15 23 189 196626 Jamoma modules;#B frgb 255 255 255;#P window setfont "Sans Serif" 9.;#P comment 16 49 277 196617 Overview of modules;#B frgb 255 255 255;#P user panel 9 7 292 63;#X brgb 67 65 107;#X frgb 128 11 10;#X border 0;#X rounded 0;#X shadow 0;#X done;#P hidden connect 89 0 45 0;#P hidden connect 81 0 45 0;#P hidden connect 82 0 45 0;#P hidden connect 83 0 45 0;#P hidden connect 19 0 45 0;#P hidden connect 14 0 45 0;#P hidden connect 5 0 45 0;#P hidden connect 16 0 45 0;#P hidden connect 12 0 45 0;#P hidden connect 11 0 45 0;#P hidden connect 20 0 45 0;#P hidden connect 8 0 45 0;#P hidden connect 17 0 45 0;#P hidden connect 49 0 45 0;#P hidden connect 66 0 45 0;#P hidden connect 68 0 45 0;#P hidden connect 45 0 44 0;#P hidden connect 65 0 63 0;#P hidden connect 59 0 63 0;#P hidden connect 51 0 63 0;#P hidden connect 50 0 63 0;#P hidden connect 58 0 63 0;#P hidden connect 57 0 63 0;#P hidden connect 56 0 63 0;#P hidden connect 53 0 63 0;#P hidden connect 52 0 63 0;#P hidden connect 91 0 63 0;#P hidden connect 63 0 62 0;#P hidden connect 93 0 4 0;#P hidden connect 92 0 4 0;#P hidden connect 86 0 4 0;#P hidden connect 87 0 4 0;#P hidden connect 85 0 4 0;#P hidden connect 84 0 4 0;#P hidden connect 73 0 4 0;#P hidden connect 71 0 4 0;#P hidden connect 72 0 4 0;#P hidden connect 69 0 4 0;#P hidden connect 70 0 4 0;#P hidden connect 40 0 4 0;#P hidden connect 38 0 4 0;#P hidden connect 39 0 4 0;#P hidden connect 37 0 4 0;#P hidden connect 34 0 4 0;#P hidden connect 32 0 4 0;#P hidden connect 31 0 4 0;#P hidden connect 15 0 4 0;#P hidden connect 24 0 4 0;#P hidden connect 22 0 4 0;#P hidden connect 21 0 4 0;#P hidden connect 10 0 4 0;#P hidden connect 13 0 4 0;#P hidden connect 18 0 4 0;#P hidden connect 23 0 4 0;#P hidden connect 9 0 4 0;#P hidden connect 7 0 4 0;#P hidden connect 6 0 4 0;#P hidden connect 47 0 4 0;#P hidden fasten 46 0 4 0 492 270;#P hidden connect 48 0 4 0;#P hidden connect 67 0 4 0;#P hidden connect 74 0 4 0;#P hidden connect 76 0 4 0;#P hidden connect 77 0 4 0;#P hidden connect 79 0 4 0;#P hidden connect 90 0 4 0;#P hidden connect 4 0 3 0;#P pop;#P newobj 33 83 74 196617 p modules;#P window setfont "Sans Serif" 18.;#P comment 6 16 189 196626 Jamoma;#B frgb 255 255 255;#P window setfont "Sans Serif" 9.;#P window linecount 2;#P comment 7 42 188 196617 Overview of modules \, examples \, externals \, javascripts and components;#B frgb 255 255 255;#P user panel 0 0 205 72;#X brgb 67 65 107;#X frgb 128 11 10;#X border 0;#X rounded 0;#X shadow 0;#X done;#P pop;