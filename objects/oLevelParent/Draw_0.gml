if (global.unlockedLevel >= levelNumber) 
{
    draw_sprite_ext(sLevelUnlock, 0, x, y, 1.5, 1.5, 0, c_white, 1);
	
//title
	draw_set_font(Font1);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    

	// Text to draw
	var title = levelTitle;
	var xPos = x;
	var yPos = y - 15;

	// Font settings
	draw_set_font(Font1);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);


	// Outline
	draw_set_color(make_color_rgb(13, 22, 62));
	draw_text(xPos - 2, yPos - 2, title);
	draw_text(xPos + 2, yPos - 2, title);
	draw_text(xPos - 2, yPos + 2, title);
	draw_text(xPos + 2, yPos + 2, title);

	draw_set_color(make_color_rgb(255, 225, 225));
	draw_text(xPos, yPos, title);
	
} else {
    draw_sprite_ext(sLevelLock, 0, x, y, 1.5, 1.5, 0, c_white, 1);
}



