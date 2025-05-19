// Inherit the parent event
event_inherited();
levelNumber = 7;

if (global.unlockedLevel < levelNumber) 
{
    sprite_index = sLevelLock;
} else 
{
    sprite_index = sLevelUnlock;
}