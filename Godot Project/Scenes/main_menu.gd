extends Control

func _on_play_pressed():
	Global.tile_count = 0
	Global.current_round = 1
	Global.enemies_killed = 0
	Global.near_misses = 0
	Global.total_enemies_killed = 0
	Global.total_near_misses = 0
	get_tree().change_scene_to_file("res://Scenes/game.tscn")

func _on_tutorial_pressed():
	get_tree().change_scene_to_file("res://Scenes/tutorial.tscn")

func _on_options_pressed():
	pass # Replace with function body.

func _on_quit_pressed():
	get_tree().quit()
