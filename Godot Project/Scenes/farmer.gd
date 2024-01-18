extends CharacterBody2D

@onready var player = get_node("/root/Game/Player")
@onready var tilemap = get_node("/root/Game/Terrain")

const SPEED = 250

func _ready():
	$AnimatedSprite2D.play("moving")

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * SPEED
	if sign(direction.x) == -1:
		$AnimatedSprite2D.flip_h = true
	if sign(direction.x) == 1:
		$AnimatedSprite2D.flip_h = false
	move_and_slide()
	tilemap.change_tileset(position, false)
