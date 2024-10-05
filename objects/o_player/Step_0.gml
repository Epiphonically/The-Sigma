if (hp <= 0) {
	game_restart();	
}
if (invince_frames > 0) {
	invince_frames--;	
}
if (infinity_power > 0) {
	infinity_power--;	
}

if (beam_juice > 0) {
	var the_angler = -1*(image_angle - 90);
	
	var orig_top_x = x;
	var orig_top_y = y - sprite_height / 2;
	var rot_top_x = (orig_top_x - x) * dcos(the_angler) - (orig_top_y - y) * dsin(the_angler) + x;
	var rot_top_y = (orig_top_x - x) * dsin(the_angler) + (orig_top_y - y) * dcos(the_angler) + y;

	var orig_bottom_x = x;
	var orig_bottom_y = y + sprite_height / 2;
	var rot_bottom_x = (orig_bottom_x - x) * dcos(the_angler) - (orig_bottom_y - y) * dsin(the_angler) + x;
	var rot_bottom_y = (orig_bottom_x - x) * dsin(the_angler) + (orig_bottom_y - y) * dcos(the_angler) + y;
	
	if (instance_exists(o_boss) && 
	(collision_line(x, y, x + lengthdir_x(point_distance(x, y, o_boss.x, o_boss.y) + 100, image_angle), y + lengthdir_y(point_distance(x, y, o_boss.x, o_boss.y) + 100, image_angle), o_boss, false, true) || 
	collision_line(rot_top_x, rot_top_y, rot_top_x + lengthdir_x(point_distance(x, y, o_boss.x, o_boss.y) + 100, image_angle), rot_top_y + lengthdir_y(point_distance(x, y, o_boss.x, o_boss.y) + 100, image_angle), o_boss, false, true) ||
	collision_line(rot_bottom_x, rot_bottom_y, rot_bottom_x + lengthdir_x(point_distance(x, y, o_boss.x, o_boss.y) + 100, image_angle), rot_bottom_y + lengthdir_y(point_distance(x, y, o_boss.x, o_boss.y) + 100, image_angle), o_boss, false, true))) {
		switch (o_boss.phase) {
			case 0:
				o_boss.hpbar1 -= 1000;
			break;
			
			case 1:
				o_boss.hpbar2 -= 5000;
			break;
			
			case 2:
				o_boss.hpbar3 -= 10000;
			break;
		}
	}	
}

if (old_hp != hp){
	o_camera.shake = 10;
	old_hp = hp;	
}

/*
if (o_boss.beam_juice > 0) {
	
	var test_angle = -1*(o_boss.image_angle - 90);
	var test_y = (x - o_boss.x) * dsin(test_angle) + (y - o_boss.y) * dcos(test_angle) + o_boss.y;
	//show_debug_message(string(o_boss.y) + ", " + string(test_y));
	if (test_y >= o_boss.y - o_boss.sprite_height / 2 - 10 && test_y <= o_boss.y + o_boss.sprite_height / 2 + 10) {
		//show_debug_message("I");
	}
}
*/