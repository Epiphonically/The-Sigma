spd = 8;
aim_peekx = 0;
aim_peeky = 0;
angle = 0;

hp = 100;
old_hp = hp;

invince_frames = 0;
invince_frames_max = 20;

value = "69";
valueToAdd = "9";
calcAt = 0;


turnsfx = false;
audiotick = 0;
prev_mousex = mouse_x;
prev_mousey = mouse_y;

gui_mouse_scale = 1;
gui_mouse_focus = false;
gui_mouse_ring_rotation = -180;
gui_mouse_ring_rotation_ran = 0;
gui_mouse_ring_scale = 2;
alarm[0] = room_speed * 1;


held_number = 0;
held_operation = "-";

shot_dist_to_player_default = 64;
shot_dist_to_player = 64;
shot_dist_to_player_target = 64;

held_number = "none";
held_operation = "-";

shot_dist_to_player_default = 64;
shot_dist_to_player = 64;
shot_dist_to_player_target = 64;

epsilon = 0;

epsilon_index = 0;

side_x1 = x;
side_y1 = y;

side_x2 = x;
side_y2 = y;


dashing = false;
dash_timer = 0;
dash_angle = 0;
dash_mx = 0;
dash_my = 0;

color_shift = 0;

started_charging_beam = false;
beam_charge = 0;
beam_juice = 0;
beam_current_length = 0;
beam_charge_time = 100;
juice_refill = 300;
//beam_max_length = sqrt(power(room_width, 2) + power(room_height, 2));
beam_max_length = sqrt(power(camera_get_view_width(view_camera[0]), 2) + power(camera_get_view_height(view_camera[0]), 2)) / (sprite_get_height(s_blast));
infinity_power = 0;
max_infinity_power = 5 * room_speed;
radius_out = 80;