if (!death){
	if (instance_exists(o_boss) && o_boss.beam_juice > 0) {
		var test_angle = o_boss.locked_angle;
		var test_y = (x - o_boss.x) * dsin(test_angle) + (y - o_boss.y) * dsin(test_angle) + y;
		if (test_y >= o_boss.y - o_boss.sprite_width / 2 && test_y <= o_boss.y + o_boss.sprite_height / 2) {
			;
		}
	}
	if (!rogue){
		if (my_graph != 0) {
			point_on_dom += xmove;

		
			var orig_x = (point_on_dom-(room_width/2))*(1/64)
			var orig_y = my_graph.start_y + my_graph.range_stretch * 64*(-1)*evaluate(my_graph.func, (point_on_dom-(room_width/2))*(1/((64 * my_graph.domain_stretch))));
			prev_x = x;
			prev_y = y;	
	
			x = ((point_on_dom - room_width/2) * dcos(my_graph.angle)) - ((orig_y - room_height / 2) * dsin(my_graph.angle)) + (room_width/2);
			y = ((point_on_dom - room_width/2) * dsin(my_graph.angle)) + ((orig_y - room_height / 2) * dcos(my_graph.angle)) + (room_height/2);
			point_to = point_direction(prev_x, prev_y, x, y);
		} else {
			rogue = true;	
		}
		
		
	}else{
		if (instance_exists(o_player) && !lock_on && !custom_angle){
			point_to = point_direction(x,y,o_player.x,o_player.y);
		}
	
		if (lock_on){
			x+=lengthdir_x(50,point_to);
			y+=lengthdir_y(50,point_to);
		}
	}
}

if (death){
	if (instance_exists(o_player) && !lock_on){
		point_to = point_direction(x,y,o_player.x,o_player.y);
	}
	sprite_index = Sprite10_1;
}

image_angle += angle_difference(point_to, image_angle) * 0.15;

