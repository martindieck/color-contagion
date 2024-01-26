extends CanvasLayer

@onready var music = get_node("/root/Game/MusicPlayer")

func _process(delta):
	if Input.is_action_just_pressed("pause") and not Global.paused and not Global.in_cutscene:
		#If you press pause and it is not paused and you're not in cutscene
		get_tree().paused = true
		Global.paused = true
		show()
		music.set_bus("Low")
	elif Input.is_action_just_pressed("pause") and Global.paused:
		#Or if you pressed pause and it is already paused.
		if Global.is_upgrading:
			Global.paused = false
			hide()
			music.set_bus("Master")
		else:
			get_tree().paused = false
			Global.paused = false
			hide()
			music.set_bus("Master")

func _on_resume_pressed():
	if Global.paused:
		if Global.is_upgrading:
			Global.paused = false
			hide()
		else:
			get_tree().paused = false
			Global.paused = false
			hide()

func _on_main_menu_pressed():
	Global.next_scene = "res://Scenes/main_menu.tscn"
	$TransitionScreen.transition()

func _on_transition_screen_transitioned():
	hide()
	get_tree().paused = false
	Global.paused = false
	music.set_bus("Master")	
	get_tree().change_scene_to_file(Global.next_scene)
