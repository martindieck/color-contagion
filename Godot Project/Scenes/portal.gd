extends Area2D

func _on_body_entered(body):
	if body.name == "Player":
		Global.tile_count = 0
		Global.current_round = 1
		Global.enemies_killed = 0
		Global.near_misses = 0
		Global.total_enemies_killed = 0
		Global.total_near_misses = 0
		get_tree().change_scene_to_file("res://Scenes/game.tscn")
