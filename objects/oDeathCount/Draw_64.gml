//settings
var icon_x = 50;
var icon_y = 50;
var iconSize = 32; //scale

//skull icon
var spr = sWhy;
draw_sprite(spr, 0, icon_x, icon_y);


//death count
draw_set_color(make_color_rgb(255, 225, 225));
draw_set_font(Font1);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);

var text_x = icon_x + iconSize + 10; //padding
var text_y = icon_y + iconSize / 2;

draw_text(text_x, text_y, string(global.deathCount));

