
function controlsSetup()
{
	bufferTime = 5; //grace period for anything
	
	//jump buffer
	jumpBuffered = false;
	jumpBufferTimer = 0; //grace period for detecting jump input 
						//(jumping registers a little bit before landing)
	
}


function getControls()
{
	//Get inputs --> Can use "WASD" or "up down left right"
	rightKey = keyboard_check( ord("D")) + keyboard_check(vk_right);
	rightKey = clamp(rightKey, 0, 1); //set boundary for the value
	
	leftKey  = keyboard_check( ord("A") ) + keyboard_check(vk_left);
	leftKey = clamp(leftKey, 0, 1); //set boundary


	//press to jump 
	jumpkeyPressed = keyboard_check_pressed(ord("W")) + keyboard_check_pressed(vk_up);
	jumpkeyPressed = clamp(jumpkeyPressed, 0, 1);//set boundary

	//hold for longer jumps
	jump = keyboard_check(ord("W")) + keyboard_check(vk_up); 
	jump = clamp(jump, 0, 1);	//set boundary
	
	//to run
	runKey = keyboard_check(vk_space);
	runKey = clamp(runKey, 0, 1);	//set boundary
	
	
	//jupmkey buffering
	if jumpkeyPressed
	{
		jumpBufferTimer = bufferTime; //each jump is buffered (here, for 5 frames)
	}
	
	if jumpBufferTimer > 0
	{
		jumpBuffered = true; 
		jumpBufferTimer --; //jumpkey can be registered 5 frames before landing, 
							//so that the player will jump as soon he lands
							//(I think that's what's happening)
	}else
	{
		jumpBuffered = false;
		
	}
	
}