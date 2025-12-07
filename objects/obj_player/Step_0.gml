/// @description input handling; movement and fire; health/death
if (state == "hurt") {
	if (sprite_index == spr_hurt) {
	    var last_frame = sprite_get_number(sprite_index) - 1;
	    if (image_index >= last_frame) {
			state = "alive";
		};
	} else {
		sprite_index = spr_hurt;
		snd_hurt = audio_play_sound(aud_player_hurt, 1, false);
		image_index = 0;
	};
} else if (state != "dead") {
	if (plr_health <= 0) {
		state = "dead";
		image_index = 0;
		sprite_index = spr_die;
	} else {
		if (reflect_cooldown > 0) {
			reflect_cooldown--;
		} else if (reflect_cooldown < 0) {
			reflect_cooldown = 0;
		};
	
		if (fire_cooldown > 0) {
			fire_cooldown--;
		} else if (fire_cooldown < 0) {
			fire_cooldown = 0;
		};
	
		if (reflect_fx_timer > 0) {
			reflect_fx_timer--;
		} else if (reflect_fx_timer < 0) {
			reflect_fx_timer = 0;
		};
	
		if (keyboard_check_pressed(vk_control) && reflect_cooldown <= 0) {
			reflect_cooldown = game_get_speed(gamespeed_fps) * 5; // five second cooldown
			snd_reflect = audio_play_sound(aud_player_reflect, 1, false);
			sprite_index = spr_reflect;
			reflect_fx_timer = 60;

			with (obj_enemy_bullet) {
				var reflected = instance_create_layer(x, y, layer, obj_player_reflection);
				reflected.direction = direction - 180 + random_range(-20, 20);
				reflected.speed = speed;

				instance_destroy();
			};
		};

		if	(obj_player.y < 192) {
			obj_player.y = 192;
		} else if (obj_player.y > 768) {
			obj_player.y = 768;
		};

		if (keyboard_check(vk_up) && !keyboard_check(vk_down)) {
			obj_player.y -= 5;
		} else if (!keyboard_check(vk_up) && keyboard_check(vk_down)) {
			obj_player.y += 5;
		};

		if (keyboard_check_pressed(vk_space) && (fire_cooldown == 0)) {
			sprite_index = spr_fire;
			snd_fire = audio_play_sound(aud_player_fire, 1, false);
			instance_create_layer(x, y+64,"Instances",obj_player_bullet);
			fire_cooldown = 30;
		};

		if (fire_cooldown < 10 && reflect_cooldown < (game_get_speed(gamespeed_fps) * 5 - 30)) {
			sprite_index = spr_walk;
		};
	};
} else {
	if (!audio_is_playing(snd_die) && !playedDead) {
		snd_die = audio_play_sound(aud_player_die, 1, false);
		playedDead = true;
	};
	layer_x("foreground", layer_get_x("foreground")-5.25);
	layer_x("ground", layer_get_x("ground")-3);
	layer_x("background_near", layer_get_x("background_near")-2);
	layer_x("background_far", layer_get_x("background_far")-0.75);
    var last_frame = sprite_get_number(sprite_index) - 1;
    if (image_index >= last_frame) {
        image_index = last_frame;
        image_speed = 0;
    };
};

show_debug_message(string_concat("PLAYER [", state, "]: hp=", plr_health, " pts=", plr_score, " lvl=", difficulty, " (", max((game_get_speed(gamespeed_fps)*5) - (difficulty * 2), game_get_speed(gamespeed_fps)/2), ") ", fire_cooldown));