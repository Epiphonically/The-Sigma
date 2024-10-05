if (mouse_check_button(mb_right)){
	gui_mouse_ring_rotation = lerp(gui_mouse_ring_rotation, gui_mouse_ring_rotation_ran, 0.05);
	gui_mouse_ring_scale = lerp(gui_mouse_ring_scale, gui_mouse_scale, 0.15);
	draw_sprite_ext(Sprite5_1,0,device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),gui_mouse_ring_scale,gui_mouse_ring_scale,gui_mouse_ring_rotation,c_white,1);

}else{
	gui_mouse_ring_rotation = lerp(gui_mouse_ring_rotation, -180, 0.15);
	gui_mouse_ring_scale = lerp(gui_mouse_ring_scale, 2, 0.05);
}

draw_sprite_ext(Sprite5,0,device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),gui_mouse_scale,gui_mouse_scale,0,c_white,1);
