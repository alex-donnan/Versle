/// @description draw self, letter, and click fade

draw_sprite_ext(sprite_index, sub_img, x, y, 1, 1, 0, c_white, 1);
if (pressed) {
	draw_sprite_ext(sprite_index, 1, x, y, 1, 1, 0, c_white, 0.4);	
}
draw_set_colour(c_white);
draw_text_ext(x + (sprite_width / 2), y + (sprite_height / 2), letter, 12, 12);