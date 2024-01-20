extends CharacterBody2D

@onready var sprite_2d = $Sprite2D
@onready var weapon = $Weapon

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 600
	move_and_slide()
	
	if direction != Vector2(0,0):
		sprite_2d.play("movement")
	else:
		sprite_2d.play("idle")
	
	if Input.is_action_just_pressed("change"):
		for child in weapon.get_children():
			child.queue_free()
		const WEAPON = preload("res://Scenes/cannon.tscn")
		var new_weapon = WEAPON.instantiate()
		weapon.add_child(new_weapon)
