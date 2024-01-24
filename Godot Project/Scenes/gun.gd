extends Node2D

var reverse = 1

func _physics_process(delta):
	var mouse_position = get_global_mouse_position()
	var direction = mouse_position - global_position
	var angle = atan2(direction.y * reverse, direction.x * reverse)
	rotation = angle
	
	if Input.is_action_just_pressed("shoot"):
		shoot()
	
func shoot():
	const BULLET = preload("res://Scenes/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_bullet)

func _on_timer_timeout():
	if Input.is_action_pressed("shoot"):
		shoot()
