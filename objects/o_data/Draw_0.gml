/// @description rotate counter

//Divider
draw_sprite_ext(sp_divider, 1, 0, 229, 1, 1, 0, c_white, 1);
if (player_timer > 0) {
	draw_rectangle_color(max(9, 395 - 391 * (player_timer / (room_speed * 30.9))), 226, 395, 231, present_color, present_color, present_color, present_color, false);
}
draw_sprite_ext(sp_divider, 0, 0, 229, 1, 1, 0, c_white, 1);

//Letters
for (var yy = player_index - 4; yy < player_index + 1; ++yy) {
	if (yy >= 0) {
		for (var xx = 0; xx < 5; ++xx) {
			with (grid_letter[# xx, yy]) {
				draw_sprite_ext(sp_letter, 0, x_pos, y_pos, 1, 1, 0, c_white, alpha);
				draw_sprite_ext(sp_letter, sub_img, x_pos, y_pos, 1, y_scale, 0, c_white, alpha);
				draw_text_ext_color(x_pos + 32, y_pos, letter_value, 12, 12, c_white, c_white, c_white, c_white, alpha);
			}
		}
	}
}

//Any notifications
for (var xx = 0; xx < ds_list_size(list_notify); ++xx) {
	with (list_notify[| xx]) {
		draw_text_ext_colour(draw_x, draw_y, note_text, 12, string_length(note_text) * 12, c_white, c_white, c_white, c_white, alpha);
	}
}

if (debug) {
	draw_set_halign(fa_left);
	draw_text(32, 16, "Position " + string(player_position));
	draw_text(32, 32, "Index " + string(player_index));
	draw_text(32, 64, "Guessing " + string(player_guess));
	draw_text(32, 48, "Word is " + string(player_word));
	draw_set_halign(fa_center);
}