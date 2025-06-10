if variable_global_exists("collectedKeys")
{
	ds_map_replace(global.collectedKeys, room, 0);
	global.keyCount = 0;
}

global.save_file = "save_data.json";
LoadProgress();

