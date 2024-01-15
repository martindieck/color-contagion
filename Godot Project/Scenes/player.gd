extends CharacterBody2D

@onready var sprite_2d = $Sprite2D

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 600
	move_and_slide()
	
	if direction != Vector2(0,0):
		sprite_2d.play("movement")
	else:
		sprite_2d.play("idle")
	
	
