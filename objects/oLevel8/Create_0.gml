// Inherit the parent event
event_inherited();
levelNumber = 8;

if (global.unlockedLevel < levelNumber) 
{
    sprite_index = sLevelLock;
} else 
{
    sprite_index = sLevelUnlock;
}