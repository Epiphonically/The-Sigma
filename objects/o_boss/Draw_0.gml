draw_self();
if (boss_graph != 0) {
	for (var i = 0; i < array_length(boss_graph.positive_drawn_vertices) - 1; i++) {
		if (boss_graph.positive_drawn_vertices[i] != 0 && boss_graph.positive_drawn_vertices[i + 1] != 0) {
			
			var p1 = boss_graph.positive_drawn_vertices[i];
			var p2 = boss_graph.positive_drawn_vertices[i + 1];
			draw_set_color(c_white);
			draw_line_width(boss_graph.start_x + p1._xx, boss_graph.start_y + p1._yy, boss_graph.start_x + p2._xx, boss_graph.start_y + p2._yy, 8);
			
			if (i == array_length(boss_graph.positive_drawn_vertices) - 2) {
				draw_circle(boss_graph.start_x + p2._xx, boss_graph.start_y + p2._yy, 8, 0);
			}
		}
	}
}

if (beam_charge > 0) {
	draw_set_color(c_red);
	var x_pos = x + lengthdir_x(radius_out, image_angle - 90);
	var y_pos = y + lengthdir_y(radius_out, image_angle - 90);
	
	draw_sprite_ext(s_blast_charge, (round(beam_charge_time - beam_charge) / beam_charge_time) * (sprite_get_number(s_blast_charge) - 1), x_pos, y_pos, 2, 2, image_angle, c_red, 1);
}
if (beam_juice > 0) {
	draw_set_color(c_red);
	var x_pos = x + lengthdir_x(radius_out, image_angle - 90);
	var y_pos = y + lengthdir_y(radius_out, image_angle - 90);
	draw_sprite_ext(s_blast_charge, (sprite_get_number(s_blast_charge) - 1), x_pos, y_pos, 2, 2, image_angle, c_red, 1);
	draw_sprite_ext(s_blast, 0, x_pos, y_pos, 2, beam_current_length, image_angle, make_color_rgb(255,90,90), 1);
	
	
	
}
