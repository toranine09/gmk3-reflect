/// @description draw health and score

if (instance_exists(obj_player)) {
	var hp = obj_player.plr_health;
} else {
	var hp = 0;
};

draw_sprite(spr_ui_health, hp, room_width - sprite_get_width(spr_ui_health) - edgePadding, 3);


var rawScore = obj_player.plr_score;

if (rawScore >= 1000000) {
    var formattedScore = string_format(rawScore / 1000000, 1, 1) + "M";
} else if (rawScore > 1000) {
    var formattedScore = string_format(rawScore / 1000, 1, 1) + "k";
} else {
    var len = string_length(rawScore);
    var formattedScore = "";

    for (var i = 0; i < len; i++) {
        if (i != 0 && (len - i) mod 3 == 0) {
            formattedScore += ",";
        }
        formattedScore += string_copy(rawScore, i + 1, 1);
    };
};

if (obj_player.state = "dead") {
	var scoreText = "YOU DIED! You managed to reach a score of " + string(formattedScore) + "!\nPress Escape (Esc) to restart";
} else if (obj_player.plr_score >= 10) {
	var scoreText = "You win!\nEndless mode! Current score: " + string(formattedScore);
	if (!audio_is_playing(snd_bonus) && !playedWin) {
		snd_bonus = audio_play_sound(aud_bonus, 1, false);
		playedWin = true;
	};
} else {
	var scoreText = "SCORE: " + string(formattedScore);
};


draw_set_halign(fa_right);
draw_set_valign(fa_middle);


var scoreX = room_width - sprite_get_width(spr_ui_health) - 27 - edgePadding;
var scoreY = 33;

var xTextScale = 3;
var yTextScale = 3;
var lineHeight = string_height(scoreText) * yTextScale;

var boxWidth = string_width(scoreText) * xTextScale + 18;
var boxHeight = lineHeight + 9;

var scoreX = room_width - sprite_get_width(spr_ui_health) - 27 - edgePadding;
var scoreY = 33 + boxHeight * 0.5;

draw_set_colour($1a1a1a);
draw_rectangle(scoreX - boxWidth, scoreY - boxHeight * 0.5, scoreX, scoreY + boxHeight * 0.5, false);

draw_set_colour($e0e0e0);
draw_text_transformed(scoreX - 8, scoreY, scoreText, xTextScale, yTextScale, 0);