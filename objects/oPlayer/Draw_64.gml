
var icon_spacing = 100; // space between icons
//var icon_size = 48; // size of sprite if needed
var scale = 5;
var start_x = display_get_gui_width() - (icon_spacing * 3) - 5; // left-aligned in top-right
var yPosition = 130;

// Loop through 3 keys
if !(room == rWin)
{
	//if room != ra10
	//{
	for (var i = 0; i < 3; i++)
	{
	    // Determine which sprite to draw (On or Off)
	    var spr = (i < global.keyCount) ? sKey : sKeyOff;
    
	    // Draw the icons
		draw_sprite_ext(spr, 0, start_x + i * icon_spacing, yPosition, scale, scale, 0, c_white, 1);
	}

}


if room != r6
{
	draw_set_alpha(0.8);
	var startX = 32;       // Bottom-left x position
	var startY = display_get_gui_height() - 92; // Start from bottom

	for (var i = 0; i < jumpMax; i++) {
	    var sprite_to_draw = (i < jumpMax - jumpCount) ? sJumpOn : sJumpOff;
	    draw_sprite(sprite_to_draw, 0, startX, startY - i * 72);
	}
	draw_set_alpha(1);
}






