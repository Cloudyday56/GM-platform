
getControls();

//X Movement
//Direction
moveDir = rightKey - leftKey;

//Get xspd
xspeed = moveDir * moveSpd;

//X collision
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

yspeed += grav;

//reset
if onGround 
{
	jumpCount = 0
} 
else{
	if jumpCount == 0 {jumpCount = 1};
};

//jump
if jumpBuffered && jumpCount<jumpMax
{
	jumpBuffered = false;
	jumpBufferTimer = 0;
	
	jumpCount ++;
	
    jumpHoldTime = jumpHoldFrame;
	
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

//Y collision
var _subPixel = .5;
if (place_meeting( x , y + yspeed, oGround ))
{
    //Scoot up to wall precisely
    var _pixelCheck = _subPixel * sign(yspeed);
    while (!place_meeting( x , y + _pixelCheck, oGround ))
    {
        y += _pixelCheck;
    }

    //Set xspd to zero to "collide"
    yspeed = 0;
}

//check onGround
if (yspeed >= 0 && place_meeting(x, y+1, oGround))
{
	onGround = true;

}else {
	onGround = false;

}

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
if (yspeed >= 0 && place_meeting(x, y+1, oWall))
{
	onWall = true;

}else {
	onWall = false;

}


//Move
y += yspeed;



if place_meeting(x, y+yspeed, oDoor)
{
    room_goto_next()
}
