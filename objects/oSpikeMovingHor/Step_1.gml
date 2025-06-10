//move in circle
dir -= rotSpd;

//get target position
var targetX = xstart + lengthdir_x(radius, dir);
var targetY = ystart + lengthdir_y(radius, dir);

//xspeed and yspeed
xspeed = targetX - x;
//yspeed = targetY - y;
yspeed = 0;

//Move
x += xspeed;
y += yspeed;

