if (global.unlockedLevel >= levelNumber) {

    // Go to the actual level room
    switch (levelNumber) 
	{
        case 1: room_goto(r1); break;
        case 2: room_goto(r2); break;
        case 3: room_goto(r3); break;
        case 4: room_goto(r4); break;
		case 5: room_goto(r5); break;
        case 6: room_goto(r6); break;
        case 7: room_goto(r7); break;
        case 8: room_goto(r8); break;
		case 9: room_goto(r9); break;
        case 10: room_goto(ra10); break;
	}
}