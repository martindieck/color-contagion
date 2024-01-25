extends CharacterBody2D

@onready var player = get_node("/root/Game/Player")
@onready var tilemap = get_node("/root/Game/Terrain")
@onready var sprite = $AnimatedSprite2D
@onready var collision = $CollisionShape2D

const SPEED = 450
var alive = true
var health = 1

func _ready():
	sprite.play("moving")

func _physics_process(delta):
	if alive:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * SPEED
		if sign(direction.x) == -1:
			sprite.flip_h = true
		if sign(direction.x) == 1:
			sprite.flip_h = false
		move_and_slide()
		tilemap.change_tileset(position, false)

func take_damage():
	health -= 1
	if health <= 0:
		death()

func _on_animated_sprite_2d_animation_finished():
	if sprite.animation == "death":
		queue_free()

func death():
	alive = false
	Global.enemies_killed += 1
	sprite.play("death")
	collision.set_deferred("disabled", true)
