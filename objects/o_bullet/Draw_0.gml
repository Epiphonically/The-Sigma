var use_me = 0;

if (dcos(angle) < 0) {
use_me = 180;
}
switch (operation) {
	case "+":
		draw_set_color(c_green);
	break;
	
	case "-":
		draw_set_color(c_red);
	break;
	
	case "\\":
		draw_set_color(c_purple);
	break;
	
	case "*":
		draw_set_color(c_yellow);
	break;
}
draw_text_transformed(x, y, string(value), 0.5, 0.5, angle + use_me);
draw_set_color(c_white);