extends Node2D

@onready var player = get_node("/root/Game/Player")
@onready var cool_down = $CoolDown
@onready var immunity = $Immunity
@onready var sprite = $Sprite2D
@onready var particles = $GPUParticles2D
@onready var tilemap = get_node("/root/Game/Terrain")

func _ready():
	player.can_take_damage = false
	player.has_shield = true
	
func _physics_process(delta):
	if player.has_shield:
		tilemap.explosion(player.position, 2)

func _on_cool_down_timeout():
	player.can_take_damage = false
	player.has_shield = true
	sprite.show()

func _on_shield_area_body_entered(body):
	player.damage_flash()
	player.has_shield = false
	cool_down.start()
	immunity.start()
	sprite.hide()
	particles.restart()

func _on_immunity_timeout():
	player.can_take_damage = true
