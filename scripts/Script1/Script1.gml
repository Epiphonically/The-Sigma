function line_in_rectangle(p1x, p1y, p2x, p2y, rec_left, rec_top, rec_right, rec_bot) {
	var min_x = min(p1x, p2x);
	var max_x = max(p1x, p2x);
	var min_y = min(p1y, p2y);
	var max_y = max(p1y, p2y);
	if (min_x > rec_right || max_x < rec_left || min_y > rec_bot || max_y < rec_top) {
		
		return false;	
		
	}
	return true;
}


function graph (_func, _angle, _start_x, _start_y, _istan, _time_before_drawn) constructor {
	bad_indices = array_create(0, 0);
	bad_indices_index = 0;
	disco_passed = 0;
	time_before_drawn = _time_before_drawn;
	domain_stretch = 1;
	domain_stretch_target = 1;
	range_stretch = 1;
	range_stretch_target = 1;
	positive_drawn_vertices = array_create(0,0);
	negative_drawn_vertices = array_create(0, 0);
	index = 0;
	x_upper = 0;
	func = _func;
	start_x = _start_x;
	start_y = _start_y;
	angle = _angle;
	heavy = _istan;
	done_drawing = false;
	fidelity = 5;
	crazy = 3;
	scaling_time = 200;
	
}

function tuple(_x, _y) constructor {
	_xx = _x;
	_yy = _y;
}

function token(_tok, _a, _b) constructor {
	tok = _tok;
	a = _a;
	b = _b;
}

enum TOKENS {
	ADD,
	SUB,
	MULT,
	DIV,
	COMPOSE,
	IDENTITY,
	SIN,
	COS,
	TAN,
	CONSTANT
}


function func_to_string(expr) {
	switch (expr.tok) {
		case TOKENS.ADD:
			return(func_to_string(expr.a) + " + " + func_to_string(expr.b));
		break;
		
		case TOKENS.SUB:
			return(func_to_string(expr.a) + " - " + func_to_string(expr.b));
		break;
		
		case TOKENS.MULT:
			return(func_to_string(expr.a) + " * " + func_to_string(expr.b));
		break;
		
		case TOKENS.DIV:
			return(func_to_string(expr.a) + " / " + func_to_string(expr.b));
		break;
		
		case TOKENS.COMPOSE: //Make Compose dictate (x)
			return(func_to_string(expr.a) + " + " + func_to_string(expr.b));
		break;
		
		case TOKENS.IDENTITY:
			return "x";
		break;
		
		case TOKENS.SIN:
			return "sin";
		break;
		
		case TOKENS.COS:
			return "cos";
		break;
		
		case TOKENS.TAN:
			return "tan";
		break;
		
		case TOKENS.CONSTANT:
			return string(tok.a);
		break;
	}
}

function evaluate(expr, _x) {
	var output = 0;
	switch (expr.tok) {
		case TOKENS.ADD:
			output = (evaluate(expr.a, _x) + evaluate(expr.b, _x));
		break;
		
		case TOKENS.SUB:
			output = (evaluate(expr.a, _x) - evaluate(expr.b, _x));
		break;
		
		case TOKENS.MULT:
			output = (evaluate(expr.a, _x) * evaluate(expr.b, _x));
		break;
		
		case TOKENS.DIV:
			output = (evaluate(expr.a, _x) / evaluate(expr.b, _x));
		break;
		
		case TOKENS.COMPOSE:
			output = (evaluate(expr.a, (evaluate(expr.b, _x))));
		break;
		
		case TOKENS.IDENTITY:
			output = (_x);
		break;
		
		case TOKENS.SIN:
			output = (sin(_x));
		break;
		
		case TOKENS.COS:
			output = (cos(_x));
		break;
		
		case TOKENS.TAN:
			output = (tan(_x));
		break;
		
		case TOKENS.CONSTANT:
			output = (expr.a);
		break;
	}
	output = clamp(output, -1 * room_height, room_height) {
		return output;	
	}
}

function generateEquation(difficulty) {
	switch(difficulty) {
		case 0:	//Make One Function
			var current_function = new token(choose(
			TOKENS.SIN, 
			TOKENS.COS, 
			TOKENS.CONSTANT, 
			), 
			random_range(0, 0), 0);
			
		
			var candidate = current_function;
			var num_to_send = choose(1, 3);
			var dir_to_player = -1 * point_direction(room_width / 2, room_height / 2, o_player.x, o_player.y);
		
			if (num_to_send == 1) {
				
				var the_graph = new graph(candidate, dir_to_player, room_width / 2, room_height / 2, false,0);
				ds_list_add(o_global_graph.graph_list, the_graph);	
			} else {
				var the_graph = new graph(candidate, dir_to_player - 45, room_width / 2, room_height / 2, false, 0);
				ds_list_add(o_global_graph.graph_list, the_graph);	
				the_graph = new graph(candidate, dir_to_player, room_width / 2, room_height / 2, false, 20);
				ds_list_add(o_global_graph.graph_list, the_graph);	
				the_graph = new graph(candidate, dir_to_player + 45, room_width / 2, room_height / 2, false, 40);
				ds_list_add(o_global_graph.graph_list, the_graph);	
				
			}
			
		break;
		
		case 1: //Make Two Functions
			
			var current_function = new token(TOKENS.TAN, 0, 0);
			var secondary = choose(TOKENS.SIN, TOKENS.CONSTANT, TOKENS.IDENTITY);
			var candidate = new token(TOKENS.MULT, current_function, new token(secondary, irandom_range(1, 5), 0));
			var the_graph =  new graph(candidate, irandom(360), room_width / 2, room_height / 2, true, 0);
			ds_list_add(o_global_graph.graph_list, the_graph);	
		break;
		
		case 2: //Make Three Functions
			var current_function = new token(choose(
			TOKENS.SIN, 
			TOKENS.COS, 
			TOKENS.CONSTANT, 
			), 
			random_range(0, 0), 0);
			var num_to_send = choose(2, 3, 4);
			if (current_function.tok != TOKENS.CONSTANT) {
				current_function = new token(TOKENS.MULT, current_function, new token(TOKENS.CONSTANT, random_range(1,2), 0));
				
			}
			var dir_to_player = -1 * point_direction(room_width / 2, room_height / 2, o_player.x, o_player.y);
			var mid_point = floor(num_to_send / 2);
			for (var i = 0; i < num_to_send; i++) {
				var angle = dir_to_player + (i - mid_point) * 20;
				var time = i * 20;
				var the_graph = new graph(current_function, angle, room_width / 2, room_height / 2, false, time);
				ds_list_add(o_global_graph.graph_list, the_graph);	
			}
			current_function = new token(TOKENS.TAN, 0, 0);
			var secondary = choose(TOKENS.SIN, TOKENS.CONSTANT, TOKENS.IDENTITY);
			var candidate = new token(TOKENS.MULT, current_function, new token(secondary, irandom_range(1, 5), 0));
			var the_graph =  new graph(candidate, 0, room_width / 2, room_height / 2, true, 0);
			ds_list_add(o_global_graph.graph_list, the_graph);	
			
		break;
	}
}