yspeed += 0.1 //gravity?
xspeed = 0

if (keyboard_check(ord("A")))
{
    xspeed = -1;
}
if (keyboard_check(ord("D"))) {
    xspeed = +1;
}
//jump
if (place_meeting(x, y+1, oGround))
{
    yspeed = 0;
    if (keyboard_check(ord("W")))
    {
        yspeed = -3;
    }
}

if (place_meeting(x, y+1, oWall))
{
    yspeed = 0;
}

move_and_collide(xspeed, yspeed, oGround)
move_and_collide(xspeed, yspeed, oWall)

//spike and flag
if place_meeting(x, y+1, oDoor)
{
    room_goto_next()
}
