if variable_global_exists("collectedKeys")
{
	ds_map_replace(global.collectedKeys, room, 0);
	global.keyCount = 0;
}
room_goto(rLevels);
