extends TileMap

var tile_size = 16
var tile_choice = FastNoiseLite.new()

@onready var width = get_viewport_rect().size.x/(tile_size - 1)
@onready var height = get_viewport_rect().size.y/(tile_size - 1)

@onready var player = get_node("/root/Game/Player")

var tile_dict = {}

func change_tileset(bullet_position):
	var tile_pos = local_to_map(bullet_position)
	var x_coord = tile_pos.x
	var y_coord = tile_pos.y
	var dict_key = str(Vector2(x_coord,y_coord))
	if dict_key in tile_dict && tile_dict[dict_key]:
		pass
	else:
		tile_dict[dict_key] = true

func _process(delta):
	generate_chunk(player.position)
	
func generate_chunk(player_position):
	var tile_pos = local_to_map(player_position)
	for x in range(width):
		for y in range(height):
			var x_coord = tile_pos.x-width/2 + x
			var y_coord = tile_pos.y - height/2 + y
			var dict_key = str(Vector2(x_coord,y_coord))
			if dict_key in tile_dict:
				if tile_dict[dict_key] == true:
					var choice = tile_choice.get_noise_2d(x_coord, y_coord)*10
					set_cell(0, Vector2i(x_coord, y_coord), 0, Vector2i(round((choice+10)/5), 1))
			else:
				var choice = tile_choice.get_noise_2d(x_coord, y_coord)*10
				set_cell(0, Vector2i(x_coord, y_coord), 0, Vector2i(round((choice+10)/5), 0))
				tile_dict[dict_key] = false


	#var choice = tile_choice.get_noise_2d(tile_pos.x-width/2, tile_pos.y - height/2)*10
	#print(tile_pos)
	#set_cell(0, Vector2i(tile_pos.x, tile_pos.y), 0, Vector2i(round((choice+10)/5),1))
	#for x in range(width):
		#for y in range(height):
			#var choice = tile_choice.get_noise_2d(tile_pos.x-width/2 + x, tile_pos.y - height/2 + y)*10
			#set_cell(0, Vector2i(tile_pos.x-width/2 + x, tile_pos.y - height/2 + y), 0, Vector2i(round((choice+10)/5),1))
	

