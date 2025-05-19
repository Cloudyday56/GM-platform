function LoadProgress(){
	
	var path = global.save_file;

    if (file_exists(path)) {
        var buffer = buffer_load(path);
        var json = buffer_read(buffer, buffer_string);
        buffer_delete(buffer);
        
        var data = json_parse(json); // This returns a struct

        if (is_struct(data)) {
            // Use dot notation here
            global.unlockedLevel = data.level_unlocked;
        } else {
            // Fallback if parsing failed
            global.unlockedLevel = 1;
        }
    } else {
        global.unlockedLevel = 1;
    }
}