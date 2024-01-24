extends CanvasLayer

func _process(delta):
	if Input.is_action_just_pressed("pause") and not Global.paused:
		get_tree().paused = true
		Global.paused = true
		show()
	elif Input.is_action_just_pressed("pause") and Global.paused:
		if Global.is_upgrading:
			Global.paused = false
			hide()
		else:
			get_tree().paused = false
			Global.paused = false
			hide()
