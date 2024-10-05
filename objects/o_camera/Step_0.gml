follow = o_player;

focus = [follow.x + o_player.aim_peekx - (camera_get_view_width(view_camera[0])/2), follow.y + o_player.aim_peeky - (camera_get_view_height(view_camera[0])/2)];

if (shake > 0){
	shake_posx = lerp(shake_posx,shake_pos_valx, 0.3);
	shake_posy = lerp(shake_posy,shake_pos_valy, 0.3);
	shake--;
}else{
	shake = 0;
	shake_posx = lerp(shake_posy,0,0.3);
	shake_posy = lerp(shake_posy,0,0.3);
}

cx = lerp(cx, focus[0], 0.25);
cy = lerp(cy, focus[1], 0.25);

cx = clamp(cx, 0, room_width - camera_get_view_width(view_camera[0]));
cy = clamp(cy, 0, room_height - camera_get_view_height(view_camera[0]));

camera_set_view_pos(view_camera[0], cx+shake_posx, cy+shake_posy);
//show_debug_message(string(camera_get_view_x(view_camera[0])) + ", " + string(camera_get_view_y(view_camera[0])) + " : " + string(follow.x) + ", " + string(follow.y));