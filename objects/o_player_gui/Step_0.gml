if (keyboard_check_pressed(vk_tab)){
	switch(show_menu){
		case true: show_menu = false; break;
		case false: show_menu = true; break;
	}
}


if (instance_exists(o_player)){
	followx = lerp(followx, o_player.x, 0.25);
	followy = lerp(followy, o_player.y, 0.25);
}