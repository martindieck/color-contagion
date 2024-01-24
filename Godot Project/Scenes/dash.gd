extends Node2D

@onready var player = get_node("/root/Game/Player")
@onready var cool_down = $CoolDown
@onready var dash_timer = $DashTimer

var can_dash = true

signal item_used

func _ready():
	cool_down.wait_time = Global.dash_cooldown

func _process(delta):
	if Input.is_action_just_pressed("movement") and can_dash:
		item_used.emit()
		can_dash = false
		player.speed = 1000
		player.can_take_damage = false
		cool_down.start()
		dash_timer.start()

func _on_cool_down_timeout():
	can_dash = true

func _on_dash_timer_timeout():
	player.speed = 600
	player.can_take_damage = true
