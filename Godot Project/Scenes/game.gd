extends Node2D

#Rule of Thumb: 3500 per 10 sec for regular gun

@onready var tile_counter = get_node("/root/Game/Player/ColorRect/TileCounter")

var quotas = [50000, 120000, 220000, 400000]
var round_times = [180, 180, 180, 180]
var rounds = {}

func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	var target = preload("res://Scenes/target.tscn").instantiate()
	add_child(target)
	create_rounds_dict(quotas, round_times)

func _physics_process(delta):
	tile_counter.text = str(Global.tile_count) + " / " + str(rounds[Global.current_round]["quota"])
	#tile_counter.text = str(Engine.get_frames_per_second())

func _on_round_timer_timeout():
	print(Global.tile_count)

func create_rounds_dict(quotas, round_times):
	for round in range(quotas.size()):
		rounds[round + 1] = {"quota": quotas[round], "time": round_times[round]}
