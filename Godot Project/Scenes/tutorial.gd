extends Node2D

var flash = 0
var selected_node
var buffer

@onready var flash_timer = %FlashTimer
@onready var round_timer = $Timers/RoundTimer
@onready var buffer_timer = $Timers/Buffer
@onready var time_left = %TimeLeft
@onready var health_ui = %HealthUI
@onready var tile_counter = %TileCounter
@onready var enemy_counter = $UI/EnemyCounter
@onready var miss_counter = $UI/MissCounter
@onready var player = get_node("/root/Game/Player")

func _ready():
	player.remove_weapons()
	player.shift_camera()

func _process(delta):
	tile_counter.text = str(Global.format_number(Global.tile_count)) + " / " + str(Global.format_number(1000000))
	time_left.text = "%d:%02d" % [floor(round_timer.time_left / 60), int(round_timer.time_left) % 60]
	
func flash_asset(node):
	selected_node = node
	flash_timer.start()

func _on_flash_timer_timeout():
	flash += 1
	selected_node.set_visible(not selected_node.visible)
	if flash >= 10:
		flash = 0
		flash_timer.stop()
		selected_node.show()

func _on_buffer_timeout():
	flash_asset(buffer)

func _on_gun_area_body_entered(body):
	if body.name == "Player":
		player.change_weapon("gun")
		var target = preload("res://Scenes/target.tscn").instantiate()
		add_child(target)

func _on_counter_area_body_entered(body):
	if body.name == "Player":
		flash_asset(tile_counter)
		buffer = time_left
		buffer_timer.start()

func _on_hearts_area_body_entered(body):
	if body.name == "Player":
		flash_asset(health_ui)

func _on_enemy_count_area_body_entered(body):
	if body.name == "Player":
		flash_asset(enemy_counter)
		Global.enemies_killed = Global.enemy_bar_threshold - 2

func _on_miss_count_area_body_entered(body):
	if body.name == "Player":
		flash_asset(miss_counter)
		Global.near_misses = Global.miss_bar_threshold - 1

func _on_transition_screen_transitioned():
	get_tree().change_scene_to_file(Global.next_scene)
