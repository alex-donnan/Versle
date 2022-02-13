/// @description tiny letter updates

//Color animation
with (o_data) {
	if (player_index > 0 && grid_letter[# 4, player_index - 1].color_change) {
		for (var xx = 0; xx < 5; ++xx) {
			var temp_letter = grid_letter[# xx, player_index - 1];
			--temp_letter.y_scale_count;
			if (temp_letter.y_scale_count <= floor(room_speed / 2) && temp_letter.y_scale_count > 0) {
				temp_letter.y_scale = lerp(temp_letter.y_scale, 1, 1 / temp_letter.y_scale_count);
			} else if (temp_letter.y_scale = 1) {
				temp_letter.color_change = false;
				anim_delay = 20;
			}
		}
	}
}