if (global.unlockedLevel >= levelNumber) 
{
    draw_sprite_ext(sLevelUnlock, 0, x, y, 1.5, 1.5, 0, c_white, 1);
} else {
    draw_sprite_ext(sLevelLock, 0, x, y, 1.5, 1.5, 0, c_white, 1);
}