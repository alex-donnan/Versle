/// @description tiny letter updates

//Color animation for this player
if (player == 0) {
	with (o_data) {
		if (player_index > 0) {
			if (grid_letter[# 4, player_index - 1].color_change) {
				for (var xx = 0; xx < 5; ++xx) {
					var temp_letter = grid_letter[# xx, player_index - 1];
					if (other.position == xx && other.index == player_index - 1) {
						other.sub_img = temp_letter.sub_img - 1;
						other.y_scale = temp_letter.y_scale;
					}
				}
			}
		
			if (anim_delay == 0 && player_index == player_word_index && grid_letter[# 4, player_index - 1].color_change == false) {
				other.y_scale = lerp(other.y_scale, 0, 0.2);
			}
		}
	}
}