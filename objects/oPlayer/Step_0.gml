getControls();



//X Movement
	//Direction
	moveDir = rightKey - leftKey;
	//Get face
	if moveDir != 0
	{
		face = moveDir;
	}

	//Get xspd
	moveType = runKey
	if !onGround 
	{
		moveType = 0;
	}
	xspeed = moveDir * moveSpd[moveType];

	//X collision ground
	var _subPixel = .5;
	if (place_meeting( x + xspeed, y, oGround ))
	{
	    //Scoot up to wall precisely
	    var _pixelCheck = _subPixel * sign(xspeed);
	    while (!place_meeting( x + _pixelCheck, y, oGround ))
	    {
	        x += _pixelCheck;
	    }

	    //Set xspd to zero to "collide"
	    xspeed = 0;
	}


	//x collision wall
	if (place_meeting( x + xspeed, y, oWall ))
	{
	    //Scoot up to wall precisely
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

	
	if coyoteHangTimer > 0
	{ 
		coyoteHangTimer --;
	}
	else
	{
		yspeed += grav;
		setOnGround(false);
	}



	//reset
	if onGround
	{ 
		jumpCount = 0
		coyoteJumpTimer = coyoteJumpFrame;
		
	} 
	else{
		coyoteJumpTimer --;
		if jumpCount == 0 && coyoteJumpTimer <=0
		{
			jumpCount = 2
		};
		coyoteHangTimer = 0;
	};

	//jump
	if jumpBuffered && jumpCount<jumpMax
	{
		
		jumpBuffered = false;
		jumpBufferTimer = 0;
	
		jumpCount ++;
	
	    jumpHoldTime = jumpHoldFrame;
		setOnGround(false); //no longer on ground
	
	}
	if !jump 
	{
		jumpHoldTime = 0;
	}

	if jumpHoldTime > 0
	{
		yspeed = jumpSpd;
		jumpHoldTime --;
	}



	//cap
	//if yspeed > termVel { yspeed = termVel};

	//Y collision ground
	var _subPixel = .5;
	if (place_meeting( x , y + yspeed, oGround ))
	{
	    //Scoot up to wall precisely
	    var _pixelCheck = _subPixel * sign(yspeed);
	    while (!place_meeting( x , y + _pixelCheck, oGround ))
	    {
	        y += _pixelCheck;
	    }
	
		if yspeed < 0
		{	jumpHoldTime = 0;
		}

	    //Set xspd to zero to "collide"
	    yspeed = 0;
	}


	//Y collision wall
	if (place_meeting( x , y + yspeed, oWall ))
	{
	    //Scoot up to wall precisely
	    var _pixelCheck = _subPixel * sign(yspeed);
	    while (!place_meeting( x , y + _pixelCheck, oWall ))
	    {
	        y += _pixelCheck;
	    }

	    //Set xspd to zero to "collide"
	    yspeed = 0;
	}
	
	//check onGround
	if (yspeed >= 0 && place_meeting(x, y+1, oGround))
	{
		setOnGround(true);

	}

	//check onWall
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





