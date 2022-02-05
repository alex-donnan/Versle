/// @description Check if click and change color

pressed = ((LEFT_CLICK && collision_point(MOUSE_X, MOUSE_Y, self, 1, false)) || (keyboard_check(ord(string_upper(letter))) && utility == 0)) ? true : false;
if ((LEFT_RELEASE && collision_point(MOUSE_X, MOUSE_Y, self, 1, false))
	|| (utility == 0 && keyboard_check_released(ord(string_upper(letter))))
	|| (utility == 1 && keyboard_check_released(vk_backspace) && letter == "Back")
	|| (utility == 1 && keyboard_check_released(vk_enter) && letter == "Enter")) {
	with (o_data) {
		if (other.letter == "Back" || keyboard_check_released(vk_backspace)) {
			remove_letter();
		} else if (other.letter == "Enter" || keyboard_check_released(vk_enter)) {
			check_guess();
		} else {
			if (is_undefined(map_keyboard[? other.letter])) {
				map_keyboard[? other.letter] = other;
			}
			add_letter(other.letter);
		}
	}
}