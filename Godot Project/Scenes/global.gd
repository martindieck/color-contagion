extends Node

var tile_count = 0
var current_round = 1
var enemies_killed = 0
var near_misses = 0

var total_enemies_killed = 0
var total_near_misses = 0

var paused = false
var is_upgrading = false
var in_cutscene = false
var fullscreen = false
var volume = 1

var next_scene

var dash_cooldown = 10
var repulsion_cooldown = 10
var shield_cooldown = 20
var enemy_bar_threshold = 50
var miss_bar_threshold = 15

func format_number(num):
	var txt_numb = "%.2d" % num
	for idx in range(txt_numb.length()-3, 0, -3):
		txt_numb = txt_numb.insert(idx, ",")
	return txt_numb
