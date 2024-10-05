randomize();
var cam_x = camera_get_view_x(view_camera[0]) - a_bit_out;
var cam_y = camera_get_view_y(view_camera[0]) - a_bit_out;
var camera_width = camera_get_view_width(view_camera[0]) + 2 * a_bit_out;
var camera_height = camera_get_view_height(view_camera[0]) + 2 * a_bit_out;
//show_debug_message(string(cam_x) + ", " + string(cam_y) + ", " + string(camera_width) + ", " + string(camera_height)); 
for (var i = 0; i < ds_list_size(reverting_graph_list); i++) {
	var the_graph = reverting_graph_list[| i];
	var drawn = 0;
	for (var j = 0; j < the_graph.index - 1; j++) {
		if (the_graph.heavy) {
			var should_draw = true;
			for (var k = 0; k < array_length(the_graph.bad_indices); k++) {
				if (the_graph.bad_indices[k] == j) {
					should_draw = false;	
				}
			}
			if (should_draw) {
				if (the_graph.positive_drawn_vertices[j] != 0) {
					var p1 = the_graph.positive_drawn_vertices[j];
					var p2 = the_graph.positive_drawn_vertices[j + 1];
					
				
					if (line_in_rectangle(
					the_graph.start_x + p1._xx, 
					the_graph.start_y + p1._yy, 
					the_graph.start_x + p2._xx, 
					the_graph.start_y + p2._yy,
					cam_x,
					cam_y,
					cam_x + camera_width,
					cam_y + camera_height)) {
						draw_set_alpha(0.6);
						draw_set_color(c_red);
						draw_line_width(the_graph.start_x + p1._xx, the_graph.start_y + p1._yy, the_graph.start_x + p2._xx, the_graph.start_y + p2._yy, 8);
						draw_set_color(c_white);
						draw_set_alpha(1);
					}
						p1 = the_graph.negative_drawn_vertices[j];
						p2 = the_graph.negative_drawn_vertices[j + 1];
					if (line_in_rectangle(
					the_graph.start_x + p1._xx, 
					the_graph.start_y + p1._yy, 
					the_graph.start_x + p2._xx, 
					the_graph.start_y + p2._yy,
					cam_x,
					cam_y,
					cam_x + camera_width,
					cam_y + camera_height)) {
						draw_set_color(c_red);
						draw_line_width(the_graph.start_x + p1._xx, the_graph.start_y + p1._yy, the_graph.start_x + p2._xx, the_graph.start_y + p2._yy, 8);
						draw_set_color(c_white);
						draw_set_alpha(1);
						
					}
					drawn++;
				}
			}
		} else {
			if (the_graph.positive_drawn_vertices[j] != 0) {
				var p1 = the_graph.positive_drawn_vertices[j];
				var p2 = the_graph.positive_drawn_vertices[j + 1];
				if (line_in_rectangle(
					the_graph.start_x + p1._xx, 
					the_graph.start_y + p1._yy, 
					the_graph.start_x + p2._xx, 
					the_graph.start_y + p2._yy,
					cam_x,
					cam_y,
					cam_x + camera_width,
					cam_y + camera_height)) {
					draw_set_alpha(0.6);
					draw_set_color(c_red);
					draw_line_width(the_graph.start_x + p1._xx, the_graph.start_y + p1._yy, the_graph.start_x + p2._xx, the_graph.start_y + p2._yy, 8);
					draw_set_color(c_white);
					draw_set_alpha(1);
				}
					p1 = the_graph.negative_drawn_vertices[j];
					p2 = the_graph.negative_drawn_vertices[j + 1];
				if (line_in_rectangle(
					the_graph.start_x + p1._xx, 
					the_graph.start_y + p1._yy, 
					the_graph.start_x + p2._xx, 
					the_graph.start_y + p2._yy,
					cam_x,
					cam_y,
					cam_x + camera_width,
					cam_y + camera_height)) {
					draw_set_color(c_red);
					draw_line_width(the_graph.start_x + p1._xx, the_graph.start_y + p1._yy, the_graph.start_x + p2._xx, the_graph.start_y + p2._yy, 8);
					draw_set_color(c_white);
					draw_set_alpha(1);
					
				}
				drawn++;
			}
		}
	}
	if (drawn == 0) {
		ds_list_delete(reverting_graph_list, i);
		
		i--;
	}
}

