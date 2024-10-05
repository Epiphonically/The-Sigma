delta_to_spawn_total = delta_to_spawn + delta_to_spawn_rogue;
if (o_boss.graph_is_done && global.tick % spawn_speed == 0 && delta_count_total < delta_to_spawn_total && !ds_list_empty(o_global_graph.graph_list)){
	
	var the_graph = o_global_graph.graph_list[| (index % ds_list_size(o_global_graph.graph_list))];
	var ran = choose(1,0,0,0,0,0,0);
	
	switch(ran){
		case 0:
			if (delta_count < delta_to_spawn){
				var _a = instance_create_layer(0,0,"Instances", projectile_testing);
				_a.xmove = -1;
				var _b = instance_create_layer(0,0,"Instances", projectile_testing);
				delta_count+=2;
				_a.my_graph = the_graph;
				_b.my_graph = the_graph;
				index++;
			}
		break;
		case 1:
			if (delta_count_rogue < delta_to_spawn_rogue){
				var _rogue = instance_create_layer(0,0,"Instances", projectile_testing);
				var _a = instance_create_layer(0,0,"Instances", projectile_testing);
				
				_rogue.alarm[0] = room_speed * random_range(1,60);
				_a.alarm[0] = room_speed * random_range(1,60);
				_a.xmove = -1;
				delta_count_rogue += 2;
				_a.my_graph = the_graph;
				_rogue.my_graph = the_graph;
				index++;
			}
		break;
	}
	
}

delta_count_total = delta_count + delta_count_rogue;

//show_debug_message("DELTA COUNT: " + string(delta_count));
//show_debug_message("DELTA ROGUE COUNT: " + string(delta_count_rogue));
//show_debug_message("TOTAL : " + string(delta_count_total));