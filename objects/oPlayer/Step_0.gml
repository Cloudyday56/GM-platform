getControls();

if dead 
{
    // Wait for key to restart
	x = -1;
	y = -1;
	
	if resetKey
	{
		room_restart();
	}

}
//moving solid:
#region
//Get out of any moving solid
	var rightWall = noone;
	var leftWall = noone;
	var botWall = noone;
	var topWall = noone;
	var wallLst = ds_list_create();
	var lstSize = instance_place_list(x, y, oGroundMove, wallLst, false);

	for (var i = 0; i < lstSize; i++;) 
	{
		var inst = wallLst[| i];
	
		//check right side
		if inst.bbox_left - inst.xspeed >= bbox_right -1
		{
			if !instance_exists(rightWall) || inst.bbox_left < rightWall.bbox_left
			{
				rightWall = inst;
			}
		}
		
		//check left
		if inst.bbox_right - inst.xspeed <= bbox_left +1
		{
			if !instance_exists(leftWall) || inst.bbox_right > leftWall.bbox_right
			{
				leftWall = inst;
			}
		}
		
		//check below
		if inst.bbox_top - inst.yspeed >= bbox_bottom -1
		{
			if !instance_exists(botWall) || inst.bbox_top < botWall.bbox_top
			{
				botWall = inst;
			}
		}
		
		//check above
		if inst.bbox_bottom - inst.yspeed <= bbox_top + 1
		{
			if !instance_exists(topWall) || inst.bbox_bottom > topWall.bbox_bottom
			{
				topWall = inst;
			}
		}		
	}
	
	//destroy ds list
	ds_list_destroy(wallLst);
	
	//get out of walls
		//right
		if instance_exists(rightWall)
		{
			var rightDist = bbox_right - x; //distance of the player side with player center
			x = rightWall.bbox_left - rightDist; //get out
		}
		
		//left
		if instance_exists(leftWall)
		{
			var leftDist = x - bbox_left;
			x = leftWall.bbox_right + leftDist;
		}

		//below
		if instance_exists(botWall)
		{
			var botDist = bbox_bottom - y;
			y = botWall.bbox_top + botDist;
		}
		
		//up (account for crouching  
		if instance_exists(topWall)
		{
			var upDist = y - bbox_top;
			var target_y = topWall.bbox_bottom + upDist;
			if !place_meeting(x, target_y, oGround)
			{
				y = target_y; 
			}

		}
		
#endregion

#region
//(polishing) --> for the player to not fall if too close on the edge
earlyMovePlatSpd = false;
if instance_exists(myFloorPlat) && myFloorPlat.xspeed != 0 
&& !place_meeting(x, y+maxDroppingSpeed+1, myFloorPlat)
{
	//move along the platform if there is no wall in the way
	if !place_meeting(x+myFloorPlat.xspeed, y, oGround)
	{
		x += myFloorPlat.xspeed;
		earlyMovePlatSpd = true;
	}
}


//crouching
	//into crouch
		//manual
		if downKey && instance_exists(myFloorPlat)
		{
			crouching = true;
		}
		
		//forced (optional
		/*
		if onGround && place_meeting(x, y, oGround)
		{
			crouching = true;
		}
		*/
		
		if crouching
		{
			sprite_index = spr_crouch;
			mask_index = spr_crouch;
		}
		
	
	//out of crouch
		//manual
		if !downKey
		{
			mask_index = spr_idle;
			if !place_meeting(x, y, oGround)
			{
				crouching = false;
			}else
			{
				mask_index = spr_crouch;
			}
		}
		
		//dont crouch in the air
		if !onGround
		{
			mask_index = spr_idle;
			if !place_meeting(x, y, oGround)
			{
				crouching = false;
			}else
			{
				mask_index = spr_crouch;
			}
		}
#endregion

