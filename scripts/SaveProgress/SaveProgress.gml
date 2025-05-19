function SaveProgress(){
	var data = {}; // Struct
    data.level_unlocked = global.unlockedLevel;
    
    var json = json_stringify(data);
    var path = global.save_file;

    var buffer = buffer_create(string_byte_length(json) + 1, buffer_grow, 1);
    buffer_write(buffer, buffer_string, json);
    buffer_save(buffer, path);
    buffer_delete(buffer);
}