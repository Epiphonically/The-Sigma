// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_wave_spawn(_x,_y, _bots, _rogue, _spawn_speed = 30, _spd=1, _path=1){
	
	var _spawner = instance_create_layer(0,0,"Globals",o_global_spawn_handler);
	
	_spawner.delta_to_spawn = _bots;
	_spawner.delta_to_spawn_rogue = _rogue;
	_spawner.spawn_speed = _spawn_speed;
	
	return _spawner;
}