extends TileMap

var tile_size = 16 

var width = get_viewport_rect().size.x/(tile_size - 1)
var height = get_viewport_rect().size.y/(tile_size - 1)

@onready var player = get_parent().get_child(1)

func _process(delta):
	generate_chunk(player.position)
	
func generate_chunk(position):
	var tile_pos = local_to_map(position)
	for x in range(width):
		for y in range(height):
			set_cell(0, Vector2i(tile_pos.x-width/2 + x, tile_pos.y - height/2 + y), 0, Vector2i(4,0))
