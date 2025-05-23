
//function to determine onGround boolean (eaiser to use it in code)
function setOnGround(val = true)
{
	if val
	{
		onGround = true;
		if abs(xspeed) > 2.5
		{
			coyoteHangTimer = coyoteHangFrame + 5; //(HANG) sort of momentum for running
		}else
		{
			coyoteHangTimer = coyoteHangFrame; //(HANG) reset hang time
		}
		soundJumpCount = 0;
	}else
	{
		onGround = false;
		myFloorPlat = noone;
		coyoteHangTimer = 0;
	}
}

function check_for_semisolidplats(xPos, yPos)
{
	var rtrn = noone; //platform to be returned
	
	if yspeed >= 0 && place_meeting(xPos, yPos, oSemiSolidWall)
	{
		var semiwallList = ds_list_create(); 
		var lstSize = instance_place_list(xPos, yPos, oSemiSolidWall, semiwallList, false);
	
		//loop through every platforms
		for (var i = 0; i < lstSize; i++)
		{
			var inst = semiwallList[| i];
		
			//avoid sticking to platform, apparently
			if inst != forgetSemiSolid && floor(bbox_bottom) <= ceil(inst.bbox_top - inst.yspeed)
			{
				rtrn = inst; //found it
				i = lstSize; //exit
				
			}
		}	 
		ds_list_destroy(semiwallList);
	}
	
	return rtrn;
	
}



controlsSetup(); //import the code from the script


//different sprites for oPlayer
spr_idle = sPlayer_idle;
spr_walk = sPlayer_walk;
spr_run = sPlayer_run;
spr_jump = sPlayer_jump;

//state
crouching = false;
spr_crouch = sPlayer_crouching;
crouchSpd = 1;

//Moving

	face = 1; //facing left or right 
	moveDir = 0; //going left or right

	moveType = 0; //running or walking
	if room == ra10
	{
		moveSpd[0] = 8; //walking speed
		moveSpd[1] = 14; //running speed
		jumpSpd = -9;
	}
	else
	{
		moveSpd[0] = 2; //walking speed
		moveSpd[1] = 3.5; //running speed
		jumpSpd = -3; //jump speed (modify yspeed)
	}
	//used as moveSpd[moveType]

	xspeed = 0;
	yspeed = 0;


	//Jumping
	grav = .25; //gravity
	//termVel = 4; //speed upper bound, not necessary

	
	
	if room == r6//fly room
	{
		jumpMax = 1000;
		maxSoundJumpCount = 1000;
	}else
	{
		jumpMax = 2; //double jump
		maxSoundJumpCount = 2;
	}
	jumpCount = 0; //jump count
	

	jumpHoldTime = 0; 
	jumpHoldFrame = 15;

	onGround = true; //whether player is on the ground or in the air
	
	//wall jump
	horiJumpSpd = 3.5;
	vertJumpSpd = 2;


	//coyote time
	//grace period for falling off
	coyoteHangFrame = 2;
	coyoteHangTimer = 0;

	//grace period for making the jump after falling off
	coyoteJumpFrame = 5;
	coyoteJumpTimer = 0;


//moving platforms
myFloorPlat = noone;
earlyMovePlatSpd = false;
downSemiSolid = noone; //for checking semi solid underneath
forgetSemiSolid = noone; //to voluntarily go under the semisolid
movePlatXspeed = 0;



maxDroppingSpeed = 8; //to stick to platform


//collectables
global.keyCount = 0;

//death condition
dead = false;
counted_death = false;

switch (room)
{
    case r1: global.currentLevel = 1; break;
    case r2: global.currentLevel = 2; break;
    case r3: global.currentLevel = 3; break;
    case r4: global.currentLevel = 4; break;
	case r5: global.currentLevel = 5; break;
    case r6: global.currentLevel = 6; break;
    case r7: global.currentLevel = 7; break;
    case r8: global.currentLevel = 8; break;
	case r9: global.currentLevel = 9; break;
    case ra10: global.currentLevel = 10; break;

}



