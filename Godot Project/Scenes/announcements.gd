extends Control

@onready var label = $PanelContainer/MarginContainer/Label

func show_message(end):
	if end:
		label.text = "Follow the arrow at the top\nto find and kill the fleeing king"
	else:
		match Global.current_round:
			2:
				label.text = "Watch out for the tanky knights!"
			3:
				label.text = "The village wolves are coming!"
			_:
				label.text = ""
	show()
	$ShowTimer.start()
	
func _on_show_timer_timeout():
	hide()
