
// === Settings ===
var icon_x = 50;
var icon_y = 50;
var icon_size = 32; // Scale this to your desired size

// === Draw the skull icon ===
draw_sprite_ext(sSkull, 0, icon_x, icon_y, icon_size / sprite_width, icon_size / sprite_height, 0, c_white, 1);

// === Draw the death count text next to it ===
draw_set_color(make_color_rgb(255, 225, 225));
draw_set_font(Font1); // make sure this font is readable and loaded
draw_set_halign(fa_left);
draw_set_valign(fa_middle);

var text_x = icon_x + icon_size + 10; // small padding after icon
var text_y = icon_y + icon_size / 2;

draw_text(text_x, text_y, string(global.deathCount));