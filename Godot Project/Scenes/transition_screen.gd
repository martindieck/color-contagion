extends CanvasLayer

signal transitioned

func _ready():
	visible = true
	$AnimationPlayer.play("fade_to_normal")

func transition():
	visible = true
	$AnimationPlayer.play("fade_to_black")
	
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade_to_black":
		emit_signal("transitioned")
		$AnimationPlayer.play("fade_to_normal")
	elif anim_name == "fade_to_normal":
		visible = false
