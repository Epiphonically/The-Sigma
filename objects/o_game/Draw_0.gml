draw_sprite_stretched_ext(Sprite1,0,0,0,room_width,room_height,c_white,0.1);

///Draw X AXIS
draw_sprite_stretched_ext(Sprite1_1,0,0,origin[1],room_width,64,c_white,1);

draw_set_font(global.font);

for (var i = 0; i < 64; i++){
	draw_set_valign(fa_middle);
	draw_set_halign(fa_center);
	if (i != 32) draw_text_transformed_color((64 * i), origin[1] + 32, (i-32),0.3,0.3,0,c_white,c_white,c_white,c_white,0.75);
}

///DRAW Y AXIS
draw_sprite_stretched_ext(Sprite1_2,0,origin[0],0,64,room_height,c_white,1);