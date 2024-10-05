x += lengthdir_x(spd,dir);
y += lengthdir_y(spd,dir);


if (selected){
	spd = raw_spd / 4;
}else{
	ang = 0;
	spd = raw_spd;
}


image_angle += angle_difference(ang, image_angle) * 0.15;