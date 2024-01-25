extends Control

var king

@onready var sprite = $Sprite2D
@onready var player = get_node("/root/Game/Player")

func _ready():
	set_process(false)

func _process(delta):
	var king_position = king.global_position
	var direction = king_position - player.global_position
	var angle = atan2(direction.y, direction.x)
	sprite.rotation = angle

func begin_tracking(target):
	king = target
	set_process(true)
	show()
