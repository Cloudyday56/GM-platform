if (!ds_map_exists(global.collectedKeys, room)) {
    ds_map_add(global.collectedKeys, room, 0);
}

var keyBit = 1 << keyIndex;
var collected = ds_map_find_value(global.collectedKeys, room);

if (collected & keyBit) {
    instance_destroy();
}
