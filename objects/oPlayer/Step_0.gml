

//gravity?
yspeed += grav 
xspeed = 0

//horizontal input
if (keyboard_check(ord("A")))
{
    xspeed = -1;
}
if (keyboard_check(ord("D"))) {
    xspeed = +1;
}

//check if on the ground or wall
var on_ground = place_meeting(x, y + 1, oGround);
var on_wall = place_meeting(x, y + 1, oGround);
var can_reset_jumps = on_ground || on_wall;

//reset jumps if on wall or ground

if (can_reset_jumps) {
	current_jumps = max_jumps; //we set it for 2
}

//jump

if (keyboard_check(ord("W")) && current_jumps > 0)
{
    yspeed = -speed_jump;
	current_jumps--;
}

// vertical collision

if (place_meeting(x, y+yspeed, oGround) || place_meeting(x, y+yspeed, oWall))

{
  while (!place_meeting(x, y + sign(yspeed), oGround))
  && !place_meeting(x, y + sign(yspeed), oWall) {
		y += sign(yspeed);
	}
	
	yspeed = 0;
} else {
	y += yspeed;
}

//horizontal collision

if (!place_meeting(x + xspeed, y, oGround) && !place_meeting(x + xspeed, y, oWall)) {
    x += xspeed;
}


//spike and flag
if place_meeting(x, y+1, oDoor)
{
    room_goto_next()
}
