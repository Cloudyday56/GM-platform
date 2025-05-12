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

if (keyboard_check(ord("W")) && current_jumps > 0)
{
    yspeed = -2;
	current_jumps--;
}

if (place_meeting(x, y+yspeed, oGround) || place_meeting(x, y+yspeed, Object4))
{
  while (!place_meeting(x, y + sign(yspeed), oGround)) {
		y += sign(yspeed);
	}
	
	if (yspeed > 0) {
		current_jumps = max_jumps;
	}
	
	yspeed = 0;
}

y += yspeed;

move_and_collide(xspeed, yspeed, oGround)
move_and_collide(xspeed, yspeed, Object4)

//spike and flag
if place_meeting(x, y+1, oDoor)
{
    room_goto_next()
}
