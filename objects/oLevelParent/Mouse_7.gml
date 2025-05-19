if (global.unlockedLevel >= levelNumber) {

    // Go to the actual level room
    switch (levelNumber) 
	{
        case 1: room_goto(r1); break;
        case 2: room_goto(r2); break;
        case 3: room_goto(r3); break;
        case 4: room_goto(r4); break;
    }
}