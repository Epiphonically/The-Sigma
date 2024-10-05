draw_self();

if (rogue && state = false && !global.audio_stopper){
	audio_play_sound(LASER,0,false);
	global.audio_stopper = true;
}


if (rogue && !death){
	
	state = true;
	if (aim_timer > 0.2){
		aim_timer = lerp(aim_timer,0,0.1);
	}else{
		aim_timer = 0;
		lock_on = true;
	}
	
	draw_set_color(c_red);
	draw_set_alpha(1-(aim_timer/120));
	draw_line(x,y,x + lengthdir_x(10000,point_to-((aim_timer/120)*45)),y + lengthdir_y(10000,point_to-((aim_timer/120)*45)));
	draw_line(x,y,x + lengthdir_x(10000,point_to+((aim_timer/120)*45)),y + lengthdir_y(10000,point_to+((aim_timer/120)*45)));
	draw_set_alpha(1);
	draw_set_color(c_white);
	image_index = 0;
}
