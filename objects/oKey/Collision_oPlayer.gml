

var keyBit = 1 << keyIndex;
var collected = ds_map_find_value(global.collectedKeys, room);
var count = ds_map_find_value(global.collectedKeys, room);

// Add this key to the map
collected |= keyBit;
ds_map_replace(global.collectedKeys, room, collected);


global.keyCount = bitcount(collected);
instance_destroy(); // remove the key from the room

audio_play_sound(key_pickup_sound, 0, false, 1, 11.56);
