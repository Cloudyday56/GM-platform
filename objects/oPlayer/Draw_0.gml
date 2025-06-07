//this draws the player depending on the x direction the player is facing
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale*face, 
				image_yscale, image_angle, image_blend, image_alpha);
				
if room != r6
{
	draw_set_alpha(0.7);
	var offsetX = 10;       // Bottom-left x position
	var offsetY = 12;		// Start from bottom

	for (var i = 0; i < jumpMax; i++) {
	    var sprite_to_draw = (i < (jumpMax - jumpCount)) ? sJumpOn : sJumpOff;
	    draw_sprite(sprite_to_draw, 0, x + offsetX, y - offsetY - i*10);
	}
	draw_set_alpha(1);
}
				

if dead 
{
	//draw a semi-transparent black background to dim the game screen
    draw_set_alpha(0.5);
    draw_set_color(c_black);
    draw_rectangle(0, 0, room_width, room_height, false);

    
	draw_set_alpha(1);	//reset opacity
	
    // Get the camera view position and size
	var cam = view_camera[0]; // assuming you're using the first camera
	var cam_x = camera_get_view_x(cam);
	var cam_y = camera_get_view_y(cam);
	var cam_w = camera_get_view_width(cam);
	var cam_h = camera_get_view_height(cam);

	// Calculate center of the camera view
	var center_x = cam_x + cam_w / 2;
	var center_y = cam_y + cam_h / 2;

	// Set font and draw text centered on the camera
	draw_set_font(Font1);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);

	draw_set_color(make_color_rgb(181, 124, 176)); 
	draw_text(center_x, center_y, "Press R to restart");

}