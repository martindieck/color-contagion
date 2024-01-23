extends TextureProgressBar

@onready var player = get_node("/root/Game/Player")

func _process(delta):
	if Input.is_action_just_pressed("absorb") and Global.enemies_killed >= max_value:
		Global.enemies_killed -= max_value
		player.health += 1
