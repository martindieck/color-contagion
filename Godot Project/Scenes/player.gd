extends CharacterBody2D

@onready var sprite_2d = $Sprite2D
@onready var hurt_box = $HurtBox
@onready var weapon_holder = $WeaponHolder
@onready var item_holder = $ItemHolder
@onready var damage_timer = $DamageTimer
@onready var sprite_timer = $SpriteTimer

var health = 3
var sprite_flash = 0
var can_take_damage = true
var speed = 600

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()
	
	if direction != Vector2(0,0):
		sprite_2d.play("movement")
	else:
		sprite_2d.play("idle")
	
	if Input.is_action_just_pressed("change"):
		add_item("dash")
		
	var overlapping_mobs = hurt_box.get_overlapping_bodies()
	if overlapping_mobs.size() > 0 and can_take_damage:
		health -= 1
		can_take_damage = false
		damage_timer.start()
		sprite_timer.start()
		if health <= 0:
			print("Game Over")
			breakpoint
		
func change_weapon(weapon):
	for child in weapon_holder.get_children():
		child.queue_free()
	match weapon:
		"minigun":
			const WEAPON = preload("res://Scenes/minigun.tscn")
			var new_weapon = WEAPON.instantiate()
			weapon_holder.add_child(new_weapon)
		"cannon":
			const WEAPON = preload("res://Scenes/cannon.tscn")
			var new_weapon = WEAPON.instantiate()
			weapon_holder.add_child(new_weapon)
		"flamethrower":
			const WEAPON = preload("res://Scenes/flamethrower.tscn")
			var new_weapon = WEAPON.instantiate()
			weapon_holder.add_child(new_weapon)

func add_item(item):
	match item:
		"dash":
			const ITEM = preload("res://Scenes/dash.tscn")
			var new_item = ITEM.instantiate()
			item_holder.add_child(new_item)
		"repulsion":
			const ITEM = preload("res://Scenes/repulsion.tscn")
			var new_item = ITEM.instantiate()
			item_holder.add_child(new_item)

func _on_damage_timer_timeout():
	can_take_damage = true

func _on_sprite_timer_timeout():
	sprite_flash += 1
	sprite_2d.set_visible(not sprite_2d.visible)
	if sprite_flash >= 8:
		sprite_flash = 0
		sprite_timer.stop()
