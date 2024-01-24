extends Control

@onready var time_label = $Item/Counter/Value
@onready var item_icon = $Item
@onready var cooldown_timer = $Item/Timer
@onready var sweep = $Item/Sweep
@export var cooldown = 3.0

func _ready():
	cooldown_timer.wait_time = cooldown
	time_label.hide()
	sweep.value = 0
	set_process(false)

func _process(delta):
	time_label.text = "%3.1f" % cooldown_timer.time_left
	sweep.value = int((cooldown_timer.time_left / cooldown) * 100)
	
func item_used():
	set_process(true)
	cooldown_timer.start()
	time_label.show()
	
func _on_timer_timeout():
	sweep.value = 0
	set_process(false)
	time_label.hide()
	
	
func new_item(item):
	match item:
		"dash":
			item_icon.texture = load("res://Sprites/Dash.png")
			cooldown = Global.dash_cooldown
			cooldown_timer.wait_time = cooldown
		"repulsion":
			item_icon.texture = load("res://Sprites/Repulsion.png")
			cooldown = Global.repulsion_cooldown
			cooldown_timer.wait_time = cooldown
		"shield":
			item_icon.texture = load("res://Sprites/Shield.png")
			cooldown = Global.shield_cooldown
			cooldown_timer.wait_time = cooldown
