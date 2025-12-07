/// @description reflect effect
draw_self();
	
if (reflect_fx_timer > 0) {
	var fx_progress = 1 - (reflect_fx_timer / 60);
	var radius = lerp(0, 384, fx_progress);
	var angle_count = 9;
	
	draw_set_color($E0E0E0);
	draw_set_alpha(1 - fx_progress);

	for (var i = 0; i < angle_count; i++) {
		var ang = i * (360 / angle_count);
		var x1 = x + 64 + lengthdir_x(radius, ang);
		var y1 = y + 128 + lengthdir_y(radius, ang);
		var x2 = x + 64 + lengthdir_x(radius * 0.5, ang);
		var y2 = y + 128 + lengthdir_y(radius * 0.5, ang);
		draw_line_width(x1, y1, x2, y2, 9);
	};

	draw_set_alpha(1);
};