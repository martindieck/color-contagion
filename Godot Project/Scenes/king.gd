extends CharacterBody2D

@onready var player = get_node("/root/Game/Player")
@onready var tilemap = get_node("/root/Game/Terrain")
@onready var sprite = $AnimatedSprite2D
@onready var collision = $CollisionShape2D
@onready var camera = $Camera2D

const SPEED = 250

var alive = true
var health = 1

signal king_death

func _ready():
	sprite.play("moving")

func _physics_process(delta):
	if alive:
		var direction = -global_position.direction_to(player.global_position)
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

func death():
	alive = false
	player.disable_camera()
	process_mode = Node.PROCESS_MODE_ALWAYS
	Global.in_cutscene = true
	get_tree().paused = true
	camera.enabled = true
	Global.enemies_killed += 1
	Global.total_enemies_killed += Global.enemies_killed
	Global.total_near_misses += Global.near_misses
	sprite.play("death")
	collision.set_deferred("disabled", true)

func _on_animated_sprite_2d_animation_finished():
	if sprite.animation == "death":
		king_death.emit()
