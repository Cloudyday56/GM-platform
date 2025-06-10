
if room != rMenu
{
	var icon_x = 60;
	var icon_y = 60;

	//skull icon
	var spr = sSkull;
	draw_sprite_ext(spr, 0, icon_x, icon_y, 2, 2, 0, c_white, 1);


	//death count
	draw_set_color(make_color_rgb(255, 225, 225));
	draw_set_font(FontNum);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);

	var text_x = icon_x + 80; //padding
	var text_y = icon_y + 32;

	draw_text(text_x, text_y, string(global.deathCount));
}


