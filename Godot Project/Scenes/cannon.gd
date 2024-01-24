extends Node2D

@onready var sprite = $Sprite2D
var reverse = 1

func _physics_process(delta):
	var mouse_position = get_global_mouse_position()
	var direction = mouse_position - global_position
	var angle = atan2(direction.y * reverse, direction.x * reverse)
	rotation = angle
	
func shoot():
	sprite.play("shoot")
	const MISSILE = preload("res://Scenes/missile.tscn")
	var new_missile = MISSILE.instantiate()
	new_missile.global_position = %ShootingPoint.global_position
	new_missile.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_missile)

func _on_shoot_timer_timeout():
	if Input.is_action_pressed("shoot"):
		shoot()
