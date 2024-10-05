epsilon = 5*dsin(epsilon_index);
epsilon_index++;
if (dashing) {
	
	var x1 = x - 32 * image_xscale;
	var y1 = y - 32 * image_yscale;
	var x2 = x + 32 * image_xscale;
	var y2 = y - (32 * image_yscale);
	var x3 = x + 32 * image_xscale;
	var y3 = y + (32 * image_yscale);
	var x4 = x - 32 * image_xscale;
	var y4 = y + 32 * image_yscale;
	var the_angle = -1 * dash_angle;
	var x1_rot = (x1 - x) * dcos(the_angle) - (y1 - y) * dsin(the_angle) + x;
	var y1_rot = (x1 - x) * dsin(the_angle) + (y1 - y) * dcos(the_angle) + y;
	var x2_rot = (x2 - x) * dcos(the_angle) - (y2 - y) * dsin(the_angle) + x;
	var y2_rot = (x2 - x) * dsin(the_angle) + (y2 - y) * dcos(the_angle) + y;
	var x3_rot = (x3 - x) * dcos(the_angle) - (y3 - y) * dsin(the_angle) + x;
	var y3_rot = (x3 - x) * dsin(the_angle) + (y3 - y) * dcos(the_angle) + y;
	var x4_rot = (x4 - x) * dcos(the_angle) - (y4 - y) * dsin(the_angle) + x;
	var y4_rot = (x4 - x) * dsin(the_angle) + (y4 - y) * dcos(the_angle) + y;
	draw_set_color(c_white);
	draw_sprite_pos(s_player, 0, x1_rot, y1_rot, x2_rot, y2_rot, x3_rot, y3_rot, x4_rot, y4_rot, 1);
	draw_set_color(c_white);
	var use_me = 0;
	if (dcos(dash_angle) < 0) {
		use_me = 180;
	}
	var lerp_spd = 0.6;
	side_x1 = lerp(side_x1, x + lengthdir_x(64,image_angle+90+use_me), lerp_spd);
	side_y1 = lerp(side_y1, y + lengthdir_y(64,image_angle+90+use_me), lerp_spd);
	side_x2 = lerp(side_x2, x + lengthdir_x(64,image_angle-90+use_me), lerp_spd);
	side_y2 = lerp(side_y2,  y + lengthdir_y(64,image_angle-90+use_me), lerp_spd);
	draw_text_transformed(side_x1, side_y1,hp,0.5,0.5, image_angle + use_me);
	draw_text_transformed(side_x2, side_y2,"n = 0",0.4,0.4, image_angle + use_me);
	var orig_x = 0;
	var epsilon = 5*dsin(epsilon_index);
	if (held_number == "none") {
		orig_x = x+shot_dist_to_player + epsilon;
	} else if (held_number == "inf") {
		orig_x = x+shot_dist_to_player + sprite_get_width(s_fn_font_extras) + epsilon;
	} else {
		orig_x = x+shot_dist_to_player+(24*string_length(held_number)) + epsilon;
	}
	if (held_number == "none") {
		var orig_x = x+shot_dist_to_player + epsilon;
	} else if (held_number == "inf") {
		var orig_x = x+shot_dist_to_player + sprite_get_width(s_fn_font_extras), epsilon;
	} else {
		var orig_x = x+shot_dist_to_player+(24*string_length(held_number)) + epsilon;
	}

	var orig_y = y;
	var rot_x = (orig_x - x) * dcos(-1*image_angle) - (orig_y - y) * dsin(-1*image_angle) + x;
	var rot_y = (orig_x - x) * dsin(-1*image_angle) + (orig_y - y) * dcos(-1*image_angle) + y;

	switch (held_operation) {
		case "+":
			draw_sprite_ext(s_fn_font, sprite_get_number(s_fn_font) - 1, rot_x, rot_y, 1, 1, image_angle, c_green, 1);
		break;
	
		case "-":
			draw_sprite_ext(s_fn_font_extras, 1, rot_x, rot_y, 0.5, 0.5, image_angle, c_red, 1);
		break;
	
		case "*":
			draw_sprite_ext(s_fn_font_extras, 3, rot_x, rot_y, 0.5, 0.5, image_angle, c_yellow, 1);
		break;
	
		case "\\":
			draw_sprite_ext(s_fn_font_extras, 2, rot_x, rot_y, 0.5, 0.5, image_angle, c_purple, 1);
		break;
	}

	draw_set_color(c_white);
	if (held_number != "none") {
		if (held_number == "inf") {
		
			color_shift += 5;
			color_shift = color_shift mod 255;

			orig_x = x+shot_dist_to_player + epsilon;
			orig_y = y;
			rot_x = (orig_x - x) * dcos(-1*image_angle) - (orig_y - y) * dsin(-1*image_angle) + x;
			rot_y = (orig_x - x) * dsin(-1*image_angle) + (orig_y - y) * dcos(-1*image_angle) + y;
			draw_sprite_ext(s_fn_font_extras, 0, rot_x, rot_y, 0.5, 0.5, image_angle, make_color_hsv(0+color_shift,255,255), 1);
		} else {
			for (var i = 0; i < string_length(held_number); i++){
				orig_x = x+shot_dist_to_player+(24*i) + epsilon;
				orig_y = y;
				rot_x = (orig_x - x) * dcos(-1*image_angle) - (orig_y - y) * dsin(-1*image_angle) + x;
				rot_y = (orig_x - x) * dsin(-1*image_angle) + (orig_y - y) * dcos(-1*image_angle) + y;
				draw_text_transformed(rot_x, rot_y,string_char_at(held_number,i+1),0.5,0.5*image_yscale,image_angle);
			}
		}
	}

} else {
	

if (dcos(image_angle) < 0) {
	image_yscale = lerp(image_yscale, -1, 0.3);
} else {
	image_yscale = lerp(image_yscale, 1, 0.3);
}
var way_there = abs(shot_dist_to_player - shot_dist_to_player_default) / (32 - shot_dist_to_player_default);
var x1 = x - 32 * image_xscale;
var y1 = y - 32 * image_yscale;
var x2 = x + 32 * image_xscale;
var y2 = y - (32 * image_yscale) + (15 * way_there) * image_yscale;
var x3 = x + 32 * image_xscale;
var y3 = y + (32 * image_yscale) - (15 * way_there) * image_yscale;
var x4 = x - 32 * image_xscale;
var y4 = y + 32 * image_yscale;
var the_angle = -1 * image_angle;
var x1_rot = (x1 - x) * dcos(the_angle) - (y1 - y) * dsin(the_angle) + x;
var y1_rot = (x1 - x) * dsin(the_angle) + (y1 - y) * dcos(the_angle) + y;
var x2_rot = (x2 - x) * dcos(the_angle) - (y2 - y) * dsin(the_angle) + x;
var y2_rot = (x2 - x) * dsin(the_angle) + (y2 - y) * dcos(the_angle) + y;
var x3_rot = (x3 - x) * dcos(the_angle) - (y3 - y) * dsin(the_angle) + x;
var y3_rot = (x3 - x) * dsin(the_angle) + (y3 - y) * dcos(the_angle) + y;
var x4_rot = (x4 - x) * dcos(the_angle) - (y4 - y) * dsin(the_angle) + x;
var y4_rot = (x4 - x) * dsin(the_angle) + (y4 - y) * dcos(the_angle) + y;
draw_sprite_pos(s_player, 0, x1_rot, y1_rot, x2_rot, y2_rot, x3_rot, y3_rot, x4_rot, y4_rot, 1);


draw_set_valign(fa_middle);
draw_set_halign(fa_center);
audiotick++;
audiotick = audiotick % 1000;
///DRAW HP
var use_me = 0;
if (image_yscale < 0) {
	use_me = 180;
}
var lerp_spd = 0.6;
side_x1 = lerp(side_x1, x + lengthdir_x(64,image_angle+90+use_me), lerp_spd);
side_y1 = lerp(side_y1, y + lengthdir_y(64,image_angle+90+use_me), lerp_spd);
side_x2 = lerp(side_x2, x + lengthdir_x(64,image_angle-90+use_me), lerp_spd);
side_y2 = lerp(side_y2,  y + lengthdir_y(64,image_angle-90+use_me), lerp_spd);
draw_text_transformed(side_x1, side_y1,hp,0.5,0.5, image_angle + use_me);
draw_text_transformed(side_x2, side_y2,"n = 0",0.4,0.4, image_angle + use_me);

draw_set_valign(fa_top);
draw_set_halign(fa_left);

gui_mouse_scale = lerp(gui_mouse_scale, 1, 0.25);
///CAPTURE MODULES
if (instance_exists(o_module)){
	var module = instance_nearest(x,y,o_module);
	if (distance_to_object(o_module) < 256 && point_distance(mouse_x,mouse_y,module.x,module.y) <= 80){
		gui_mouse_scale = lerp(gui_mouse_scale, 0.5, 0.15);
		draw_line(x,y,module.x,module.y);
		module.selected = true;
		if (point_direction(module.x,module.y,x,y) > 180){
			module.ang = point_direction(module.x,module.y,x,y)+90;
		}else{
			module.ang = point_direction(module.x,module.y,x,y)-90;
		}
		with(module){
			if (mouse_check_button_pressed(mb_left)){	
				audio_play_sound(CLICKSFX,0,false);	
				switch (value) {
					case "+":
						other.held_operation = "+";
					break;
					
					case "\\":
						other.held_operation = "\\";
					break;
					
					case "-":
						other.held_operation = "-";
					break;
					
					case "*":
						other.held_operation = "*";
					break;
					
					case "inf":
						other.held_number = "inf";
					break;
					
					default:
					if (other.held_number != "inf" && other.held_number != "none") {
						switch (other.held_operation) {
							case "+":
								
								other.held_number += value;
								
							break;
							
							case "-":
								other.held_number -= value;
							break;
							
							case "*":
							
								other.held_number *= value;
							break;
							
							case "\\":
								if (value == 0) {
									game_restart();	
								}
								other.held_number /= value;
							break;
						}
					} else if (other.held_number == "none") {
						other.held_number = value;	
					}
				}
				instance_destroy();
			}
		}
	}
}

///



if (mouse_check_button_pressed(mb_right)){
	audio_play_sound(AIM,0,false);	
}else if (mouse_check_button_released(mb_right)){
	audio_play_sound(AIM,0,false);
}

if (mouse_check_button(mb_left)){
	gui_mouse_scale = lerp(gui_mouse_scale, 0.25, 0.35);
	
}

shot_dist_to_player_target = shot_dist_to_player_default;
if (beam_juice > 0) {
	beam_juice--;	
}

if (mouse_check_button(mb_right)){
	shot_dist_to_player_target = 32;
	if (held_number != "none" && held_number != "inf" && (mouse_check_button_pressed(mb_left) || keyboard_check_pressed(vk_space))) {
		var bullet = instance_create_layer(x + shot_dist_to_player, y, "Instances", o_bullet);
		bullet.value = held_number;
		bullet.operation = held_operation;
		bullet.angle = image_angle;
		bullet.spd = 30;
		held_number = "none";
	} else if (mouse_check_button(mb_left) && held_number == "inf") {
		if (!started_charging_beam) {
			started_charging_beam = true;	
			beam_charge = beam_charge_time;
		} 
		if (beam_charge == 0 && started_charging_beam) {
			beam_juice = juice_refill;
			infinity_power = max_infinity_power;
			held_number = "none";
			started_charging_beam = false;
		} else {
			
			if (beam_charge > 0) {
				beam_charge--;	
			}
		}
	}
	if (mouse_check_button_released(mb_left)) {
		if (started_charging_beam) {
			started_charging_beam = false;
			beam_charge = 0;
			beam_juice = 0;
		}	
	}
	if (audiotick % choose(2,8,32,64) == 0 && (mouse_x != prev_mousex || mouse_y != prev_mousey)){
		audio_play_sound(AIMING,false,0);
	}

	prev_mousex = mouse_x;
	prev_mousey = mouse_y;



	///DRAW AIM ANGLE
	//draw_text_transformed(mouse_x + 32,mouse_y-32,point_direction(x,y,mouse_x,mouse_y),0.5,0.5,0);
	///DRAW AIM COORDS X
	draw_set_valign(fa_middle);
	draw_set_halign(fa_left);
	draw_text_transformed(mouse_x + 16 + 8,mouse_y,(mouse_x - o_game.origin[0])/64,0.25,0.25,0);
	///DRAW AIM COORDS Y
	draw_set_valign(fa_middle);
	draw_set_halign(fa_center);
	draw_text_transformed(mouse_x,mouse_y-32,-(mouse_y - o_game.origin[1])/64,0.25,0.25,0);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	
	
	if (angle_difference(point_direction(x,y,mouse_x,mouse_y), angle) > 100 || angle_difference(point_direction(x,y,mouse_x,mouse_y), angle) < -100){
		if (!turnsfx){
			audio_play_sound(TURN,0,false);
			turnsfx = true;
		}
		image_xscale = -1;

	}else{
		turnsfx = false;
	}

} else {
	if (started_charging_beam) {
		started_charging_beam = false;
		beam_charge = 0;
		beam_juice = 0;
	}
}
aim_peekx = lengthdir_x((point_distance(x,y,mouse_x,mouse_y)/4.5),point_direction(x,y,mouse_x,mouse_y));
aim_peeky = lengthdir_y((point_distance(x,y,mouse_x,mouse_y)/2.5),point_direction(x,y,mouse_x,mouse_y));
angle += angle_difference(point_direction(x,y,mouse_x,mouse_y), angle) * 0.25;
draw_set_valign(fa_middle);
draw_set_halign(fa_left);

///How to represent a normal number --->            
///REFERENCE \frac{32\cdot 8}{4}\cdot 122+99+\tan \left(5\right)\cdot \sqrt{32}+5!+8^5
///What do we want? Addition, subtraction, multiplication, division, and occasional to the nth power
//FOR NOW DO ADDITION
//DRAW VALUE/EQUATION AND CALCULATE
//
//LOOP THROUGH OUR EQUATION
epsilon = 5*dsin(epsilon_index);
var orig_x = 0;
if (held_number == "none") {
	orig_x = x+shot_dist_to_player + epsilon;
} else if (held_number == "inf") {
	orig_x = x+shot_dist_to_player + sprite_get_width(s_fn_font_extras) + epsilon;
} else {
	orig_x = x+shot_dist_to_player+(24*string_length(held_number)) + epsilon;
}

if (held_number == "none") {
	var orig_x = x+shot_dist_to_player + epsilon;
} else if (held_number == "inf") {
	var orig_x = x+shot_dist_to_player + sprite_get_width(s_fn_font_extras), epsilon;
} else {
	var orig_x = x+shot_dist_to_player+(24*string_length(held_number)) + epsilon;
}

var orig_y = y;
var rot_x = (orig_x - x) * dcos(-1*image_angle) - (orig_y - y) * dsin(-1*image_angle) + x;
var rot_y = (orig_x - x) * dsin(-1*image_angle) + (orig_y - y) * dcos(-1*image_angle) + y;

switch (held_operation) {
	case "+":
		//draw_sprite_ext(s_fn_font, sprite_get_number(s_fn_font) - 1, rot_x, rot_y, 1, 1, image_angle, c_green, 1);
		draw_sprite_ext(s_fn_font_extras, 4, rot_x, rot_y, 0.5, 0.5, image_angle, c_green, 1);
	break;
	
	case "-":
		draw_sprite_ext(s_fn_font_extras, 1, rot_x, rot_y, 0.5, 0.5, image_angle, c_red, 1);
	break;
	
	case "*":
		draw_sprite_ext(s_fn_font_extras, 3, rot_x, rot_y, 0.5, 0.5, image_angle, c_yellow, 1);
	break;
	
	case "\\":
		draw_sprite_ext(s_fn_font_extras, 2, rot_x, rot_y, 0.5, 0.5, image_angle, c_purple, 1);
	break;
}

draw_set_color(c_white);
if (held_number != "none") {
	if (held_number == "inf") {
		
		color_shift += 5;
		color_shift = color_shift mod 255;

		orig_x = x+shot_dist_to_player + epsilon;
		orig_y = y;
		rot_x = (orig_x - x) * dcos(-1*image_angle) - (orig_y - y) * dsin(-1*image_angle) + x;
		rot_y = (orig_x - x) * dsin(-1*image_angle) + (orig_y - y) * dcos(-1*image_angle) + y;
		draw_sprite_ext(s_fn_font_extras, 0, rot_x, rot_y, 0.5, 0.5, image_angle, make_color_hsv(0+color_shift,255,255), 1);
	} else {
		for (var i = 0; i < string_length(held_number); i++){
			orig_x = x+shot_dist_to_player+(24*i) + epsilon;
			orig_y = y;
			rot_x = (orig_x - x) * dcos(-1*image_angle) - (orig_y - y) * dsin(-1*image_angle) + x;
			rot_y = (orig_x - x) * dsin(-1*image_angle) + (orig_y - y) * dcos(-1*image_angle) + y;
			draw_text_transformed(rot_x, rot_y,string_char_at(held_number,i+1),0.5,0.5*image_yscale,image_angle);
		}
	}
}

draw_set_valign(fa_top);
draw_set_halign(fa_left);


shot_dist_to_player = lerp(shot_dist_to_player, shot_dist_to_player_target, 0.4);
if (keyboard_check_pressed(vk_shift)) {
	dashing = true;
	dash_timer = 10;
	dash_angle = angle;
	dash_mx = mouse_x;
	dash_my = mouse_y;
	image_xscale = 1;
	image_yscale = 1;
}
}

