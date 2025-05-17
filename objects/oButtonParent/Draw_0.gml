draw_self();


// Set the font for the button text
draw_set_font(Font1);

// Center the text alignment
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Draw the button text at the center position (x, y)
draw_text(x, y, button_text);

// Reset alignment to default (top-left) for future drawing
draw_set_halign(fa_left);
draw_set_valign(fa_top);


