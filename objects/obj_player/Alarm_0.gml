/// @description enemy spawning

var minSpawn = game_get_speed(gamespeed_fps) / 2;
var maxSpawn = game_get_speed(gamespeed_fps) * 5;

var waveTimer = max(maxSpawn - (difficulty * 2), minSpawn);

instance_create_layer(-180, 200,"Instances",obj_enemy);

alarm[0] = waveTimer;