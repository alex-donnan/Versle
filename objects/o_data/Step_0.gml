/// @description update positions if index does not match height

randomize();

//Default delay counter
if (anim_delay != 0) {
	--anim_delay;	
}

//Position animation
if (player_index > 0 && grid_letter[# 4, player_index - 1].color_change == false && anim_delay == 0 && grid_letter[# 0, player_index].y_pos != y) {
	for (var yy = player_index - 3; yy < ds_grid_height(grid_letter); ++yy) {
		for (var xx = 0; xx < 5; ++xx) {
			if (yy >= 0) {
				var temp_letter = grid_letter[# xx, yy];
				temp_letter.y_pos = lerp(temp_letter.y_pos, y + (temp_letter.index - player_index) * 69, 0.3);
				//Alpha
				if (temp_letter.y_pos < y && temp_letter.y_pos < y - 138) {
					temp_letter.alpha = 1 - (abs(temp_letter.y_pos - y) / 207);
				} else if (temp_letter.y_pos > y && temp_letter.y_pos - y < 60) {
					temp_letter.alpha = 1 - (abs(temp_letter.y_pos - y) / 60);					
				} else if (temp_letter.y_pos <= y) {
					temp_letter.alpha = 1;
				} else {
					temp_letter.alpha = 0;
				}
			}
		}
	}
}

//Color animation
if (player_index > 0 && grid_letter[# 4, player_index - 1].color_change) {
	for (var xx = 0; xx < 5; ++xx) {
		var temp_letter = grid_letter[# xx, player_index - 1];
		--temp_letter.y_scale_count;
		if (temp_letter.y_scale_count <= floor(room_speed / 2) && temp_letter.y_scale_count > 0) {
			temp_letter.y_scale = lerp(temp_letter.y_scale, 1, 1 / temp_letter.y_scale_count);
		} else if (temp_letter.y_scale = 1) {
			temp_letter.color_change = false;
			if (temp_letter.position == 4) {
				anim_delay = 10;	
			}
		}
	}
}