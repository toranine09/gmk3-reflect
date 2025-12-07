/// @description on click, start game

if	(mouse_check_button_pressed(mb_left) && position_meeting(mouse_x, mouse_y, id)) {
    room_goto(1);
};