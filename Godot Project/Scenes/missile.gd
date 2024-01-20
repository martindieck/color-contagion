extends Area2D

var tile_size = 16
var travelled_distance = 0
const SPEED = 800
const RANGE = 1200
const AREA = 5

@onready var explosion_radius = (AREA * tile_size) / scale.x
@onready var tilemap = get_node("/root/Game/Terrain")
@onready var explosion = $Explosion #USE FOR DETECTING ENEMIES IN EXPLOSION

func _physics_process(delta):
	print(explosion_radius)
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		explodes()
		
	tilemap.change_tileset(position, true)

func explodes():
	queue_free()
	tilemap.explosion(position, AREA)
