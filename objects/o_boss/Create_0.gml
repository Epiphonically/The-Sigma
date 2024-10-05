spd = 15;
graph_scale = 1;
hpbar1 = 10000;
hpbar1_max = 10000;
hpbar2 = 100000;
hpbar2_max = 100000;
hpbar3 = 1000000;
hpbar3_max = 1000000;
phase = 0;
boss_graph = 0;
time_before_charge = 0;
point_on_dom = 0;
target_x = 0;
target_y = 0;
ticks = 100;
prev_x = 0;
prev_y = 0;
idle_time = 100;
num_dashes = 0;
next_attack = 0;

delta_count = 0;
time_between_spawns = 10;
ticker = 0;
degree_delta = 30;
num_made = 0;
radius_out = 100;
attack_chosen = false;
locked_angle = 0;

time_until_new_graph = 0;
timer_ticking = false;
//Lazer
//Dash
//Follow Graph
ds_list_clear(o_global_graph.graph_list);
generateEquation(phase);

started_charging_beam = false;
beam_charge = 0;
beam_juice = 0;
beam_current_length = 0;
beam_max_length = sqrt(power(room_width, 2) + power(room_height, 2)) / (sprite_get_height(s_blast));

idle_time_phase1 = 100;
idle_time_phase2 = 75;
idle_time_phase3 = 50;

beam_charge_time = 100;
juice_refill = 300;

hp_bar_max_length = 500;

graph_is_done = true;