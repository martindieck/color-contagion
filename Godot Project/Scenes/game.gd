extends Node2D

#Rule of Thumb: 3500 per 10 sec for regular gun
const SPAWN_TIME = 0.5

@onready var tile_counter = %TileCounter
@onready var enemy_bar = %EnemyBar
@onready var weapon_bar = %WeaponBar
@onready var round_timer = $RoundTimer
@onready var change_timer = $ChangeTimer
@onready var spawn_timer = $SpawnTimer
@onready var spawner = get_node("/root/Game/Player/Spawner/Path2D/SpawnPoint")
@onready var music = $MusicPlayer
@onready var upgrade_menu = $UI/UpgradeMenu

var quotas = [15000, 30000, 100000]
var round_times = [180, 180, 180]
var rounds = {}
var spawn_increase = 0

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
	tile_counter.text = str(Global.tile_count) + " / " + str(rounds[Global.current_round]["quota"])
	enemy_bar.value = Global.enemies_killed
	weapon_bar.value = Global.near_misses
	#tile_counter.text = str(Engine.get_frames_per_second())
	
	if Global.tile_count >= rounds[Global.current_round]["quota"]:
		if Global.current_round + 1 in rounds.keys():
			Global.current_round += 1
			spawn_increase = floorf(0.45 / rounds[Global.current_round]["time"])
			spawn_timer.wait_time = SPAWN_TIME
			upgrade_menu.upgrade()
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

func _on_change_timer_timeout():
	spawn_timer.wait_time -= spawn_increase
	spawn_timer.wait_time = maxf(0.05, spawn_timer.wait_time)
