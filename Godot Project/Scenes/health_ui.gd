extends Control

var hearts = 3
var tile_size = 16

@onready var texture = $Hearts
@onready var player = get_node("/root/Game/Player")

func _ready():
	texture.size.x = hearts * tile_size

func _process(delta):
	if player.health < hearts:
		texture.size.x -= tile_size
		hearts -= 1
