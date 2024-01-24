extends Control

@onready var player = get_node("/root/Game/Player")
@onready var miss_bar = %MissBar
@onready var power = $Power

const THRESHOLD = 3

var can_power_up = false

func _ready():
	miss_bar.max_value = THRESHOLD

func _process(delta):
	miss_bar.value = Global.near_misses
	
	if Global.near_misses >= THRESHOLD and player.health < 10:
		power.show()
		can_power_up = true
		
	if Input.is_action_just_pressed("power_up") and can_power_up:
		Global.near_misses = 0
		player.power_up()
		can_power_up = false
		power.hide()
