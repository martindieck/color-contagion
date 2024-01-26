extends CharacterBody2D

@onready var sprite_2d = $Sprite2D
@onready var hurt_box = $HurtBox
@onready var weapon_holder = $WeaponHolder
@onready var item_holder = $ItemHolder
@onready var power_holder = $PowerHolder
@onready var damage_timer = $Timers/DamageTimer
@onready var sprite_timer = $Timers/SpriteTimer
@onready var power_timer = $Timers/PowerTimer
@onready var camera = $Camera2D
@onready var transition_screen = get_node("/root/Game/TransitionScreen")

var health = 3
var sprite_flash = 0
var can_take_damage = true
var has_shield = false
var cant_move = false
var alive = true
var speed = 600

signal new_item
signal player_dead

func _physics_process(delta):
	if not cant_move:
		var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		velocity = direction * speed
		move_and_slide()
		
		if direction != Vector2(0,0):
			sprite_2d.play("movement")
		else:
			sprite_2d.play("idle")

	var overlapping_mobs = hurt_box.get_overlapping_bodies()
	if overlapping_mobs.size() > 0 and can_take_damage:
		health -= 1
		if health <= 0 and alive:
			death()
		elif health > 0:
			can_take_damage = false
			damage_timer.start()
			sprite_timer.start()
		
func change_weapon(weapon):
	for child in weapon_holder.get_children():
		child.queue_free()
	match weapon:
		"gun":
			const WEAPON = preload("res://Scenes/gun.tscn")
			var new_weapon = WEAPON.instantiate()
			weapon_holder.add_child(new_weapon)
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
		"shield":
			const ITEM = preload("res://Scenes/shield.tscn")
			var new_item = ITEM.instantiate()
			item_holder.add_child(new_item)
	new_item.emit(item)

func _on_damage_timer_timeout():
	can_take_damage = true

func _on_sprite_timer_timeout():
	sprite_flash += 1
	sprite_2d.set_visible(not sprite_2d.visible)
	if sprite_flash >= 8:
		sprite_flash = 0
		sprite_timer.stop()

func damage_flash():
	damage_timer.start()
	sprite_timer.start()

func _on_near_miss_body_entered(body):
	if can_take_damage or has_shield:
		Global.near_misses += 1
		
func power_up():
	power_timer.start()
	var current_weapon = weapon_holder.get_children()[0].name
	match current_weapon:
		"Gun":
			const WEAPON = preload("res://Scenes/gun.tscn")
			var new_weapon = WEAPON.instantiate()
			power_holder.add_child(new_weapon)
		"Minigun":
			const WEAPON = preload("res://Scenes/minigun.tscn")
			var new_weapon = WEAPON.instantiate()
			power_holder.add_child(new_weapon)
		"Cannon":
			const WEAPON = preload("res://Scenes/cannon.tscn")
			var new_weapon = WEAPON.instantiate()
			power_holder.add_child(new_weapon)
		"Flamethrower":
			const WEAPON = preload("res://Scenes/flamethrower.tscn")
			var new_weapon = WEAPON.instantiate()
			power_holder.add_child(new_weapon)
	power_holder.get_children()[0].reverse = 1

func _on_power_timer_timeout():
	for child in power_holder.get_children():
		child.queue_free()
		
func disable_camera():
	camera.enabled = false
	
func remove_weapons():
	for child in weapon_holder.get_children():
		child.queue_free()

func shift_camera():
	camera.position.y -= 40
	
func death():
	alive = false
	process_mode = Node.PROCESS_MODE_ALWAYS
	Global.total_enemies_killed += Global.enemies_killed
	Global.total_near_misses += Global.near_misses
	remove_weapons()
	cant_move = true
	Global.in_cutscene = true
	get_tree().paused = true
	player_dead.emit()
	$AnimationPlayer.play("death")
	#$GPUParticles2D.restart()
	#sprite_2d.hide()
	#camera.zoom = Vector2(3,3)
	$Timers/DeathTimer.start()

func _on_death_timer_timeout():
	Global.in_cutscene = false
	Global.next_scene = "res://Scenes/game_over.tscn"
	transition_screen.transition()
