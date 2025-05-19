
var icon_spacing = 100; // space between icons
var icon_size = 48; // size of sprite if needed
var scale = 5;
var start_x = display_get_gui_width() - (icon_spacing * 3) - 5; // left-aligned in top-right
var yPosition = 130;

// Loop through 3 keys
if !(room == rWin)
{

	for (var i = 0; i < 3; i++)
	{
	    // Determine which sprite to draw (On or Off)
	    var spr = (i < global.keyCount) ? sKey : sKeyOff;
    
	    // Draw the icons
		draw_sprite_ext(spr, 0, start_x + i * icon_spacing, yPosition, scale, scale, 0, c_white, 1);
	}

}







