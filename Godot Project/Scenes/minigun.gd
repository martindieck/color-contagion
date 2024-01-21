extends Node2D

@onready var sprite = $Sprite2D
@onready var spin_timer = $SpinTimer
@onready var down_timer = $DownTimer
var wind_up = 0

var can_shoot = false

func _physics_process(delta):
	var mouse_position = get_global_mouse_position()
	var direction = mouse_position - global_position
	var angle = atan2(direction.y, direction.x)
	rotation = angle
	
	if Input.is_action_just_released("shoot"):
		down_timer.start()
		spin_timer.stop()
	if Input.is_action_just_pressed("shoot"):
		down_timer.stop()
		spin_timer.start()
		
func shoot():
	const BULLET = preload("res://Scenes/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_bullet)

func _on_shoot_timer_timeout():
	if Input.is_action_pressed("shoot") and can_shoot:
		shoot()

func _on_spin_timer_timeout():
	wind_up += 0.15
	sprite.set_speed_scale(wind_up)
	sprite.play("shoot")
	if wind_up >= 1:
		spin_timer.stop()
		can_shoot = true

func _on_down_timer_timeout():
	can_shoot = false
	wind_up -= 0.15
	sprite.set_speed_scale(wind_up)
	sprite.play("shoot")
	if wind_up <= 0:
		down_timer.stop()
		sprite.play("idle")
