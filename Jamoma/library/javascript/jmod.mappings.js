/*
 * Jamoma Mapping Manager
 * Tim Place
 * Copyright © 2006 Jamoma Development Group
 *
 * Input syntax:
 *	create mapping_name src_module/arg1/arg2/arg3 [optional algorithm] -> dst_module/arg1/arg2/arg3
 *	remove mapping_name
 *  modify mapping_name <message for algorithm>
 */

// GLOBALS
var mapping_names = new Array();
var mapping_sources = new Array();
var mapping_destinations = new Array();
var mapping_algorithms = new Array();


// SETUP
function setup()
{
	// set up assistance strings
	setinletassist(0, "create, remove, modify");
	setoutletassist(0, "connect to a thispatcher object");
}
setup.local = 1;
setup();


// INIT
function loadbang()
{
	//outlet(0, "script", "new", "mapping_object_r", "newex",0, 0, 200, 196617, "receive", "jmod.remote.fromModule");
	//outlet(0, "script", "new", "mapping_object_s", "newex",0, 1000, 200, 196617, "send", "jmod.remote.toModule");	
}


// CREATE
function create()
{
	// 0. Find the entry number for this new mapping
	var entry = 0;
	if(mapping_names){
		entry = mapping_names.length;
	}
	
	// 1. Error Checking
	if(arguments.length < 4){
		post("ERROR jmod.mappings: create requires at least 4 arguments (name, src, optional algorithm, arrow, dst) in order to make a mapping");post();
		return;
	}
	var arrow = arguments[arguments.length-2];
	if(arrow != '->'){
		post("ERROR jmod.mappings: create requires an arrow");post();
		return;
	}
	var name = arguments[0];
	for(var i=0; i < entry; i++){
		if(name == mapping_names[i]){
			post("ERROR jmod.mappings: mapping_name already exists, cannot create mapping");post();
			return;
		}
	}
	
	// 2. Record Keeping
	var src = arguments[1];
	var dst = arguments[arguments.length-1];
	var algo = null;
	if(arguments.length > 4){
		mapping_algorithms[entry] = new Array();
		for(var i=2; i < arguments.length-2; i++){
			mapping_algorithms[entry].push(arguments[i]);
		}
	}
	else{
		mapping_algorithms[entry] = null;
	}
	mapping_names[entry] = name;
	mapping_sources[entry] = src;
	mapping_destinations[entry] = dst;
	
	// 3. Finally Script the Patch...
	outlet(0, "script", "new", "mapping_object_src_"+entry, "newex",50, (entry+1)*70, 200, 196617, "receive", "/jmod/fromModule"+mapping_sources[entry]);
	outlet(0, "script", "new", "mapping_object_dst_"+entry, "newex",50, (entry+1)*70+40, 200, 196617, "send", "/jmod/toModule"+mapping_destinations[entry]);
	//outlet(0, "script", "connect", "mapping_object_r", 0, "mapping_object_osc_"+entry, 0);
	//outlet(0, "script", "connect", "mapping_object_dst_"+entry, 0, "mapping_object_s", 0);

	if(mapping_algorithms[entry] == null){
		outlet(0, "script", "connect", "mapping_object_src_"+entry, 0, "mapping_object_dst_"+entry, 0);
	}
	else{
		outlet(0, "script", "new", "mapping_object_alg_"+entry, "newex",50, (entry+1)*70+20, 200, 196617, mapping_algorithms[entry]);
		outlet(0, "script", "connect", "mapping_object_src_"+entry, 0, "mapping_object_alg_"+entry, 0);
		outlet(0, "script", "connect", "mapping_object_alg_"+entry, 0, "mapping_object_dst_"+entry, 0);
	}	
}


// DELETE
function remove(mapping_name)
{
	// first, find the index number of the named mapping
	if(mapping_names.length == 0){
		post("ERROR jmod.mappings: no such mapping to remove!"); post();
		return 0;
	}
	var entry = getindex(mapping_name);
		
	// second, delete all of the objects that are associated with this mapping
	outlet(0, "script", "delete", "mapping_object_src_"+entry);
	outlet(0, "script", "delete", "mapping_object_dst_"+entry);
	if(mapping_algorithms[entry] != null){
		outlet(0, "script", "delete", "mapping_object_alg_"+entry);
	}

	// third, remove the entry for the mapping from the array
	mapping_names[entry] = null;
	mapping_sources[entry] = null;
	mapping_algorithms[entry] = null;
	mapping_destinations[entry] = null;

	return 1;
}


// MODIFY
// send a message to the algorithm to change its behavior
function modify()
{
	var entry = getindex(arguments[0]);
	var args = new Array();
	for(var i=1; i<arguments.length; i++){
		args[i-1] = arguments[i];
	}
	outlet(0, "script", "send", "mapping_object_alg_"+entry, args);
}


// CLEAR - erases all mappings
function clear()
{
	for(var i=0; i<mapping_names.length; i++){
		remove(mapping_names[i]);
	}
	while(mapping_names.pop());
	while(mapping_sources.pop());
	while(mapping_destinations.pop());
	while(mapping_algorithms.pop());
}


// Private method used by the others for finding the index number associated with a name
function getindex(mapping_name)
{
	var entry;
	for(var i=0; i<mapping_names.length; i++){
		if(mapping_name == mapping_names[i]){
			entry = i;
		}
	}
	return entry;
}
getindex.local = 1;
