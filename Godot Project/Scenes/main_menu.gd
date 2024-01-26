extends Control

@onready var transition_screen = $TransitionScreen

func _on_play_pressed():
	Global.tile_count = 0
	Global.current_round = 1
	Global.enemies_killed = 0
	Global.near_misses = 0
	Global.total_enemies_killed = 0
	Global.total_near_misses = 0
	Global.next_scene = "res://Scenes/game.tscn"
	transition_screen.transition()

func _on_tutorial_pressed():
	Global.tile_count = 0
	Global.current_round = 1
	Global.enemies_killed = 0
	Global.near_misses = 0
	Global.total_enemies_killed = 0
	Global.total_near_misses = 0
	Global.next_scene = "res://Scenes/tutorial.tscn"
	transition_screen.transition()

func _on_options_pressed():
	pass # Replace with function body.

func _on_quit_pressed():
	get_tree().quit()

func _on_transition_screen_transitioned():
	get_tree().change_scene_to_file(Global.next_scene)
