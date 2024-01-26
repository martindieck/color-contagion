extends Node2D

#Rule of Thumb: 3500 per 10 sec for regular gun
const SPAWN_TIME = 0.5

@onready var tile_counter = %TileCounter
@onready var round_timer = $Timers/RoundTimer
@onready var change_timer = $Timers/ChangeTimer
@onready var spawn_timer = $Timers/SpawnTimer
@onready var time_left = %TimeLeft
@onready var spawner = get_node("/root/Game/Player/Spawner/Path2D/SpawnPoint")
@onready var music = $MusicPlayer
@onready var upgrade_menu = $UI/UpgradeMenu
@onready var current_item = $UI/CurrentItem
@onready var arrow = $UI/Arrow
@onready var transition_screen = $TransitionScreen
@onready var player = $Player

var quotas = [1500, 3000, 4500]
var round_times = [5, 180, 180]
var rounds = {}
var spawn_increase = 0
var finished = false

func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	var target = preload("res://Scenes/target.tscn").instantiate()
	add_child(target)
	create_rounds_dict(quotas, round_times)
	music.play()
	round_timer.set_wait_time(rounds[Global.current_round]["time"])
	round_timer.start()
	spawn_increase = snappedf(0.45 / rounds[Global.current_round]["time"], 0.001)

func _physics_process(delta):
	tile_counter.text = str(Global.format_number(Global.tile_count)) + " / " + str(Global.format_number(rounds[Global.current_round]["quota"]))
	time_left.text = "%d:%02d" % [floor(round_timer.time_left / 60), int(round_timer.time_left) % 60]
	
	if Global.tile_count >= rounds[Global.current_round]["quota"] and not finished:
		if Global.current_round + 1 in rounds.keys():
			Global.current_round += 1
			spawn_increase = floorf(0.45 / rounds[Global.current_round]["time"])
			spawn_timer.wait_time = SPAWN_TIME
			upgrade_menu.upgrade()
			round_timer.set_wait_time(rounds[Global.current_round]["time"])
			round_timer.start()
		else:
			spawn_timer.wait_time = SPAWN_TIME
			change_timer.stop()
			finished = true
			var king = preload("res://Scenes/king.tscn").instantiate()
			var castle = preload("res://Scenes/castle.tscn").instantiate()
			spawner.progress_ratio = 0.85
			king.global_position = spawner.global_position
			king.global_position.y -= 10000
			castle.global_position = king.global_position
			arrow.begin_tracking(king)
			add_child(king)
			add_child(castle)
			king.king_death.connect(_on_item_used)

func _on_round_timer_timeout():
	if Global.tile_count < rounds[Global.current_round]["quota"]:
		game_over()

func create_rounds_dict(quotas, round_times):
	for round in range(quotas.size()):
		rounds[round + 1] = {"quota": quotas[round], "time": round_times[round]}

func _on_spawn_timer_timeout():
	spawn_mob()

func spawn_mob():
	match Global.current_round:
		1:
			var new_mob = preload("res://Scenes/farmer.tscn").instantiate()
			spawner.progress_ratio = randf()
			new_mob.global_position = spawner.global_position
			add_child(new_mob)
		2:
			var choice = randi_range(1, 2)
			var new_mob
			match choice:
				1:
					new_mob = preload("res://Scenes/farmer.tscn").instantiate()
				2:
					new_mob = preload("res://Scenes/knight.tscn").instantiate()
			spawner.progress_ratio = randf()
			new_mob.global_position = spawner.global_position
			add_child(new_mob)
		3:
			var choice = randi_range(1, 3)
			var new_mob
			match choice:
				1:
					new_mob = preload("res://Scenes/farmer.tscn").instantiate()
				2:
					new_mob = preload("res://Scenes/knight.tscn").instantiate()
				3:
					new_mob = preload("res://Scenes/wolf.tscn").instantiate()
			spawner.progress_ratio = randf()
			new_mob.global_position = spawner.global_position
			add_child(new_mob)
		_:
			var new_mob = preload("res://Scenes/farmer.tscn").instantiate()
			spawner.progress_ratio = randf()
			new_mob.global_position = spawner.global_position
			add_child(new_mob)

func _on_change_timer_timeout():
	spawn_timer.wait_time -= spawn_increase
	spawn_timer.wait_time = maxf(0.05, spawn_timer.wait_time)

func _on_player_new_item(item):
	current_item.new_item(item)
	current_item.show()
	var item_holder = get_node("/root/Game/Player/ItemHolder")
	var actual_item = item_holder.get_children()[0]
	actual_item.item_used.connect(_on_item_used)

func _on_item_used():
	current_item.item_used()

func _on_king_death():
	Global.next_scene = "res://Scenes/victory_screen.tscn"
	transition_screen.transition()

func _on_transition_screen_transitioned():
	get_tree().paused = false
	get_tree().change_scene_to_file(Global.next_scene)
	
func game_over():
	player.death()
