extends CanvasLayer

var paused = false

func _process(delta):
	if Input.is_action_just_pressed("pause") and not paused:
		get_tree().paused = true
		paused = true
		show()
	elif Input.is_action_just_pressed("pause") and paused:
		get_tree().paused = false
		paused = false
		hide()
