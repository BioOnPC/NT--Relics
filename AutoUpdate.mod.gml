#define init
#macro URL "https://raw.githubusercontent.com/BioOnPC/NT--Relics/main/"
//this is just in case someone else uses the same name for a similar auto updater
#macro NAME "Relics"
//use this to set the version
#macro VERSION 0.12
//set to true to generate the json
#macro GENERATEJSON false

if(GENERATEJSON){
	generate_json();
}
//if you don't mind keeping it as a folder download, you can allowmod by using multiple txt files
while(!mod_sideload()){wait 1;}

//loading the previous version file. 
//The version file is a json-encoded file that has "version" as the version number 
//and an array "files" as the files to grab from the github.
//This file is how the mod knows whether to download a new version.
file_load(NAME+"version.json");
while (!file_loaded(NAME+"version.json")) {wait 1;}
var oldjson;
if(file_exists(NAME+"version.json")){
	oldjson = json_decode(string_load(NAME+"version.json"));
}

//downloading the new version file over the old one
//I delete for safety, there's a chance it isn't necessary
file_delete(NAME+"version.json");
while (file_exists(NAME+"version.json")) {wait 1;}
file_download(URL + "version.json", NAME+"version.json");
wait file_unload(NAME+"version.json");
file_load(NAME+"version.json");
while (!file_loaded(NAME+"version.json")) {wait 1;}
while (!file_exists(NAME+"version.json")) {wait 1;}
var newjson = json_decode(string_load(NAME+"version.json"));

//When this if statement runs it replaces the files, so if you want to implement a backup here is where you do it
if(!is_undefined(oldjson) && real(oldjson.version) < real(newjson.version)){
	trace("There is an update for "+NAME+"! updating...");
	for(var i = 0; i < array_length(newjson.files); i++){
		//This appears to be safe, not deleting anything from the mods directory.
		file_delete(newjson.files[i]);
		while (file_exists(newjson.files[i])) {wait 1;}
		file_download(URL + newjson.files[i], "../../mods/" + NAME + "/" + newjson.files[i]);
	}
	for(var i = 0; i < array_length(newjson.files); i++){
		file_load("../../mods/" + NAME + "/" + newjson.files[i]);
		while (!file_exists("../../mods/" + NAME + "/" + newjson.files[i])) {wait 1;}
		file_unload("../../mods/" + NAME + "/" + newjson.files[i]);
	}
}

if(!is_undefined(oldjson) && real(oldjson.version) < real(newjson.version) || VERSION < real(newjson.version)){
	//replace "main.txt" with whatever you want to load with.
	mod_loadtext("../../mods/" + NAME + "/" + "main.txt");
}

//This generates the json file for the current setup, just set the macro
#define generate_json
	if(fork()){
		while("forks" in global && global.forks != 0){wait(0);}
		if(!instance_exists(self)){return;}
		var arr = [];
		global.forks = 0;
		wait file_find_all("", arr);
		files = [];
		if(array_length(arr) == 0){
			files = [selected];
		}else{
			recursive_search(self, arr, "", "");
		}
		while(global.forks != 0){wait(0);}
		var json = {
			version : VERSION,
			files : files
		};
		string_save(json_encode(json), "nextversion.json");
		exit;
	}



#define recursive_search(window, arr, _path, p)
if(fork()){
	global.forks++;
	for(var i = 0; i < array_length(arr); i++){
		if(arr[i].is_dir){
			if(arr[i].name == ".git"){
				continue;
			}
			var _arr = [];
			wait file_find_all(_path + "/" + p + "/" + arr[i].name, _arr);
			if(!instance_exists(window)){global.forks--;exit;}
			recursive_search(window, _arr, _path, (p == "" ? "" : p + "/") + arr[i].name);
		}else{
			if(arr[i].name == ".gitattributes"){
				continue;
			}
			array_push(window.files, (p == "" ? "" : p + "/") + arr[i].name);
		}
	}
	global.forks--;
	exit;
}