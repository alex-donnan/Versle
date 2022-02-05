/// @description Letter object
//Lists
list_answer = ds_list_create();
list_guess = ds_list_create();
list_player_words = ds_list_create();
//Map of letters
grid_letter = ds_grid_create(5, 6);
map_keyboard = ds_map_create();

//Vars
player_word = "";
player_guess = "";
player_index = 0;
player_position = 0;
anim_delay = 0;

//Import answers and guesses
var file_answer = file_text_open_read(working_directory + "answers.txt");
var file_guess = file_text_open_read(working_directory + "allowed_guess.txt");

while (file_answer != 0 && !file_text_eof(file_answer)) {
	var line_text = file_text_read_string(file_answer);
	ds_list_add(list_answer, line_text);
	ds_list_add(list_guess, line_text);
	file_text_readln(file_answer);
}
while (file_guess != 0 && !file_text_eof(file_guess)) {
	ds_list_add(list_guess, file_text_read_string(file_guess));
	file_text_readln(file_guess);
}

file_text_close(file_answer);
file_text_close(file_guess);

//Letter struct
function letter(_pos, _ind) constructor {
	//Placement in map
	position = _pos;
	index = _ind;
	
	//Letter information
	enum check_value {
		missing = 1,
		present = 2,
		correct = 3
	}
	letter_value = "";
	
	//Animation
	sub_img = 1;
	x_pos = 30 + (69 * _pos);
	y_pos = o_data.y + (69 * _ind);
	y_scale = 0;
	y_scale_count = floor(room_speed / 2);
	//alpha
	alpha = (y_pos == o_data.y) ? 1 : 0;
}

//Populate letter map
for (var yy = 0; yy < 6; ++yy) {
	for (var xx = 0; xx < 5; ++xx) {
		grid_letter[# xx, yy] = new letter(xx, yy);
	}
}

//Set new word
function check_guess() {
	if (player_position == 5) {
		var test = ds_list_find_index(list_guess, string_lower(player_guess));
		show_debug_message(test);
		if (string_lower(player_guess) == player_word) {
			show_debug_message("Correct! Time to reset.");
			//Color letters
			for (var xx = 0; xx < 5; ++xx) {
				var temp_letter = grid_letter[# xx, player_index];
				temp_letter.sub_img = check_value.correct;
				temp_letter.color_change = true;
				temp_letter.y_scale_count += xx * 5;
			}
			//Update the letters
			ds_list_add(list_player_words, player_guess);
			reset_word();
			create_letters();
			player_guess = "";
			player_position = 0;
			player_index++;
			//Reset keyboard
			with (o_button) {
				sub_img = 0;
			}
		} else if (ds_list_find_index(list_guess, string_lower(player_guess)) != NULL) {
			show_debug_message("Good guess but no.");
			//Color letters
			for (var xx = 0; xx < 5; ++xx) {
				var temp_letter = grid_letter[# xx, player_index];
				if (string_pos(string_lower(temp_letter.letter_value), player_word) == xx + 1) {
					temp_letter.sub_img = check_value.correct;
				} else if (string_pos(string_lower(temp_letter.letter_value), player_word) > 0 && string_count(string_lower(temp_letter.letter_value), player_word) == string_count(temp_letter.letter_value, player_guess)) {
					temp_letter.sub_img = check_value.present;
				} else {
					temp_letter.sub_img = check_value.missing;	
				}
				temp_letter.color_change = true;
				temp_letter.y_scale_count += xx * 5;
				with(map_keyboard[? temp_letter.letter_value]) {
					if (sub_img < temp_letter.sub_img) {
						sub_img = temp_letter.sub_img;	
					}
				}
			}
			//Update the letters
			create_letters();
			player_guess = "";
			player_position = 0;
			player_index++;
		} else {
			show_debug_message("Nothing to see here.");
		}
	}
}

function remove_letter() {
	player_guess = string_copy(player_guess, 0, string_length(player_guess) - 1);
	if (player_position > 0) {
		player_position--;
		grid_letter[# player_position, player_index].letter_value = "";
	}
	
}

function add_letter(_letter) {
	if (player_position < 5 && grid_letter[# player_position, player_index].letter_value == "") {
		player_guess += _letter;
		grid_letter[# player_position, player_index].letter_value = _letter;
		player_position++;
	}
}

function reset_word() {
	var next_word = ds_list_find_value(list_answer, irandom(ds_list_size(list_answer)));
	while (ds_list_find_index(list_player_words, next_word) != NULL) {
		next_word = ds_list_find_value(list_answer, irandom(ds_list_size(list_answer)));
	}
	player_word = next_word;
}

//Update grid
function create_letters() {
	var next_yy = ds_grid_height(grid_letter);
	ds_grid_resize(grid_letter, 5, next_yy + 1);
	for (var xx = 0; xx < 5; ++xx) {
		grid_letter[# xx, next_yy] = new letter(xx, next_yy);
	}
}

//SET THE WORD
reset_word();