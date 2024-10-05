var start_x = display_get_gui_width() / 2;
var start_y = 64;

draw_set_valign(fa_middle);
draw_set_halign(fa_center);

switch (phase) {
	case 0:
		draw_sprite_ext(s_hp, 0, start_x- (hp_bar_max_length/2), start_y, clamp((hpbar1 / hpbar1_max), 0, 1) * hp_bar_max_length, 1, 0, c_green, 0.5);
		draw_text(start_x, start_y, string(hpbar1) + "/" + string(hpbar1_max));
	break;
	
	case 1:
		draw_sprite_ext(s_hp, 0, start_x- (hp_bar_max_length/2), start_y, clamp((hpbar2 / hpbar2_max), 0, 1) * hp_bar_max_length, 1, 0, c_orange, 0.5);
		draw_text(start_x, start_y, string(hpbar2) + "/" + string(hpbar2_max));
	break;
	
	case 2:
		draw_sprite_ext(s_hp, 0, start_x, start_y, clamp((hpbar3 / hpbar3_max), 0, 1) * hp_bar_max_length, 1, 0, c_red, 0.5);
		draw_text(start_x, start_y, string(hpbar3) + "/" + string(hpbar3_max));
	break;
}