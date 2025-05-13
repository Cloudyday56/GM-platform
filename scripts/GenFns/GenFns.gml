function controlsSetup()
{
	bufferTime = 5; 
	
	//jump
	jumpBuffered = false;
	jumpBufferTimer = 0; //grace period for detecting jump input
	
}


function getControls()
{
	//Get inputs
	rightKey = keyboard_check( ord("D")) + keyboard_check(vk_right);
	rightKey = clamp(rightKey, 0, 1);
	
	leftKey  = keyboard_check( ord("A") ) + keyboard_check(vk_left);
	leftKey = clamp(leftKey, 0, 1);


	jumpkeyPressed = keyboard_check_pressed(ord("W") + + keyboard_check_pressed(vk_up));
	jumpkeyPressed = clamp(jumpkeyPressed, 0, 1);


	jump = keyboard_check(ord("W") + + keyboard_check(vk_up));
	jump = clamp(jump, 0, 1);	
	
	
	//jupmkey buffering
	if jumpkeyPressed
	{
		jumpBufferTimer = bufferTime;
	}
	
	if jumpBufferTimer > 0
	{
		jumpBuffered = true;
		jumpBufferTimer --;
	}else
	{
		jumpBuffered = false;
		
	}
	
}