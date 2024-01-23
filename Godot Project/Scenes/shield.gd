extends Node2D

@onready var player = get_node("/root/Game/Player")
@onready var cool_down = $CoolDown
@onready var immunity = $Immunity
@onready var sprite = $Sprite2D
@onready var particles = $GPUParticles2D

var can_repel = true

func _ready():
	player.can_take_damage = false

func _on_cool_down_timeout():
	player.can_take_damage = false
	sprite.show()

func _on_shield_area_body_entered(body):
	player.damage_flash()
	cool_down.start()
	immunity.start()
	sprite.hide()
	particles.restart()

func _on_immunity_timeout():
	player.can_take_damage = true
