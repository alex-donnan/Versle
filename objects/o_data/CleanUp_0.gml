/// @description delete grid

if (ds_exists(list_answer, ds_type_list)) {
	ds_list_destroy(list_answer);	
}

if (ds_exists(list_guess, ds_type_list)) {
	ds_list_destroy(list_guess);	
}

if (ds_exists(list_player_words, ds_type_list)) {
	ds_list_destroy(list_player_words);	
}

if (ds_exists(grid_letter, ds_type_grid)) {
	ds_grid_destroy(grid_letter);
}