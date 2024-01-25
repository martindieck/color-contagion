extends Node2D

func _process(delta):
	%Tiles.text = str(Global.tile_count)
	%Enemies.text = str(Global.total_enemies_killed)
	%Misses.text = str(Global.total_near_misses)

func _on_play_again_pressed():
	Global.tile_count = 0
	Global.current_round = 1
	Global.enemies_killed = 0
	Global.near_misses = 0
	Global.total_enemies_killed = 0
	Global.total_near_misses = 0
	get_tree().change_scene_to_file("res://Scenes/game.tscn")

func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
