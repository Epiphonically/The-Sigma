var crazy = 0;
var epsilon = 0.001;

for (var i = 0; i < ds_list_size(reverting_graph_list); i++) {
	var the_graph = reverting_graph_list[| i];
	var batch_to_delete = 5;
	
	var num_deleted = 0;
	for (var j = 0; j < the_graph.index && num_deleted < batch_to_delete; j++) {
		if (the_graph.positive_drawn_vertices[j] != 0) {
			the_graph.positive_drawn_vertices[j] = 0;
			the_graph.negative_drawn_vertices[j] = 0;
			num_deleted++;
		}
	}
}

if (keyboard_check_pressed(vk_space)) {
	
	for (var i = 0; i < ds_list_size(graph_list); i++) {
		var the_graph = graph_list[|i];
		
		if (the_graph.heavy) {
			the_graph.domain_stretch_target *= 2;	
			the_graph.domain_stretch_target = clamp(the_graph.domain_stretch_target, 1/2, 4);
			o_boss.graph_scale *= 2;
			o_boss.graph_scale = clamp(o_boss.graph_scale, 1/2, 4);
		} else {
			the_graph.range_stretch_target *= 2;	
			the_graph.range_stretch_target = clamp(the_graph.range_stretch_target, 1/2, 4);
			o_boss.graph_scale *= 2;
			o_boss.graph_scale = clamp(o_boss.graph_scale, 1/2, 4);
		}
	}
} else if (keyboard_check_pressed(vk_control)) {
		
	for (var i = 0; i < ds_list_size(graph_list); i++) {
		var the_graph = graph_list[|i];
		if (the_graph.heavy) {
			the_graph.domain_stretch_target /= 2;	
			the_graph.domain_stretch_target = clamp(the_graph.domain_stretch_target, 1/2, 4);
			o_boss.graph_scale /= 2;
			o_boss.graph_scale = clamp(o_boss.graph_scale, 1/2, 4);
		} else {
			the_graph.range_stretch_target /= 2;	
			the_graph.range_stretch_target = clamp(the_graph.range_stretch_target, 1/2, 4);
			o_boss.graph_scale /= 2;
			o_boss.graph_scale = clamp(o_boss.graph_scale, 1/2, 4);
		
		}
	}
}
for (var i = 0; i < ds_list_size(graph_list); i++) {
	
	var the_graph = graph_list[| i];

	
	if (the_graph.time_before_drawn != 0) {
		the_graph.time_before_drawn--;
	} else {
		

		if (the_graph.done_drawing || the_graph.x_upper >= sqrt(power(room_width / 2,2)+power(room_height / 2,2))) {
			if (the_graph.scaling_time <= 0 && the_graph.x_upper >= sqrt(power(room_width / 2,2)+power(room_height / 2,2))) {
				the_graph.done_drawing = true;
				the_graph.x_upper = room_width / 2;
			}
			the_graph.scaling_time--;
		} else {
			
			if (the_graph.scaling_time <= 0 && the_graph.x_upper >= sqrt(power(room_width / 2,2)+power(room_height / 2,2))) {
				the_graph.done_drawing = true;
				the_graph.x_upper = room_width / 2;
			}
			var old_cache = the_graph.domain_stretch;
			if (the_graph.heavy) {
				var stretched = false
					if (abs(the_graph.domain_stretch - the_graph.domain_stretch_target) > 0.1) {
						the_graph.domain_stretch = lerp(the_graph.domain_stretch, the_graph.domain_stretch_target, 0.1);
						
						stretched = true;
					} else if (the_graph.domain_stretch != the_graph.domain_stretch_target) {
						the_graph.domain_stretch = the_graph.domain_stretch_target;
						
						stretched = true;
					}
					if (stretched) {
						the_graph.bad_indices = array_create(0, 0);
						the_graph.bad_indices_index = 0;
						the_graph.disco_passed = 0;
						the_graph.x_upper /= old_cache;
						the_graph.x_upper *= the_graph.domain_stretch;
				
						for (var j = 0; j < array_length(the_graph.positive_drawn_vertices); j++) {
							var calc_first = false;
							var calc_next = false;
							var nearest_discontinuity = ((32 * pi) * the_graph.domain_stretch) + ((the_graph.disco_passed * 64 * pi) * the_graph.domain_stretch);
							var before_x = the_graph.positive_drawn_vertices[j]._xx;
							var before_y = the_graph.positive_drawn_vertices[j]._yy;
							var unrot_x = before_x * dcos(-1 * the_graph.angle) - before_y * dsin(-1 * the_graph.angle);
					
							unrot_x /= old_cache;
							unrot_x *= the_graph.domain_stretch;
							if (j < array_length(the_graph.positive_drawn_vertices)-1) {
								var before_unrot_next_x = the_graph.positive_drawn_vertices[j + 1]._xx;
								var before_unrot_next_y = the_graph.positive_drawn_vertices[j + 1]._yy;
								var unrot_next_x = before_unrot_next_x * dcos(-1 * the_graph.angle) - before_unrot_next_y * dsin(-1 * the_graph.angle);
								unrot_next_x /= old_cache;
								unrot_next_x *= the_graph.domain_stretch;
								if (unrot_next_x >= nearest_discontinuity && unrot_x <= nearest_discontinuity) {
									//show_debug_message(string(unrot_x) + string(nearest_discontinuity));
									the_graph.disco_passed++;
									the_graph.bad_indices[the_graph.bad_indices_index++] = j;
							
									calc_first = true;
									unrot_x = nearest_discontinuity - epsilon;	
									if (j < array_length(the_graph.positive_drawn_vertices)-1) {
										calc_next = true;
										var cache_x = nearest_discontinuity + epsilon;
										var cache_y = -1*64*evaluate(the_graph.func ,(1/(64 * the_graph.domain_stretch)) * (nearest_discontinuity + epsilon));
										the_graph.positive_drawn_vertices[j + 1]._xx = cache_x * dcos(the_graph.angle) - cache_y * dsin(the_graph.angle);
										the_graph.positive_drawn_vertices[j + 1]._yy = cache_x * dsin(the_graph.angle) + cache_y * dcos(the_graph.angle);
								
								
									}
								}
							} else if (unrot_x + (the_graph.fidelity * the_graph.domain_stretch) >= nearest_discontinuity && unrot_x <= nearest_discontinuity) { //Inequality
					
								the_graph.disco_passed++;
								the_graph.bad_indices[the_graph.bad_indices_index++] = j;
							
								calc_first = true;
								unrot_x = nearest_discontinuity - epsilon;	
								if (j < array_length(the_graph.positive_drawn_vertices)-1) {
									calc_next = true;
									var cache_x = nearest_discontinuity + epsilon;
									var cache_y = -1*64*evaluate(the_graph.func ,(1/(64 * the_graph.domain_stretch)) * (nearest_discontinuity + epsilon));
									the_graph.positive_drawn_vertices[j + 1]._xx = cache_x * dcos(the_graph.angle) - cache_y * dsin(the_graph.angle);
									the_graph.positive_drawn_vertices[j + 1]._yy = cache_x * dsin(the_graph.angle) + cache_y * dcos(the_graph.angle);
								
								
								}
							}
							var unrot_y = -1*64*evaluate(the_graph.func ,(1/(64 * the_graph.domain_stretch)) * unrot_x);
							var new_x = unrot_x * dcos(the_graph.angle) - unrot_y * dsin(the_graph.angle);
							var new_y = unrot_x * dsin(the_graph.angle) + unrot_y * dcos(the_graph.angle);
							the_graph.positive_drawn_vertices[j]._xx = new_x;
							the_graph.positive_drawn_vertices[j]._yy = new_y;
						
					
							before_x = the_graph.negative_drawn_vertices[j]._xx;
							before_y = the_graph.negative_drawn_vertices[j]._yy;
							unrot_x = before_x * dcos(-1 * the_graph.angle) - before_y * dsin(-1 * the_graph.angle);
					
							unrot_x /= old_cache;
							unrot_x *= the_graph.domain_stretch;
						
							if (calc_first) {
								unrot_x = -1 * (nearest_discontinuity - epsilon);	
								if (calc_next) {
									var cache_x = -1 * (nearest_discontinuity + epsilon);
									var cache_y = -1*64*evaluate(the_graph.func ,(1/(64 * the_graph.domain_stretch)) * (cache_x));
									the_graph.negative_drawn_vertices[j + 1]._xx = cache_x * dcos(the_graph.angle) - cache_y * dsin(the_graph.angle);
									the_graph.negative_drawn_vertices[j + 1]._yy = cache_x * dsin(the_graph.angle) + cache_y * dcos(the_graph.angle);
								}
							}
							unrot_y = -1*64*evaluate(the_graph.func ,(1/(64 * the_graph.domain_stretch)) * unrot_x);
							new_x = unrot_x * dcos(the_graph.angle) - unrot_y * dsin(the_graph.angle);
							new_y = unrot_x * dsin(the_graph.angle) + unrot_y * dcos(the_graph.angle);
							the_graph.negative_drawn_vertices[j]._xx = new_x;
							the_graph.negative_drawn_vertices[j]._yy = new_y;
							if (calc_next) {
								j++;	
							}
						}
					}
			} 

		if (abs(the_graph.range_stretch - the_graph.range_stretch_target) > 0.1) {
			the_graph.range_stretch = lerp(the_graph.range_stretch, the_graph.range_stretch_target, 0.1);
			
			for (var j = 0; j < array_length(the_graph.positive_drawn_vertices); j++) {
				var before_x = the_graph.positive_drawn_vertices[j]._xx;
				var before_y = the_graph.positive_drawn_vertices[j]._yy;
				var unrot_x = (before_x) * dcos(-1 * the_graph.angle) - (before_y) * dsin(-1 * the_graph.angle);
				
				var unrot_y = -1*64*evaluate(the_graph.func, (1/64)*unrot_x);
				var new_y_before_rot = unrot_y * the_graph.range_stretch;
				var new_x = (unrot_x * dcos(the_graph.angle) - (new_y_before_rot) * dsin(the_graph.angle));
				var new_y = (unrot_x * dsin(the_graph.angle) + (new_y_before_rot) * dcos(the_graph.angle));
				the_graph.positive_drawn_vertices[j]._xx = new_x;
				the_graph.positive_drawn_vertices[j]._yy = new_y;
				
			    before_x = the_graph.negative_drawn_vertices[j]._xx;
				before_y = the_graph.negative_drawn_vertices[j]._yy;
				unrot_x = (before_x) * dcos(-1 * the_graph.angle) - (before_y) * dsin(-1 * the_graph.angle);
				unrot_y = -1*64*evaluate(the_graph.func, (1/64)*unrot_x);
				new_y_before_rot = unrot_y * the_graph.range_stretch;
				new_x = (unrot_x) * dcos(the_graph.angle) - (new_y_before_rot * dsin(the_graph.angle));
				new_y = (unrot_x) * dsin(the_graph.angle) + (new_y_before_rot * dcos(the_graph.angle));
				the_graph.negative_drawn_vertices[j]._xx = new_x;
				the_graph.negative_drawn_vertices[j]._yy = new_y;
				
			}
		} else {
			if (the_graph.range_stretch != the_graph.range_stretch_target) {
				the_graph.range_stretch = the_graph.range_stretch_target;
				for (var j = 0; j < array_length(the_graph.positive_drawn_vertices); j++) {
					var before_x = the_graph.positive_drawn_vertices[j]._xx;
					var before_y = the_graph.positive_drawn_vertices[j]._yy;
					var unrot_x = (before_x) * dcos(-1 * the_graph.angle) - (before_y) * dsin(-1 * the_graph.angle);
				
					var unrot_y = -1*64*evaluate(the_graph.func, (1/64)*unrot_x);
					var new_y_before_rot = unrot_y * the_graph.range_stretch;
					var new_x = (unrot_x * dcos(the_graph.angle) - (new_y_before_rot) * dsin(the_graph.angle));
					var new_y = (unrot_x * dsin(the_graph.angle) + (new_y_before_rot) * dcos(the_graph.angle));
					the_graph.positive_drawn_vertices[j]._xx = new_x;
					the_graph.positive_drawn_vertices[j]._yy = new_y;
				
				    before_x = the_graph.negative_drawn_vertices[j]._xx;
					before_y = the_graph.negative_drawn_vertices[j]._yy;
					unrot_x = (before_x) * dcos(-1 * the_graph.angle) - (before_y) * dsin(-1 * the_graph.angle);
					unrot_y = -1*64*evaluate(the_graph.func, (1/64)*unrot_x);
					new_y_before_rot = unrot_y * the_graph.range_stretch;
					new_x = (unrot_x) * dcos(the_graph.angle) - (new_y_before_rot * dsin(the_graph.angle));
					new_y = (unrot_x) * dsin(the_graph.angle) + (new_y_before_rot * dcos(the_graph.angle));
					the_graph.negative_drawn_vertices[j]._xx = new_x;
					the_graph.negative_drawn_vertices[j]._yy = new_y;
				}
			}
		}
		
			//WHEN DOMAIN CHANGES YOU NEED TO RECALCULATE THE WHOLE GRAPH
			if (!the_graph.done_drawing) {
				if (the_graph.heavy) {
					crazy = 5;
				} else {
					crazy = 3;	
				}
	
	
				
				for (var j = 0; j < crazy; j++) {
					if (the_graph.heavy) {
						
						var nearest_discontinuity = ((32 * pi) * the_graph.domain_stretch) + ((the_graph.disco_passed * 64 * pi) * the_graph.domain_stretch);
						if (the_graph.x_upper - nearest_discontinuity <= 0 && (the_graph.x_upper + the_graph.fidelity) - nearest_discontinuity > 0) {
							the_graph.x_upper = nearest_discontinuity - epsilon;
							var orig_x = the_graph.x_upper;
							var orig_y = 64*(-1)*evaluate(the_graph.func, ((1 / ((64 * the_graph.domain_stretch)))) * the_graph.x_upper);
							the_graph.positive_drawn_vertices[the_graph.index] = new tuple(orig_x * dcos(the_graph.angle) - orig_y * dsin(the_graph.angle), orig_x * dsin(the_graph.angle) + orig_y * dcos(the_graph.angle));
						
							orig_x = the_graph.x_upper * -1;
							orig_y = the_graph.range_stretch * 64*(-1)*evaluate(the_graph.func, ((-1 / ((64 * the_graph.domain_stretch)))) * the_graph.x_upper);
							the_graph.negative_drawn_vertices[the_graph.index] = new tuple(orig_x * dcos(the_graph.angle) - orig_y * dsin(the_graph.angle), orig_x * dsin(the_graph.angle) + orig_y * dcos(the_graph.angle));
						
						
							the_graph.bad_indices[the_graph.bad_indices_index++] = the_graph.index;
							the_graph.index++;
							the_graph.disco_passed++;
						
							the_graph.x_upper = nearest_discontinuity + epsilon;
							var orig_x = the_graph.x_upper;
							var orig_y = 64*(-1)*evaluate(the_graph.func, ((1 / ((64 * the_graph.domain_stretch)))) * the_graph.x_upper);
							the_graph.positive_drawn_vertices[the_graph.index] = new tuple(orig_x * dcos(the_graph.angle) - orig_y * dsin(the_graph.angle), orig_x * dsin(the_graph.angle) + orig_y * dcos(the_graph.angle));
						
							orig_x = the_graph.x_upper * -1;
							orig_y = the_graph.range_stretch * 64*(-1)*evaluate(the_graph.func, ((-1 / ((64 * the_graph.domain_stretch)))) * the_graph.x_upper);
							the_graph.negative_drawn_vertices[the_graph.index] = new tuple(orig_x * dcos(the_graph.angle) - orig_y * dsin(the_graph.angle), orig_x * dsin(the_graph.angle) + orig_y * dcos(the_graph.angle));
						
				
							the_graph.index++;
			
						
						} else {
							var orig_x = the_graph.x_upper;
							var orig_y = 64*(-1)*evaluate(the_graph.func, ((1 / ((64 * the_graph.domain_stretch)))) * the_graph.x_upper);
							the_graph.positive_drawn_vertices[the_graph.index] = new tuple(orig_x * dcos(the_graph.angle) - orig_y * dsin(the_graph.angle), orig_x * dsin(the_graph.angle) + orig_y * dcos(the_graph.angle));
						
							orig_x = the_graph.x_upper * -1;
							orig_y = the_graph.range_stretch * 64*(-1)*evaluate(the_graph.func, ((-1 / ((64 * the_graph.domain_stretch)))) * the_graph.x_upper);
							the_graph.negative_drawn_vertices[the_graph.index] = new tuple(orig_x * dcos(the_graph.angle) - orig_y * dsin(the_graph.angle), orig_x * dsin(the_graph.angle) + orig_y * dcos(the_graph.angle));
						
							the_graph.index++;
							the_graph.x_upper += the_graph.fidelity;
						}
					} else {
						var orig_x = the_graph.x_upper;
						var orig_y = the_graph.range_stretch*64*(-1)*evaluate(the_graph.func, ((1 / ((64 * the_graph.domain_stretch)))) * the_graph.x_upper);
						the_graph.positive_drawn_vertices[the_graph.index] = new tuple(orig_x * dcos(the_graph.angle) - orig_y * dsin(the_graph.angle), orig_x * dsin(the_graph.angle) + orig_y * dcos(the_graph.angle));
						
						orig_x = the_graph.x_upper * -1;
						orig_y = the_graph.range_stretch * 64*(-1)*evaluate(the_graph.func, ((-1 / ((64 * the_graph.domain_stretch)))) * the_graph.x_upper);
						the_graph.negative_drawn_vertices[the_graph.index] = new tuple(orig_x * dcos(the_graph.angle) - orig_y * dsin(the_graph.angle), orig_x * dsin(the_graph.angle) + orig_y * dcos(the_graph.angle));
						
						the_graph.index++;
						the_graph.x_upper += the_graph.fidelity;
					}
				}
			}
			the_graph.scaling_time--;
		}
		
	}
	
	for (var j = 0; j < array_length(the_graph.positive_drawn_vertices); j++) {
		var clamping_y = the_graph.positive_drawn_vertices[j]._yy;
		var clamping_x = the_graph.positive_drawn_vertices[j]._xx;
		var unrot_clamping_x = clamping_x * dcos(-1 * the_graph.angle) - clamping_y * dsin(-1 * the_graph.angle);
		var unrot_clamping_y = clamping_x * dsin(-1 * the_graph.angle) + clamping_y * dcos(-1 * the_graph.angle);
		unrot_clamping_x = clamp(unrot_clamping_x + the_graph.start_x, 0 - a_bit_out, room_width + a_bit_out) - the_graph.start_x;
		unrot_clamping_y = clamp(unrot_clamping_y + the_graph.start_y, 0 - a_bit_out, room_height + a_bit_out) - the_graph.start_y;
		var rot_clamping_x = unrot_clamping_x * dcos(the_graph.angle) - unrot_clamping_y * dsin(the_graph.angle);
		var rot_clamping_y = unrot_clamping_x * dsin(the_graph.angle) + unrot_clamping_y * dcos(the_graph.angle);
		the_graph.positive_drawn_vertices[j]._yy = rot_clamping_y;
		the_graph.positive_drawn_vertices[j]._xx = rot_clamping_x;
		
		
		clamping_y = the_graph.negative_drawn_vertices[j]._yy;
		clamping_x = the_graph.negative_drawn_vertices[j]._xx;
		unrot_clamping_x = clamping_x * dcos(-1 * the_graph.angle) - clamping_y * dsin(-1 * the_graph.angle);
		unrot_clamping_y = clamping_x * dsin(-1 * the_graph.angle) + clamping_y * dcos(-1 * the_graph.angle);
		unrot_clamping_x = clamp(unrot_clamping_x + the_graph.start_x, 0 - a_bit_out, room_width + a_bit_out) - the_graph.start_x;
		unrot_clamping_y = clamp(unrot_clamping_y + the_graph.start_y, 0 - a_bit_out, room_height + a_bit_out) - the_graph.start_y;
		rot_clamping_x = unrot_clamping_x * dcos(the_graph.angle) - unrot_clamping_y * dsin(the_graph.angle);
		rot_clamping_y = unrot_clamping_x * dsin(the_graph.angle) + unrot_clamping_y * dcos(the_graph.angle)
		the_graph.negative_drawn_vertices[j]._yy = rot_clamping_y
		the_graph.negative_drawn_vertices[j]._xx = rot_clamping_x;
	}
	
}



/* 

Infinite Discontinuity Attacks
Wave Class Attacks
Line Class Attacks

*/

//If theres a linear transformation to implement lighting inverse it on your point that you want to light up