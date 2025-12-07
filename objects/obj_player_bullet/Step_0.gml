/// @description bullet motion
if (obj_player.state == "dead") {
	instance_destroy();
} else {
	var totalWidth = obj_player_bullet.x + obj_player_bullet.sprite_width;
	var totalHeight = obj_player_bullet.y + obj_player_bullet.sprite_height;

	// totalWidth so the entire sprite moves offscreen first
	// height handled the same for edge case reasons
	if (totalWidth < 0 || obj_player_bullet.x > room_width || totalHeight < 0 || obj_player_bullet.y > room_height) {
		instance_destroy();
	};

	var enemyCollision = instance_place(x,y, obj_enemy);
	if (enemyCollision != noone) {
		if (enemyCollision.sprite_index != obj_enemy.spr_die) {
			obj_player.plr_score++;
			obj_player.difficulty++;
			enemyCollision.image_index = 0;
			enemyCollision.sprite_index = obj_enemy.spr_die;
			instance_destroy();
		};
	};
};