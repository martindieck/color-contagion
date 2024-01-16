extends Node2D

@onready var tile_counter = get_node("/root/Game/Player/ColorRect/TileCounter")

func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	var target = preload("res://Scenes/target.tscn").instantiate()
	add_child(target)

func _physics_process(delta):
	tile_counter.text = str(Global.tile_count)
