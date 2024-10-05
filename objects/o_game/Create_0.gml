randomize();

global.tick = 0;
global.audio_stopper = false;
audio_timer = 10;

origin = [room_width / 2,room_height / 2];

display_set_gui_size(1920,1080);



font_map = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789.,;:$#'!\"/?%&()@=-+";
global.font = font_add_sprite_ext(s_fn_font,font_map,false,-18);

if (!audio_group_is_loaded(ag_sfx)){
	audio_group_load(ag_sfx);
}
if (!audio_group_is_loaded(ag_music)){
	audio_group_load(ag_music);
}


