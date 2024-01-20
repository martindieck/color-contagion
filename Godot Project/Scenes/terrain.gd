extends TileMap

var tile_choice = FastNoiseLite.new()

var tile_dict = {}

func change_tileset(bullet_position, condition):
	var tile_pos = local_to_map(bullet_position)
	var dict_key = str(Vector2(tile_pos.x, tile_pos.y))
	if dict_key not in tile_dict and condition:
		var choice = tile_choice.get_noise_2d(tile_pos.x, tile_pos.y)*10
		set_cell(0, Vector2i(tile_pos.x, tile_pos.y), 0, Vector2i(round((choice+10)/5), 1))
		Global.tile_count += 1
		tile_dict[dict_key] = true
	elif dict_key in tile_dict and not condition:
		erase_cell(0, Vector2i(tile_pos.x, tile_pos.y))
		Global.tile_count -= 1
		tile_dict.erase(dict_key)

func explosion(explosion_position, area):
	var tile_pos = local_to_map(explosion_position)
	for x in range(tile_pos.x - area, tile_pos.x + area):
		for y in range(tile_pos.y - area, tile_pos.y + area):
			var dict_key = str(Vector2(x,y))
			var distance = round(Vector2(tile_pos).distance_to(Vector2(x, y)))
			if dict_key not in tile_dict && distance <= area:
				var choice = tile_choice.get_noise_2d(x, y)*10
				set_cell(0, Vector2i(x, y), 0, Vector2i(round((choice+10)/5), 1))
				Global.tile_count += 1
				tile_dict[dict_key] = true
