extends Node2D

#Rule of Thumb: 3500 per 10 sec for regular gun

@onready var tile_counter = get_node("/root/Game/Player/ColorRect/TileCounter")
@onready var round_timer = get_node("/root/Game/RoundTimer")
@onready var spawner = get_node("/root/Game/Player/Spawner/Path2D/SpawnPoint")

var quotas = [500, 1200, 250000]
var round_times = [18, 20, 180]
var rounds = {}

func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	var target = preload("res://Scenes/target.tscn").instantiate()
	add_child(target)
	create_rounds_dict(quotas, round_times)

func _physics_process(delta):
	tile_counter.text = str(Global.tile_count) + " / " + str(rounds[Global.current_round]["quota"])
	#tile_counter.text = str(Engine.get_frames_per_second())
	
	if Global.tile_count >= rounds[Global.current_round]["quota"]:
		if Global.current_round + 1 in rounds.keys():
			print("CONGRATULATIONS. MOVING TO NEXT ROUND")
			Global.current_round += 1
			round_timer.set_wait_time(rounds[Global.current_round]["time"])
			round_timer.start()
		else:
			print("YOU HAVE WON")

func _on_round_timer_timeout():
	if Global.tile_count < rounds[Global.current_round]["quota"]:
		print("GAME OVER")

func create_rounds_dict(quotas, round_times):
	for round in range(quotas.size()):
		rounds[round + 1] = {"quota": quotas[round], "time": round_times[round]}

func _on_spawn_timer_timeout():
	spawn_mob()

func spawn_mob():
	var new_mob = preload("res://Scenes/farmer.tscn").instantiate()
	spawner.progress_ratio = randf()
	new_mob.global_position = spawner.global_position
	add_child(new_mob)
