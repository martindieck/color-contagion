extends Node

var tile_count = 0
var current_round = 1
var enemies_killed = 0
var near_misses = 0

var paused = false
var is_upgrading = false
var in_cutscene = false

var dash_cooldown = 10
var repulsion_cooldown = 10
var shield_cooldown = 20
