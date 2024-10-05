graph_is_done = true;
for (var i = 0; i < ds_list_size(o_global_graph.graph_list); i++) {
	if (!o_global_graph.graph_list[| i].done_drawing) {
		graph_is_done = false;
	}
}
if (graph_is_done) {

	if (!timer_ticking) {
		timer_ticking = true;
		time_until_new_graph = 500;
		scr_wave_spawn(0,0,32,32,10);
	} else {
		time_until_new_graph--;
		
		if (time_until_new_graph == 0) {
			timer_ticking = false;
			for (var i = 0; i < instance_number(projectile_testing); i++) {
				var the_delta = instance_find(projectile_testing,i);
				the_delta.my_graph = 0;
				
				the_delta.custom_angle = true;
				the_delta.point_to = random(360);
			}
			for (var i = 0; i < ds_list_size(o_global_graph.graph_list); i++) {
				ds_list_add(o_global_graph.reverting_graph_list, o_global_graph.graph_list[| i]);	
			}
			ds_list_clear(o_global_graph.graph_list);
			graph_scale = 1;
			generateEquation(phase);
		}
		
		
	}
}

switch (phase) {
	
	case 0:
		if (idle_time > 0) { 
			idle_time--;	
		} else {
			if (!attack_chosen) {
				next_attack = choose(0, 1);
				attack_chosen = true;
			}
			if (next_attack == 0) {
				if (delta_count == 0) {
					delta_count = choose(1, 3);
				} else {
					if (num_made == delta_count) {
						delta_count = 0;
						num_made = 0;
						idle_time = idle_time_phase1;
						attack_chosen = false;
					} else {
						if (num_made == 0) {
							locked_angle = point_direction(x, y, o_player.x, o_player.y);
						}
						image_angle = lerp(image_angle, locked_angle + 90, 0.3);
						if (ticker <= 0) {
							var mid_point = floor(delta_count / 2);
							var dist_to_mid = num_made - mid_point;
							var angle = locked_angle + (dist_to_mid * degree_delta);
							var x_pos = x + lengthdir_x(radius_out, angle);
							var y_pos = y + lengthdir_y(radius_out, angle);
							var bullet = instance_create_layer(x_pos, y_pos, "Instances", projectile_testing);
							bullet.custom_angle = true;
							bullet.aim_timer = 1 * room_speed;
							bullet.point_to = angle;
							bullet.rogue = true;
							num_made++;
							ticker = time_between_spawns;
						} else {
							ticker--;
						}
					}
				}
			} else {
				if (num_dashes == 0) {
					num_dashes = irandom_range(1, 3);	
				}
				if (num_dashes > 0) {
					if (boss_graph != 0) {
						if (!boss_graph.done_drawing) {
							if (boss_graph.x_upper < full_dom_dist) {
								var crazy = 4;
								for (var i = 0; i < crazy; i++) {
									var orig_x = boss_graph.x_upper;
									var orig_y = -1*64*evaluate(boss_graph.func, (1 / 64) * boss_graph.x_upper);
									var rot_x = orig_x * dcos(boss_graph.angle) - orig_y * dsin(boss_graph.angle);
									var rot_y =	orig_x * dsin(boss_graph.angle) + orig_y * dcos(boss_graph.angle);
			
									boss_graph.positive_drawn_vertices[boss_graph.index] = new tuple(rot_x, rot_y);
									boss_graph.index++;
									boss_graph.x_upper += boss_graph.fidelity;
									boss_graph.x_upper = clamp(boss_graph.x_upper, 0, full_dom_dist);
								}
							} else {
								
								boss_graph.done_drawing = true;	
							}
						} else {
							if (point_on_dom < full_dom_dist) {
					
								var orig_x = point_on_dom;
								var orig_y = -1*64*evaluate(boss_graph.func, (1 / 64) * point_on_dom);
								var rot_x = orig_x * dcos(boss_graph.angle) - orig_y * dsin(boss_graph.angle);
								var rot_y = orig_x * dsin(boss_graph.angle) + orig_y * dcos(boss_graph.angle);
								prev_x = x;
								prev_y = y;
								x = rot_x + boss_graph.start_x;
								y = rot_y + boss_graph.start_y;
					
								for (var i = 0; i < array_length(boss_graph.positive_drawn_vertices); i++) {
									if (boss_graph.positive_drawn_vertices[i] != 0) {
										orig_x = boss_graph.positive_drawn_vertices[i]._xx;
										orig_y = boss_graph.positive_drawn_vertices[i]._yy;
										var unrot_x = (orig_x) * dcos(-1 * boss_graph.angle) - (orig_y) * dsin(-1 * boss_graph.angle);
										
										if (unrot_x < point_on_dom) {
											boss_graph.positive_drawn_vertices[i] = 0;	
										}
									}
								}
								point_on_dom += spd;	
								point_on_dom = clamp(point_on_dom, 0, full_dom_dist);
								if (point_distance(prev_x, prev_y, x, y) > 0.1) {
									image_angle = (point_direction(prev_x, prev_y, x, y) + 90);
								}
				
							} else {
								num_dashes--;
								repeat(random_range(0,10)){
									instance_create_layer(x,y,"Instances",o_module);
								}
								if (num_dashes == 0) {
									idle_time = idle_time_phase1;	
									attack_chosen = false;
								}
								if (point_distance(prev_x, prev_y, x, y) > 0.1) {
									image_angle = (point_direction(prev_x, prev_y, x, y) + 90);
								}
								boss_graph = 0;
							}
						}
					} else {
		
						if (time_before_charge <= 0) {
							boss_graph = new graph(
							new token(choose(TOKENS.CONSTANT, TOKENS.SIN), 0, 0),
							-1*point_direction(x, y, o_player.x, o_player.y), 
							x,
							y, 
							false,
							0);
							if (boss_graph.func.tok == TOKENS.SIN) {
								boss_graph.func = new token(TOKENS.MULT, boss_graph.func, new token(TOKENS.CONSTANT, random_range(1, 5), 0));
							}
							target_x = o_player.x;
							target_y = o_player.y;	
							point_on_dom = 0;
							time_before_charge = 10;
							boss_graph.fidelity = 20;
							full_dom_dist = point_distance(x, y, target_x, target_y) + 50;
						}

						image_angle = lerp(image_angle, image_angle - angle_difference(image_angle, (point_direction(x, y, o_player.x, o_player.y)  + 90)), 0.3);
						time_before_charge--;
					}
				}
			}
		}
		if (hpbar1 <= 0) {
			delta_count = 0;
			num_made = 0;
			phase = 1;	
			num_dashes = 0;
			spd *= 1.5;
			idle_time = idle_time_phase2;
			time_until_new_graph = 1;
		}
	break;
	
	case 1:
	
		if (idle_time > 0) { 
			idle_time--;	
		} else {
			if (!attack_chosen) {
				next_attack = choose(0, 1);
				attack_chosen = true;
			}
			if (next_attack == 0) {
				if (delta_count == 0) {
					delta_count = choose(3, 7);
				} else {
					if (num_made == delta_count) {
						delta_count = 0;
						num_made = 0;
						idle_time = idle_time_phase2;
						attack_chosen = false;
					} else {
						if (num_made == 0) {
							locked_angle = point_direction(x, y, o_player.x, o_player.y);
						}
						image_angle = lerp(image_angle, locked_angle + 90, 0.3);
						if (ticker <= 0) {
							var mid_point = floor(delta_count / 2);
							var dist_to_mid = num_made - mid_point;
							var angle = locked_angle + (dist_to_mid * degree_delta);
							var x_pos = x + lengthdir_x(radius_out, angle);
							var y_pos = y + lengthdir_y(radius_out, angle);
							var bullet = instance_create_layer(x_pos, y_pos, "Instances", projectile_testing);
							bullet.custom_angle = true;
							bullet.aim_timer = 1 * room_speed;
							bullet.point_to = angle;
							bullet.rogue = true;
							num_made++;
							ticker = time_between_spawns;
						} else {
							ticker--;
						}
					}
				}
			} else {
				if (num_dashes == 0) {
					num_dashes = irandom_range(2, 4);	
				}
				if (num_dashes > 0) {
					if (boss_graph != 0) {
						if (!boss_graph.done_drawing) {
							if (boss_graph.x_upper < full_dom_dist) {
								var crazy = 4;
								for (var i = 0; i < crazy; i++) {
									var orig_x = boss_graph.x_upper;
									var orig_y = -1*64*evaluate(boss_graph.func, (1 / 64) * boss_graph.x_upper);
									var rot_x = orig_x * dcos(boss_graph.angle) - orig_y * dsin(boss_graph.angle);
									var rot_y =	orig_x * dsin(boss_graph.angle) + orig_y * dcos(boss_graph.angle);
			
									boss_graph.positive_drawn_vertices[boss_graph.index] = new tuple(rot_x, rot_y);
									boss_graph.index++;
									boss_graph.x_upper += boss_graph.fidelity;
									boss_graph.x_upper = clamp(boss_graph.x_upper, 0, full_dom_dist);
								}
							} else {
								
								boss_graph.done_drawing = true;	
							}
						} else {
							if (point_on_dom < full_dom_dist) {
					
								var orig_x = point_on_dom;
								var orig_y = -1*64*evaluate(boss_graph.func, (1 / 64) * point_on_dom);
								var rot_x = orig_x * dcos(boss_graph.angle) - orig_y * dsin(boss_graph.angle);
								var rot_y = orig_x * dsin(boss_graph.angle) + orig_y * dcos(boss_graph.angle);
								prev_x = x;
								prev_y = y;
								x = rot_x + boss_graph.start_x;
								y = rot_y + boss_graph.start_y;
					
								for (var i = 0; i < array_length(boss_graph.positive_drawn_vertices); i++) {
									if (boss_graph.positive_drawn_vertices[i] != 0) {
										orig_x = boss_graph.positive_drawn_vertices[i]._xx;
										orig_y = boss_graph.positive_drawn_vertices[i]._yy;
										var unrot_x = (orig_x) * dcos(-1 * boss_graph.angle) - (orig_y) * dsin(-1 * boss_graph.angle);
										
										if (unrot_x < point_on_dom) {
											boss_graph.positive_drawn_vertices[i] = 0;	
										}
									}
								}
								point_on_dom += spd;	
								point_on_dom = clamp(point_on_dom, 0, full_dom_dist);
								if (point_distance(prev_x, prev_y, x, y) > 0.1) {
									image_angle = (point_direction(prev_x, prev_y, x, y) + 90);
								}
								
				
							} else {
								num_dashes--;
								repeat(random_range(0,10)){
									instance_create_layer(x,y,"Instances",o_module);
								}
								if (num_dashes == 0) {
									idle_time = idle_time_phase2;	
									attack_chosen = false;
								}
								if (point_distance(prev_x, prev_y, x, y) > 0.1) {
									image_angle = (point_direction(prev_x, prev_y, x, y) + 90);
								}
								boss_graph = 0;
							}
						}
					} else {
		
						if (time_before_charge <= 0) {
							boss_graph = new graph(
							new token(choose(TOKENS.CONSTANT, TOKENS.SIN), 0, 0),
							-1*point_direction(x, y, o_player.x, o_player.y), 
							x,
							y, 
							false,
							0);
							if (boss_graph.func.tok == TOKENS.SIN) {
								boss_graph.func = new token(TOKENS.MULT, boss_graph.func, new token(TOKENS.CONSTANT, random_range(1, 5), 0));
							}
							target_x = o_player.x;
							target_y = o_player.y;	
							point_on_dom = 0;
							time_before_charge = 10;
							boss_graph.fidelity = 20;
							full_dom_dist = point_distance(x, y, target_x, target_y) + 50;
						}
			
						
						image_angle = lerp(image_angle, image_angle - angle_difference(image_angle, (point_direction(x, y, o_player.x, o_player.y)  + 90)), 0.3);
			
						time_before_charge--;
					}
				}
			}
		}
		
		
		if (hpbar2 <= 0) {
			phase = 2;	
			attack_chosen = false;
			delta_count = 0;
			num_made = 0;
			spd *= 1.5;
			num_dashes = 0;
			idle_time = idle_time_phase3;
			time_until_new_graph = 1;
		}
	break;
	
	case 2:
		if (idle_time > 0) { 
			idle_time--;	
		} else {
			if (!attack_chosen) {
				next_attack = choose(0,1,2);
				
				attack_chosen = true;
			}
			if (next_attack == 0) {
				if (delta_count == 0) {
					delta_count = choose(5, 12);
				} else {
					if (num_made == delta_count) {
						delta_count = 0;
						num_made = 0;
						idle_time = idle_time_phase3;
						attack_chosen = false;
					} else {
						if (num_made == 0) {
							locked_angle = point_direction(x, y, o_player.x, o_player.y);
						}
						image_angle = lerp(image_angle, locked_angle + 90, 0.3);
						if (ticker <= 0) {
							var mid_point = floor(delta_count / 2);
							var dist_to_mid = num_made - mid_point;
							var angle = locked_angle + (dist_to_mid * degree_delta);
							var x_pos = x + lengthdir_x(radius_out, angle);
							var y_pos = y + lengthdir_y(radius_out, angle);
							var bullet = instance_create_layer(x_pos, y_pos, "Instances", projectile_testing);
							bullet.custom_angle = true;
							bullet.aim_timer = 1 * room_speed;
							bullet.point_to = angle;
							bullet.rogue = true;
							num_made++;
							ticker = time_between_spawns;
						} else {
							ticker--;
						}
					}
				}
			} else if (next_attack == 1) {
				if (num_dashes == 0) {
					num_dashes = irandom_range(4, 6);	
				}
				if (num_dashes > 0) {
					if (boss_graph != 0) {
						if (!boss_graph.done_drawing) {
							if (boss_graph.x_upper < full_dom_dist) {
								var crazy = 4;
								for (var i = 0; i < crazy; i++) {
									var orig_x = boss_graph.x_upper;
									var orig_y = -1*64*evaluate(boss_graph.func, (1 / 64) * boss_graph.x_upper);
									var rot_x = orig_x * dcos(boss_graph.angle) - orig_y * dsin(boss_graph.angle);
									var rot_y =	orig_x * dsin(boss_graph.angle) + orig_y * dcos(boss_graph.angle);
			
									boss_graph.positive_drawn_vertices[boss_graph.index] = new tuple(rot_x, rot_y);
									boss_graph.index++;
									boss_graph.x_upper += boss_graph.fidelity;
									boss_graph.x_upper = clamp(boss_graph.x_upper, 0, full_dom_dist);
								}
							} else {
								
								boss_graph.done_drawing = true;	
							}
						} else {
							if (point_on_dom < full_dom_dist) {
					
								var orig_x = point_on_dom;
								var orig_y = -1*64*evaluate(boss_graph.func, (1 / 64) * point_on_dom);
								var rot_x = orig_x * dcos(boss_graph.angle) - orig_y * dsin(boss_graph.angle);
								var rot_y = orig_x * dsin(boss_graph.angle) + orig_y * dcos(boss_graph.angle);
								prev_x = x;
								prev_y = y;
								x = rot_x + boss_graph.start_x;
								y = rot_y + boss_graph.start_y;
					
								for (var i = 0; i < array_length(boss_graph.positive_drawn_vertices); i++) {
									if (boss_graph.positive_drawn_vertices[i] != 0) {
										orig_x = boss_graph.positive_drawn_vertices[i]._xx;
										orig_y = boss_graph.positive_drawn_vertices[i]._yy;
										var unrot_x = (orig_x) * dcos(-1 * boss_graph.angle) - (orig_y) * dsin(-1 * boss_graph.angle);
										
										if (unrot_x < point_on_dom) {
											boss_graph.positive_drawn_vertices[i] = 0;	
										}
									}
								}
								point_on_dom += spd;	
								point_on_dom = clamp(point_on_dom, 0, full_dom_dist);
								if (point_distance(prev_x, prev_y, x, y) > 0.1) {
									image_angle = (point_direction(prev_x, prev_y, x, y) + 90);
								}
				
							} else {
								num_dashes--;
								repeat(random_range(0,10)){
									instance_create_layer(x,y,"Instances",o_module);
								}
								if (num_dashes == 0) {
									idle_time = idle_time_phase3;	
									attack_chosen = false;
								}
								if (point_distance(prev_x, prev_y, x, y) > 0.1) {
									image_angle = (point_direction(prev_x, prev_y, x, y) + 90);
								}
								boss_graph = 0;
							}
						}
					} else {
		
						if (time_before_charge <= 0) {
							boss_graph = new graph(
							new token(choose(TOKENS.CONSTANT, TOKENS.SIN), 0, 0),
							-1*point_direction(x, y, o_player.x, o_player.y), 
							x,
							y, 
							false,
							0);
							if (boss_graph.func.tok == TOKENS.SIN) {
								boss_graph.func = new token(TOKENS.MULT, boss_graph.func, new token(TOKENS.CONSTANT, random_range(2, 6), 0));
							}
							target_x = o_player.x;
							target_y = o_player.y;	
							point_on_dom = 0;
							time_before_charge = 10;
							boss_graph.fidelity = 20;
							full_dom_dist = point_distance(x, y, target_x, target_y) + 50;
						}
			
						image_angle = lerp(image_angle, image_angle - angle_difference(image_angle, (point_direction(x, y, o_player.x, o_player.y)  + 90)), 0.3);
			
						time_before_charge--;
					}
				}
			} else {
				if (!started_charging_beam) {
					started_charging_beam = true;
					beam_charge = beam_charge_time;
				} else {
					image_angle = lerp(image_angle, image_angle - angle_difference(image_angle, point_direction(x, y, o_player.x, o_player.y) + 90), 0.01);
					if (beam_charge == 0) {
						
						beam_juice = juice_refill;
						beam_charge--;
					} else {
						beam_charge--;	
					}
					if (beam_charge < 0) {
						if (beam_juice <= 0) {
						
							beam_juice = 0;
							beam_charge = 0;
							started_charging_beam = false;
							idle_time = idle_time_phase3;	
							attack_chosen = false;

						} else {
							var the_angler = -1*(image_angle);
	
							var orig_top_x = x + sprite_width / 2;
							var orig_top_y = y;
							var rot_top_x = (orig_top_x - x) * dcos(the_angler) - (orig_top_y - y) * dsin(the_angler) + x;
							var rot_top_y = (orig_top_x - x) * dsin(the_angler) + (orig_top_y - y) * dcos(the_angler) + y;

							var orig_bottom_x = x - sprite_width / 2;
							var orig_bottom_y = y;
							var rot_bottom_x = (orig_bottom_x - x) * dcos(the_angler) - (orig_bottom_y - y) * dsin(the_angler) + x;
							var rot_bottom_y = (orig_bottom_x - x) * dsin(the_angler) + (orig_bottom_y - y) * dcos(the_angler) + y;
	
							if (!o_player.dashing && 
							(collision_line(x, y, x + lengthdir_x(point_distance(x, y, o_player.x, o_player.y) + 100, image_angle - 90), y + lengthdir_y(point_distance(x, y, o_player.x, o_player.y) + 100, image_angle - 90), o_player, false, true) || 
							collision_line(rot_top_x, rot_top_y, rot_top_x + lengthdir_x(point_distance(x, y, o_player.x, o_player.y) + 100, image_angle - 90), rot_top_y + lengthdir_y(point_distance(x, y, o_player.x, o_player.y) + 100, image_angle - 90), o_player, false, true) ||
							collision_line(rot_bottom_x, rot_bottom_y, rot_bottom_x + lengthdir_x(point_distance(x, y, o_player.x, o_player.y) + 100, image_angle - 90), rot_bottom_y + lengthdir_y(point_distance(x, y, o_player.x, o_player.y) + 100, image_angle - 90), o_player, false, true))) {
								o_player.hp -= 0.1;
							} 
							beam_juice--;
							beam_current_length = lerp(beam_current_length, beam_max_length, 0.1);
						}
					}
					
					
				}
			}
		}
		if (hpbar3 <= 0) {
			
			game_restart();
		}
	break;
}