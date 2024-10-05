if (show_menu){
	////Main Menu
	box_h = lerp(box_h, 192, 0.25);
	var box_x = followx - distance_from_player;
	var box_y = followy;
	draw_sprite_pos(Sprite14,0,box_x-box_w,box_y-box_h,box_x+box_w,box_y-box_h,box_x+box_w,box_y+box_h,box_x-box_w,box_y+box_h,1);

	for (var i = 0; i < array_length(menu_options); i++){
		if (point_in_rectangle(mouse_x,mouse_y, box_x-box_w,box_y-box_h+16+(64*i),box_x+box_w,box_y-box_h+16+(64*i)+38)){
			draw_text_transformed_color(box_x - box_w + 8, box_y - box_h + 16 + (64 * i), menu_options[i],0.5,0.5,0,c_red,c_red,c_red,c_red,1);
			if (mouse_check_button_pressed(mb_left)){
				switch(i){
					case 0:
						switch(window_get_fullscreen()){
							case true: window_set_fullscreen(false); break;
							case false: window_set_fullscreen(true); break;
						}
					break;
					case 3:
						game_end();
					break;
				}
			}
		}else{
			draw_text_transformed(box_x - box_w + 8, box_y - box_h + 16 + (64 * i), menu_options[i],0.5,0.5,0);
		}
	}
	
	

}else{
	box_h = lerp(box_h, 0, 0.25);
}
