global.tick++;

global.tick = global.tick % 18000;

if (global.audio_stopper = true){
	audio_timer--;
}

if (audio_timer <= 0){
	global.audio_stopper = false;
	audio_timer = 10;
}

if (keyboard_check_pressed(vk_f3)){
	
	switch(window_get_fullscreen()){
		case true: window_set_fullscreen(false); break;
		case false: window_set_fullscreen(true); break;
	}
}

if (!audio_is_playing(song)){
	audio_play_sound(song,0,true);
}