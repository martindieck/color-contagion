extends Node2D

@onready var width = get_viewport_rect().size.x
@onready var height = get_viewport_rect().size.y
var curve = load("res://Scenes/spawner.tscn::Curve2D_hlit1")

func _ready():
	get_tree().get_root().size_changed.connect(resize)

func resize():
	var new_width = get_viewport_rect().size.x
	var new_height = get_viewport_rect().size.y
	scale.x = new_width/width * 0.167
	scale.y = new_height/height * 0.167
