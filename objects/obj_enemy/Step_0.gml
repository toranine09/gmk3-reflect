/// @description movement and attack logic

if (obj_player.state == "alive") {
	if (sprite_index == spr_die) {
		if (!audio_is_playing(snd_die) && !playedDead) {
			snd_die = audio_play_sound(aud_enemy_die, 1, false);
			playedDead = true;
		};
	    var last_frame = sprite_get_number(sprite_index) - 1;
	    if (image_index >= last_frame) {
	        image_index = last_frame;
	        image_speed = 0;
			instance_destroy();
	    };
	} else {
		if (x > room_width) {
			obj_player.plr_health--;
			instance_destroy();
		};
		
		if (place_meeting(x,y, obj_player)) {
			obj_player.plr_health--;
			if (obj_player.plr_health > 0) {
				obj_player.state = "hurt";
			};
			image_index = 0;
			sprite_index = spr_die;
		};
		
		if (sprite_index != spr_die) {
			if (fire_cooldown > 0) {
				fire_cooldown--;
			} else if (fire_cooldown < 0) {
				fire_cooldown = 0;
			};
	
			if (x > 0 && x < room_width) {
				if (fire_cooldown == 0) {
					sprite_index = spr_fire;
					snd_fire = audio_play_sound(aud_enemy_fire, 1, false);
					instance_create_layer(x, y+32,"Instances",obj_enemy_bullet);
					var minFire = max(1, 5 - obj_player.difficulty);
					fire_cooldown = game_get_speed(gamespeed_fps) * random_range(minFire, 5);
				};
			};
			if (sprite_index == spr_fire) {
				var last_frame = sprite_get_number(sprite_index) - 1;
				if (image_index >= last_frame) {
				    sprite_index = spr_walk;
				};
			};
		};
	};
	show_debug_message(string_concat("ENEMY: ", fire_cooldown, " "));
} else {
	if (x > room_width) {
		instance_destroy();
	};
};