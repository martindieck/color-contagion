extends Node2D

@onready var width = get_viewport_rect().size.x
@onready var height = get_viewport_rect().size.y

@onready var background = $CanvasLayer

func _ready():
	get_tree().get_root().size_changed.connect(resize)

func resize():
	var new_width = get_viewport_rect().size.x
	var new_height = get_viewport_rect().size.y
	background.scale.x = new_width/width
	background.scale.y = new_height/height
