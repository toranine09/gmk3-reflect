/// @description bullet motion
if (obj_player.state == "dead") {
	instance_destroy();
} else {
	var totalWidth = obj_enemy_bullet.x + obj_enemy_bullet.sprite_width;
	var totalHeight = obj_enemy_bullet.y + obj_enemy_bullet.sprite_height;

	// totalWidth so the entire sprite moves offscreen first
	// height handled the same for edge case reasons
	if (totalWidth < 0 || obj_enemy_bullet.x > room_width || totalHeight < 0 || obj_enemy_bullet.y > room_height) {
		instance_destroy();
	};

	var playerCollision = instance_place(x,y, obj_player);
	if (playerCollision != noone) {
		obj_player.plr_health--;
		if (obj_player.plr_health > 0) {
			obj_player.state = "hurt";
		};
		instance_destroy();
	};
};