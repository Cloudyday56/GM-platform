getControls();

//X Movement
	//Direction
	moveDir = rightKey - leftKey;
	//Get face (facing which side)
	if moveDir != 0
	{
		face = moveDir;
	}

	//Get xspd
	moveType = runKey //whether or not run key is pressed
	if !onGround //cannot run in the air
	{
		moveType = 0;
	}
	xspeed = moveDir * moveSpd[moveType]; //walk or run depending on move type

	//X collision GROUND
	var _subPixel = .5;
	if (place_meeting( x + xspeed, y, oGround )) //obstacle!
	{
		//go up slope if there is one
		if !place_meeting(x+xspeed, y-abs(xspeed)-1, oGround)
		{
			while (place_meeting( x + xspeed, y, oGround ))
			{
				y -= _subPixel;
			}
		}
		else  //if no slope, check for ceiling, then regular collision
		{
			//ceiling (checking if any slope pushing downwards)
			if !place_meeting(x+xspeed, y+abs(xspeed)+1, oGround)
			{
				while (place_meeting( x + xspeed, y, oGround ))
				{
					y += _subPixel;
				}
			}else
			{
				var _pixelCheck = _subPixel * sign(xspeed);
		    while (!place_meeting( x + _pixelCheck, y, oGround ))
		    {
		        x += _pixelCheck;
		    }
			}

		    //Set xspeed to zero to "collide"
		    xspeed = 0;
		}
	}

	//going down slope
	if (yspeed >= 0 && !place_meeting( x + xspeed, y+1, oGround )
	&& (place_meeting( x + xspeed , y + abs(xspeed) +1, oGround )))
	{
		while (!place_meeting( x + xspeed, y+_subPixel, oGround ))
			{
				y += _subPixel;
			}
	}

	//x collision WALL
	if (place_meeting( x + xspeed, y, oWall ))
	{
	    //this chunk is not that necessary, it's for the player to touch exactly the wall/ground
	    var _pixelCheck = _subPixel * sign(xspeed);
	    while (!place_meeting( x + _pixelCheck, y, oWall ))
	    {
	        x += _pixelCheck;
	    }

	    //Set xspd to zero to "collide"
	    xspeed = 0;
	}

	//Move
	x += xspeed;

//Y Movement

	
	if coyoteHangTimer > 0 //it's above 0 when it's onGround (look at function setOnGround in Create)
	{ 
		coyoteHangTimer --;
	}
	else
	{
		yspeed += grav; //Apply gravity after coyote time
		setOnGround(false); //in the air
	}


	//reset if on ground or wall
	if onGround
	{ 
		jumpCount = 0 //reset jump count
		coyoteJumpTimer = coyoteJumpFrame; //(JUMP) reset coyote jump time
		
	} 
	else{//if falls
		coyoteJumpTimer --; 
		if jumpCount == 0 && coyoteJumpTimer <=0 //(JUMP) if in the air, did not jump, 
												 //and passed the coyote time, 
												 //cannot jump anymore
		{
			jumpCount = 2
		};
		coyoteHangTimer = 0; //(HANG) no more coyote hang time, i'm not sure if we need this line
	};

	//jump (jump buffer details in GenFns
	if jumpBuffered && jumpCount<jumpMax //if jumps 
	{
		
		jumpBuffered = false; //reset boolean
		jumpBufferTimer = 0; //not sure why, but necessary
	
		jumpCount ++; //increase jump count
	
	    jumpHoldTime = jumpHoldFrame; //can be held (look at next ifs)
		
		setOnGround(false); //no longer on ground
	
	}
	if !jump //if the W key is not held (just pressed
	{
		jumpHoldTime = 0; //don't hold
	}

	if jumpHoldTime > 0 //if hold
	{
		yspeed = jumpSpd; 
		jumpHoldTime --; //counts down for some frames (period for which the jump can be held)
	}

	//cap
	//if yspeed > termVel { yspeed = termVel}; //not necessary

	//Y collision ground
	var _subPixel = .5;
	if (place_meeting( x , y + yspeed, oGround ))
	{
	    //this chunk is not that necessary, it's for the player to touch exactly the wall/ground
	    var _pixelCheck = _subPixel * sign(yspeed);
	    while (!place_meeting( x , y + _pixelCheck, oGround ))
	    {
	        y += _pixelCheck;
	    }

		//if the player bumps into a "ceiling", it falls
		if yspeed < 0
		{	jumpHoldTime = 0;
		}

	    //Set xspd to zero to "collide"
	    yspeed = 0;
	}


	//Y collision wall
	if (place_meeting( x , y + yspeed, oWall ))
	{
	    //this chunk is not that necessary, it's for the player to touch exactly the wall/ground
	    var _pixelCheck = _subPixel * sign(yspeed);
	    while (!place_meeting( x , y + _pixelCheck, oWall ))
	    {
	        y += _pixelCheck;
	    }
		
		//if the player bumps into a "ceiling", it falls
		if yspeed < 0
		{	jumpHoldTime = 0;
		}

	    //Set xspd to zero to "collide"
	    yspeed = 0;
	}
	
	//check onGround
	if (yspeed >= 0 && place_meeting(x, y+1, oGround))
	{
		setOnGround(true);

	}

	//check "onWall"
	if (yspeed >= 0 && place_meeting(x, y+1, oWall))
	{
		setOnGround(true);

	}


	//Move
	y += yspeed;


//sprite control

	//walking
	if abs(xspeed) > 0 
	{sprite_index = spr_walk
	}
	if abs(xspeed) >= moveSpd[1]  //order matters
	{sprite_index = spr_run
	}
	if abs(xspeed) == 0 
	{sprite_index = spr_idle
	}
	if !onGround 
	{sprite_index = spr_jump
	}
		//set collision mask
		mask_index = spr_idle;




//Next level
if place_meeting(x, y+yspeed, oDoor)
{
    room_goto_next()
}





