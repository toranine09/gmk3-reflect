/// @description set alarm[0], initialise cooldowns, initialise sounds

alarm[0] = game_get_speed(gamespeed_fps)*3;
reflect_cooldown = 45;

snd_die = -1;
snd_fire = -1;
snd_hurt = -1;
snd_reflect = -1;
playedDead = false;