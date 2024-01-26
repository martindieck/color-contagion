extends Node2D

func _ready():
	%Tiles.text = str(Global.format_number(Global.tile_count))
	%Enemies.text = str(Global.format_number(Global.total_enemies_killed))
	%Misses.text = str(Global.format_number(Global.total_near_misses))

func _on_play_again_pressed():
	Global.tile_count = 0
	Global.current_round = 1
	Global.enemies_killed = 0
	Global.near_misses = 0
	Global.total_enemies_killed = 0
	Global.total_near_misses = 0
	Global.next_scene = "res://Scenes/game.tscn"
	$TransitionScreen.transition()

func _on_main_menu_pressed():
	Global.next_scene = "res://Scenes/main_menu.tscn"
	$TransitionScreen.transition()

func _on_transition_screen_transitioned():
	get_tree().change_scene_to_file(Global.next_scene)
