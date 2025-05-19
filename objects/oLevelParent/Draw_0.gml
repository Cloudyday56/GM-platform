if (global.unlockedLevel >= levelNumber) 
{
    draw_sprite(sLevelUnlock, 0, x, y);
} else {
    draw_sprite(sLevelLock, 0, x, y);
}