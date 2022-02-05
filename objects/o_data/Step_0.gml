/// @description update positions if index does not match height

if (grid_letter[# 0, player_index].y_pos != y) {
	for (var yy = player_index - 2; yy < ds_grid_height(grid_letter); ++yy) {
		for (var xx = 0; xx < 5; ++xx) {
			if (yy >= 0) {
				var temp_letter = grid_letter[# xx, yy];
				temp_letter.y_pos = lerp(temp_letter.y_pos, y + (temp_letter.index - player_index) * 69, 0.3);
				//Alpha
				if (temp_letter.y_pos < y && temp_letter.y_pos - y > -240) {
					temp_letter.alpha = 1 - (abs(temp_letter.y_pos - y) / 240);
				} else if (temp_letter.y_pos > y && temp_letter.y_pos - y < 60) {
					temp_letter.alpha = 1 - (abs(temp_letter.y_pos - y) / 60);					
				} else if (temp_letter.y_pos == y) {
					temp_letter.alpha = 1;
				} else {
					temp_letter.alpha = 0;
				}
			}
		}
	}
}