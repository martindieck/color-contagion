extends Control

var king
var flash = 0

@onready var sprite = $Sprite2D
@onready var player = get_node("/root/Game/Player")
@onready var flash_timer = $FlashTimer

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
	
	flash_timer.start()

func _on_flash_timer_timeout():
	flash += 1
	sprite.set_visible(not sprite.visible)
	if flash >= 10:
		flash = 0
		flash_timer.stop()
		show()
