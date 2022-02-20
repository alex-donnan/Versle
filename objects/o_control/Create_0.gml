/// @description game controller

randomize();
draw_set_halign(fa_center);
draw_set_valign(fa_center);

#macro NULL -1
#macro LEFT_CLICK device_mouse_check_button(0, mb_left)
#macro LEFT_RELEASE device_mouse_check_button_released(0, mb_left)
#macro MOUSE_X device_mouse_x(0)
#macro MOUSE_Y device_mouse_y(0)

//Init other objects!
instance_create_depth(30, 498, 0, o_data);

//Networking functions (sendout)
function server_connect() {
	//do nothing
}