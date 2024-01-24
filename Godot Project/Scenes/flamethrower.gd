extends Node2D

@onready var sprite = $Sprite2D

var can_shoot = false
var reverse = 1

func _physics_process(delta):
	var mouse_position = get_global_mouse_position()
	var direction = mouse_position - global_position
	var angle = atan2(direction.y * reverse, direction.x * reverse)
	rotation = angle
		
func shoot():
	const FLAME = preload("res://Scenes/flame.tscn")
	var new_flame = FLAME.instantiate()
	var offset = randf_range(-0.5,0.5)
	new_flame.global_position = %ShootingPoint.global_position
	new_flame.global_rotation = %ShootingPoint.global_rotation + offset
	%ShootingPoint.add_child(new_flame)

func _on_shoot_timer_timeout():
	if Input.is_action_pressed("shoot"):
		shoot()
