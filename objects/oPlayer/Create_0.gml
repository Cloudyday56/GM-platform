
//function to determine onGround boolean (eaiser to use it in code)
function setOnGround(val = true)
{
	if val
	{
		onGround = true;
		coyoteHangTimer = coyoteHangFrame; //(HANG) reset hang time
	}else
	{
		onGround = false;
	}
}

window_set_size(1280, 720) //game window
controlsSetup(); //import the code from the script


//different sprites for oPlayer
spr_idle = sPlayer_idle;
spr_walk = sPlayer_walk;
spr_run = sPlayer_run;
spr_jump = sPlayer_jump;

//Moving
face = 1; //facing left or right 
moveDir = 0; //going left or right

moveType = 0; //running or walking
moveSpd[0] = 2; //walking speed
moveSpd[1] = 3.5; //running speed
//used as moveSpd[moveType]

xspeed = 0;
yspeed = 0;


//Jumping
grav = .25; //gravity
//termVel = 4; //speed upper bound, not necessary

jumpSpd = -4; //jump speed (modify yspeed)

jumpMax = 2; //double jump
jumpCount = 0; //jump count

jumpHoldTime = 0; 
jumpHoldFrame = 20;

onGround = true; //whether player is on the ground or in the air


//coyote time

//grace period for falling off
coyoteHangFrame = 2;
coyoteHangTimer = 0;

//grace period for making the jump after falling off
coyoteJumpFrame = 5;
coyoteJumpTimer = 0;