if (dashing) {
    image_xscale = 1.5;
	if (dash_timer <= 0) {
		dashing = false;	
	}else if (distance_to_point(dash_mx, dash_my) <= 5){
		dash_timer = 0;
		dashing = false;
	}
	dash_timer--;
	var x_spd = lengthdir_x(spd * 5, dash_angle);
	var y_spd = lengthdir_y(spd * 5, dash_angle);
	x += x_spd;
	y += y_spd;	
} else {
	image_xscale = lerp(image_xscale, 1, 0.25);

	var xmove = keyboard_check(ord("D")) - keyboard_check(ord("A"));
	var ymove = keyboard_check(ord("S")) - keyboard_check(ord("W"));

	image_angle = angle;
	x += xmove * spd;
	y += ymove * spd;
}


if (beam_charge > 0) {
	
	var x_pos = x + lengthdir_x(radius_out, image_angle);
	var y_pos = y + lengthdir_y(radius_out, image_angle);
	
	draw_sprite_ext(s_blast_charge, (round(beam_charge_time - beam_charge) / beam_charge_time) * (sprite_get_number(s_blast_charge) - 1), x_pos, y_pos, 2, 2, image_angle - 90, c_white, 1);
}
if (beam_juice > 0) {
	beam_current_length = beam_max_length;
	var x_pos = x + lengthdir_x(radius_out, image_angle);
	var y_pos = y + lengthdir_y(radius_out, image_angle);
	draw_sprite_ext(s_blast_charge, (sprite_get_number(s_blast_charge) - 1), x_pos, y_pos, 2, 2, image_angle - 90, c_white, 1);
	draw_sprite_ext(s_blast, 0, x_pos, y_pos, 2, beam_current_length, image_angle + 90, c_white, 1);
	
}