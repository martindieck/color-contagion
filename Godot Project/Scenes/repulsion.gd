extends Node2D

@onready var player = get_node("/root/Game/Player")
@onready var cool_down = $CoolDown
@onready var repel_timer = $RepelTimer
@onready var particles = $GPUParticles2D
@onready var sprite = $Sprite2D
@onready var collisions = $CharacterBody2D/CollisionShape2D

var can_repel = true

func _process(delta):
	if Input.is_action_just_pressed("movement") and can_repel:
		collisions.set_deferred("disabled", false)
		can_repel = false
		cool_down.start()
		repel_timer.start()
		particles.restart()
		sprite.visible = true

func _on_cool_down_timeout():
	can_repel = true

func _on_repel_timer_timeout():
	sprite.visible = false
	collisions.set_deferred("disabled", true)
