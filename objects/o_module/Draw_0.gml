draw_set_font(global.font);
if (value == "inf") {
	color_shift += 5;
	color_shift = color_shift mod 255;
}
switch(value) {
	case "inf":
		draw_sprite_ext(s_fn_font_extras, 0, x, y, 0.5, 0.5, image_angle, make_color_hsv(0+color_shift,255,255), 1);
	break;
	
	case "-":
		draw_sprite_ext(s_fn_font_extras, 1, x, y, 0.5, 0.5, image_angle, c_red, 1);
	break;
	
	case "\\":
		draw_sprite_ext(s_fn_font_extras, 2, x, y, 0.5, 0.5, image_angle, c_purple, 1);
	break;
	
	case "+":
		draw_sprite_ext(s_fn_font, sprite_get_number(s_fn_font)-1, x, y, 1, 1, image_angle, c_green, 1);
	break;
	
	case "*":
		draw_sprite_ext(s_fn_font_extras, 3, x, y, 0.5, 0.5, image_angle, c_yellow, 1);
	break;
	
	default:
	
		draw_text_transformed(x,y,string(value),0.5,0.5,image_angle);


}
