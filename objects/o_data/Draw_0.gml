/// @description rotate counter

for (var yy = player_index - 3; yy < player_index + 3; ++yy) {
	for (var xx = 0; xx < 5; ++xx) {
		if (yy >= 0) {
			with (grid_letter[# xx, yy]) {
				draw_sprite_ext(sp_letter, 0, x_pos, y_pos, 1, 1, 0, c_white, alpha);
				draw_sprite_ext(sp_letter, sub_img, x_pos, y_pos, 1, y_scale, 0, c_white, alpha);
				draw_text_ext_color(x_pos + 16, y_pos, letter_value, 12, 12, c_white, c_white, c_white, c_white, alpha);
			}
		}
	}
}
/*
draw_text(8, 16, "Position " + string(player_position));
draw_text(8, 32, "Index " + string(player_index));
draw_text(8, 64, "Guessing " + string(player_guess));
*/