// Get current camera view
var cam = view_camera[0];
var cam_x = camera_get_view_x(cam);
var cam_y = camera_get_view_y(cam);
var cam_w = camera_get_view_width(cam);
var cam_h = camera_get_view_height(cam);

draw_sprite_stretched(sBackground, 0, cam_x, cam_y, cam_w, cam_h);
