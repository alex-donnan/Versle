/// @description update positions if index does not match height

//Time out!
if (player_timer == 0) {
	
	//deactivate buttons
	with (o_button) {
		active = false;	
	}
	//Time out notification
	ds_list_add(list_notify, new notification(notify_type.scroll_down, "Timed out!", notify_speed.slow, 202, 180));
	anim_delay = 30;
	//Update the letters
	for (var xx = 0; xx < 5; ++xx) {
		var temp_letter = grid_letter[# xx, player_index]
		temp_letter.sub_img = 1;
		temp_letter.color_change = true;
		temp_letter.y_scale_count += xx * 5;
	}
	create_letters();
	player_guess = "";
	player_position = 0;
	player_index++;
	
	//At this point the wait for network command needs to be sent out
	
	//Reactivate buttons
	with (o_button) {
		active = true;	
	}
	//if last guess, send to new word
	if (player_index == player_word_index + 6) {
		reset_word();
		with (list_notify[| ds_list_size(list_notify) - 1]) {
			note_text = "Timed out and out of guesses!"
		}
		player_word_index = player_index;
	}
	
	//Reset Timer
	reset_timer(30);
}

//Default delay counter
if (anim_delay != 0) {
	--anim_delay;	
}

//decrease timer and move forward!
if (player_timer != 0) {
	if (anim_delay == 0) {
		if (player_index > 0 && grid_letter[# 4, player_index - 1].color_change == false) {
			--player_timer;
		} else if (player_index == 0) {
			--player_timer;	
		}
	}
	//Position animation
	if (player_index > 0 && grid_letter[# 4, player_index - 1].color_change == false && anim_delay == 0 && grid_letter[# 0, player_index].y_pos != y) {
		for (var yy = player_index - 4; yy < player_index + 2; ++yy) {
			if (yy >= 0) {
				for (var xx = 0; xx < 5; ++xx) {
					var temp_letter = grid_letter[# xx, yy];
					temp_letter.y_pos = (yy >= player_word_index) ? lerp(temp_letter.y_pos, y + (temp_letter.index - player_index) * 69, 0.3) : lerp(temp_letter.y_pos, y + 345, 0.3);
					//Alpha
					if (temp_letter.y_pos < y && temp_letter.y_pos < y - 207) {
						temp_letter.alpha = 1 - (abs(temp_letter.y_pos - y - 138) / 138);
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
				anim_delay = 20;
			}
		}
	}
}

//Notifications
for (var xx = 0; xx < ds_list_size(list_notify); ++xx) {
	var temp_notify = list_notify[| xx];
	with (temp_notify) {
		if (note_speed > 0) {
			var dif = (note_type == 0) ? (2 * pi) - (pi / 2) : note_type - (pi / 2);
			if (abs(note_dir - dif) > 0.1) {
				note_dir = (note_dir + (pi / 20)) % (pi * 2);
				if (note_type % pi == 0) {
					draw_x = note_x + (24 * cos(note_dir));
				} else {
					draw_y = note_y + (24 * sin(note_dir));
				}
				alpha = 1 - (abs(point_distance(draw_x, draw_y, note_x, note_y)) / 24);
			} else {
				--note_speed;
			}
		} else if (note_speed == 0) {		
			if (abs(note_dir - note_type) > 0.1) {
				note_dir = (note_dir + (pi / 20)) % (pi * 2);
				if (note_type % pi == 0) {
					draw_x = note_x + (24 * cos(note_dir));
				} else {
					draw_y = note_y + (24 * sin(note_dir));
				}
				alpha = 1 - (point_distance(draw_x, draw_y, note_x, note_y) / 24);
			}
		}
	}
	//destroy if at end
	if (temp_notify.note_speed == 0 && temp_notify.alpha == 0) {
		ds_list_delete(list_notify, xx);	
	}
}