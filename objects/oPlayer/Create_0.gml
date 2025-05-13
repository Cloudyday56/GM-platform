function setOnGround(val = true)
{
	if val
	{
		onGround = true;
		coyoteHangTimer = coyoteHangFrame;
	}else
	{
		onGround = false;
	}
}

window_set_size(1280, 720)
controlsSetup();



//sprites
spr_idle = sPlayer_idle;
spr_walk = sPlayer_walk;
spr_run = sPlayer_run;
spr_jump = sPlayer_jump;

//Moving
face = 1;
moveDir = 0; 

moveType = 0; //running or walking
moveSpd[0] = 2; //walking speed
moveSpd[1] = 3.5; //running speed

xspeed = 0;
yspeed = 0;


//Jumping
grav = .25;
termVel = 4;

jumpSpd = -4;

jumpMax = 2;
jumpCount = 0;
jumpHoldTime = 0;
jumpHoldFrame = 20;
onGround = true;


//coyote time

coyoteHangFrame = 2;
coyoteHangTimer = 0;

coyoteJumpFrame = 5;
coyoteJumpTimer = 0;



