/// @description Check if click and change color

pressed = (LEFT_CLICK && collision_point(MOUSE_X, MOUSE_Y, self, 1, false)) ? true : false;
if (LEFT_RELEASE && collision_point(MOUSE_X, MOUSE_Y, self, 1, false)) {
	with (o_data) {
		if (other.letter == "Enter") {
			check_guess();
		} else if (other.letter == "Back") {
			remove_letter();
		} else {
			add_letter(other.letter);	
		}
	}
}