#region
//X Movement
	//Direction
	if room == r8
	{
		moveDir = leftKey - rightKey;
	}else
	{
		moveDir = rightKey - leftKey;
	}
	
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
	//crouch speed
	if crouching
	{
		xspeed = moveDir * crouchSpd;
	}

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
	downSemiSolid = noone;
	if (yspeed >= 0 && !place_meeting( x + xspeed, y+1, oGround )
	&& (place_meeting( x + xspeed , y + abs(xspeed) +1, oGround )))
	{
		//check for the semi solid
		downSemiSolid = check_for_semisolidplats(x + xspeed , y + abs(xspeed) +1)
		
		if !instance_exists(downSemiSolid) //if no semisolid
		{
			while (!place_meeting( x + xspeed, y+_subPixel, oGround ))
			{
				y += _subPixel;
			}
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

	  
	    xspeed = 0;
		yspeed = -grav;
		
		jumpCount = 0;
		soundJumpCount = 1;
		//walljump
		if (jumpkeyPressed) {
			xspeed = moveDir * moveSpd[0];
			//jump
			if (jumpCount < jumpMax) {
			jumpCount ++;
			}
			xspeed = horiJumpSpd * (face * -1);
		}
	}

//--------------------------------


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
		soundJumpCount = 0; 
		coyoteJumpTimer = coyoteJumpFrame; //(JUMP) reset coyote jump time
		
	} 
	//check "onWall"
	if !(yspeed >= 0 && place_meeting(x, y+yspeed, oWall)) || !(xspeed >= 0 && place_meeting(x+xspeed, y, oWall))
	{//if falls
		coyoteJumpTimer --; 
		if jumpCount == 0 && coyoteJumpTimer <=0 //(JUMP) if in the air, did not jump, 
												 //and passed the coyote time, 
		{
			soundJumpCount = 1;
			jumpCount = 1
		};
		//coyoteHangTimer = 0; //(HANG) no more coyote hang time, i'm not sure if we need this line
	};

	//jump (jump buffer details in GenFns

	var solidFloor = false;
	if instance_exists(myFloorPlat)
	&& (myFloorPlat.object_index == oGround || object_is_ancestor(myFloorPlat.object_index, oGround))
	{
		solidFloor = true;
	}
	
	if jumpBuffered && (!downKey || solidFloor) && jumpCount<jumpMax //if jumps 
	{
		
		jumpBuffered = false; //reset boolean
		jumpBufferTimer = 0; //not sure why, but necessary
	
		jumpCount ++; //increase jump count
	
		if room == ra10
		{
			jumpHoldTime = jumpHoldFrame + 10;
		}else
		{
			jumpHoldTime = jumpHoldFrame; //can be held (look at next ifs)
		}
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
		{	
			jumpHoldTime = 0;
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
    
		//if the player bumps into a "ceiling", it falls (Bonks)

		if yspeed < 0
		{	
			jumpHoldTime = 0;
		}

	//    //Set yspd to zero to "collide"
	    yspeed = 0;
		
	//	//walljump !!
		jumpCount = 0;
		soundJumpCount = 1;
		if (jumpkeyPressed) {
			//jump
			if (jumpCount < jumpMax) {
				yspeed = jumpSpd;
				jumpCount ++;
			}
			yspeed = -vertJumpSpd;
		}
		y += yspeed;
	}

//--------------------
	
	
	//check onGround
	if (yspeed >= 0 && place_meeting(x, y+1, oGround))
	{
		setOnGround(true);

	}

	
//--------------------------------

	
	//Check for solid and semisolid platforms beneath player
	var clampYspeed = max(0, yspeed);
	var wallList = ds_list_create();
	var wallArray = array_create(0);
	array_push(wallArray, oGround, oSemiSolidWall);
	
	
	//create actual list of walls
	var listSize = instance_place_list(x, y+1+clampYspeed+maxDroppingSpeed, wallArray, wallList, false);
	
	//loop through
	for (var i = 0; i < listSize; i++)
	{
		var inst = wallList[| i];
		
		//avoid sticking to platform, apparently
		if inst != forgetSemiSolid 
		&& (inst.yspeed <= yspeed || instance_exists(myFloorPlat))
		&& (inst.yspeed > 0 || place_meeting(x, y+1+clampYspeed, inst))
		{
			//return a solid wall or semi solid wall
			if inst.object_index == oGround 
			|| object_is_ancestor(inst.object_index, oGround)
			|| floor(bbox_bottom) <= ceil(inst.bbox_top - inst.yspeed) //check at the start of the frame
			{
				//return higher wall
				if !instance_exists(myFloorPlat) 
				|| inst.bbox_top + inst.yspeed <= myFloorPlat.bbox_top + myFloorPlat.yspeed
				|| inst.bbox_top + inst.yspeed <= bbox_bottom
				{
					myFloorPlat = inst;
				}
			}
		}
		
		 
	}
	//destroy ds list
	ds_list_destroy(wallList);
	
	
		//if there is a downslope semi solid, force the myFloorPlat to it
		if instance_exists(downSemiSolid)
		{
			myFloorPlat = downSemiSolid;
		}
	
	
	//make sure platform actually below player
	if instance_exists(myFloorPlat) && !place_meeting(x, y+maxDroppingSpeed, myFloorPlat)
	{
		myFloorPlat = noone;
	}
	
	//Land on the platform
	if instance_exists(myFloorPlat)
	{
		var subPixel = 0.5;
		while !place_meeting(x, y+subPixel, myFloorPlat) && !place_meeting(x, y, oGround)
		{
			y+=subPixel;		
		}
		
		//to not go below the top of semisolid
		if myFloorPlat.object_index == oSemiSolidWall 
		|| object_is_ancestor(myFloorPlat.object_index, oSemiSolidWall)
		{
			while place_meeting(x, y, myFloorPlat) 
			{
				y -= subPixel;
			}
		
		}
		
		y = floor(y);
		
		//collision
		yspeed = 0;
		setOnGround(true);
		
	}
	
	
	//Manually fall down semiSolid
	if downKey //&& jumpkeyPressed
	{
		if instance_exists(myFloorPlat) && (myFloorPlat.object_index == oSemiSolidWall 
		|| object_is_ancestor(myFloorPlat.object_index, oSemiSolidWall))
		{
			//if can do down
			var y_check = max(1, myFloorPlat.yspeed+1);
			if !place_meeting(x, y + y_check, oGround)
			{
				//move below
				y += 1;
				
				//make sure platform moving down doesn't catch player
				yspeed = y_check -1;
				
				
				//forget the platform for a bit
				forgetSemiSolid = myFloorPlat;
				
				//in the air now (for a bit)
				setOnGround(false);
			}
		}
	}
	

	//Move
	if !place_meeting(x, y+yspeed, oGround)
	{
		y += yspeed;
	}
	
	//reset forgetSemiSolid variable
	if instance_exists(forgetSemiSolid) && !place_meeting(x, y, forgetSemiSolid) 
	{
		forgetSemiSolid = noone;
	}
	
#endregion
	
//Moving plats collisions
#region
	//X - make the player move while being on the moving platform
	movePlatXspeed = 0; 
	if instance_exists(myFloorPlat) 
	{
		movePlatXspeed = myFloorPlat.xspeed;	
	}
	
	if !earlyMovePlatSpd
	{
		if place_meeting(x+movePlatXspeed, y, oGround) //if there is a Ground/Wall, collides
		{
			var subPixel = 0.5
			var _pixelCheck = subPixel * sign(movePlatXspeed);
			while !place_meeting( x + _pixelCheck, y, oGround )
			{
				x += _pixelCheck;
			}
		
			//collision
			movePlatXspeed = 0;
		}
	
	
		//Move Along the platform	
		x += movePlatXspeed;
	}
	
	
	//Y -  snap to platform
	if (instance_exists(myFloorPlat) && (myFloorPlat.yspeed != 0
		|| myFloorPlat.object_index == oGroundMove 
		|| object_is_ancestor(myFloorPlat.object_index, oGroundMove)
		|| myFloorPlat.object_index == oSemiSolidMove
		|| object_is_ancestor(myFloorPlat.object_index, oSemiSolidMove))) //checking platform MoveSpd
	{
		//snap to platform
		if !place_meeting(x, myFloorPlat.bbox_top, oGround)
		&& myFloorPlat.bbox_top >= bbox_bottom - maxDroppingSpeed //che cks for undesired behaviors
		{
			y = myFloorPlat.bbox_top;
		}
		
		
		//redundant (check by the chunk underneath)
		/*
		if myFloorPlat.yspeed < 0 && place_meeting(x, y+myFloorPlat.yspeed, oGround)
		{
			//get pushed down to semisolid
			if myFloorPlat.object_index == oSemiSolidWall 
			|| object_is_ancestor(myFloorPlat.object_index, oSemiSolidWall)
			{
				//into semisolid (so that player falls)
				var subPixel = 0.25;
				while place_meeting(x, y+myFloorPlat.yspeed, oGround)
				{
					y += subPixel;
				}
				//push back out if underneath there is a solid platform
				while place_meeting(x, y, oGround)
				{
					y -= subPixel;
				}
				y = round(y);
			}
		}
		*/
	
	}


	//get pushed below semi solid by a moving solid (might not even happen, depend on room design
	if instance_exists(myFloorPlat)
	&& (myFloorPlat.object_index == oSemiSolidWall 
	|| object_is_ancestor(myFloorPlat.object_index, oSemiSolidWall))
	&& place_meeting(x, y, oGround)
	{
		var maxPushDist = 10;
		var pushDist = 0;
		var startY = y;
		while place_meeting(x, y, oGround) && pushDist <= maxPushDist
		{
			y++;
			pushDist++;
		}
		forgetSemiSolid = true;
		
		if pushDist > maxPushDist
		{
			y = startY;
		}
		
		
	}
	
//crushed
/*
image_blend = c_white;

if place_meeting(x, y, oGround)
{
	image_blend = c_red;
}
*/



#endregion


#region
//sprite control

	//walking
	if abs(xspeed) > 0 
	{
		sprite_index = spr_walk
	}
	if abs(xspeed) >= moveSpd[1]  //order matters
	{
		sprite_index = spr_run;
	}
	if abs(xspeed) == 0 
	{
		sprite_index = spr_idle;
	}
	if (yspeed >= 0 && place_meeting(x, y+yspeed, oWall)) || (xspeed >= 0 && place_meeting(x+xspeed, y, oWall))
	{
		sprite_index = spr_stick;
	}
	if !onGround
	{
		sprite_index = spr_jump;
		
	}
	if !crouching
	{
		//set collision mask
		mask_index = spr_idle;
	}

//reset game
if resetKey
{
	room_restart();
}

//death condition
if place_meeting(x+xspeed, y, oSpike)
|| place_meeting(x, y+yspeed, oSpike)
{
	dead = true;
	if !counted_death
	{
		global.deathCount ++;
		SaveProgress();
	}
	audio_play_sound(death_sound, 0, false, 1, 0, 1.5);
}

//Next level

if place_meeting(x, y+yspeed, oDoor) && global.keyCount >= 3
{
	if (global.unlockedLevel < global.currentLevel + 1) 
	{
	    global.unlockedLevel = global.currentLevel + 1;
		SaveProgress();
	}
	
	room_goto_next();
		
}

#endregion

if (jumpkeyPressed && !dead && (soundJumpCount < maxSoundJumpCount)) {
	audio_play_sound(jump_sound2, 0, false, 1, 0.20);
	soundJumpCount++;
}






