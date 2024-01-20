extends Area2D

const SPEED = 800
const RANGE = 500
const AREA = 1

var tile_size = 16
var travelled_distance = 0

@onready var player = get_node("/root/Game/Player")
@onready var explosion_radius = (AREA * tile_size) / scale.x
@onready var tilemap = get_node("/root/Game/Terrain")
@onready var explosion = $Explosion #USE FOR DETECTING ENEMIES IN EXPLOSION
@onready var explosion_shape = explosion.shape
@onready var sprite = $Sprite2D

func _ready():
	explosion_shape.set_deferred("radius", explosion_radius)
	sprite.global_rotation = 0

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()
		
	explodes()

func explodes():
	tilemap.explosion(position, AREA)
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.has_method("take_damage"):
			body.take_damage()
