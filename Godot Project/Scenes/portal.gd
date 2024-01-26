extends Area2D

@onready var transition_screen = get_node("/root/Game/TransitionScreen")

func _on_body_entered(body):
	if body.name == "Player":
		Global.tile_count = 0
		Global.current_round = 1
		Global.enemies_killed = 0
		Global.near_misses = 0
		Global.total_enemies_killed = 0
		Global.total_near_misses = 0
		Global.next_scene = "res://Scenes/game.tscn"
		transition_screen.transition()
