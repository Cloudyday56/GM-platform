if (oReset.reset)
{
    if (file_exists(global.save_file)) {
        file_delete(global.save_file);
    }
    oReset.reset = false;
}

room_goto(rLevels);