for (var i = 0; i < ds_list_size(graph_list); i++) {
	var the_graph = graph_list[| i];
	for (var j = 0; j < the_graph.index - 1; j++) {
		if (the_graph.heavy) {
			var should_draw = true;
			for (var k = 0; k < array_length(the_graph.bad_indices); k++) {
				if (the_graph.bad_indices[k] == j) {
					should_draw = false;	
				}
			}
			if (should_draw) {
				
				var p1 = the_graph.positive_drawn_vertices[j];
				var p2 = the_graph.positive_drawn_vertices[j + 1];
				
				if (line_in_rectangle(
					the_graph.start_x + p1._xx, 
					the_graph.start_y + p1._yy, 
					the_graph.start_x + p2._xx, 
					the_graph.start_y + p2._yy,
					cam_x,
					cam_y,
					cam_x + camera_width,
					cam_y + camera_height)) {
					if (the_graph.done_drawing) {
						draw_set_color(c_red);
					}
					draw_line_width(the_graph.start_x + p1._xx, the_graph.start_y + p1._yy, the_graph.start_x + p2._xx, the_graph.start_y + p2._yy, 8);
					draw_set_color(c_white);
				}
					p1 = the_graph.negative_drawn_vertices[j];
					p2 = the_graph.negative_drawn_vertices[j + 1];
				if (line_in_rectangle(
					the_graph.start_x + p1._xx, 
					the_graph.start_y + p1._yy, 
					the_graph.start_x + p2._xx, 
					the_graph.start_y + p2._yy,
					cam_x,
					cam_y,
					cam_x + camera_width,
					cam_y + camera_height)) {
					if (the_graph.done_drawing) {
						draw_set_color(c_red);
					}
					draw_line_width(the_graph.start_x + p1._xx, the_graph.start_y + p1._yy, the_graph.start_x + p2._xx, the_graph.start_y + p2._yy, 8);
					draw_set_color(c_white);
				}
			}
		} else {
			var p1 = the_graph.positive_drawn_vertices[j];
			var p2 = the_graph.positive_drawn_vertices[j + 1];

			if (line_in_rectangle(
					the_graph.start_x + p1._xx, 
					the_graph.start_y + p1._yy, 
					the_graph.start_x + p2._xx, 
					the_graph.start_y + p2._yy,
					cam_x,
					cam_y,
					cam_x + camera_width,
					cam_y + camera_height)) {
				if (the_graph.done_drawing) {
					draw_set_color(c_red);
				}
				draw_line_width(the_graph.start_x + p1._xx, the_graph.start_y + p1._yy, the_graph.start_x + p2._xx, the_graph.start_y + p2._yy, 8);
				draw_set_color(c_white);	
			}
				p1 = the_graph.negative_drawn_vertices[j];
				p2 = the_graph.negative_drawn_vertices[j + 1];
				
			if (line_in_rectangle(
					the_graph.start_x + p1._xx, 
					the_graph.start_y + p1._yy, 
					the_graph.start_x + p2._xx, 
					the_graph.start_y + p2._yy,
					cam_x,
					cam_y,
					cam_x + camera_width,
					cam_y + camera_height)) {	
				if (the_graph.done_drawing) {
					draw_set_color(c_red);
				}
				draw_line_width(the_graph.start_x + p1._xx, the_graph.start_y + p1._yy, the_graph.start_x + p2._xx, the_graph.start_y + p2._yy, 8);
				draw_set_color(c_white);	
			}
		}
	}
	
}