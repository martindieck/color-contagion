extends Control

@onready var player = get_node("/root/Game/Player")
@onready var enemy_bar = %EnemyBar
@onready var heart = $Heart

var threshold = Global.enemy_bar_threshold

var can_regain = false

func _ready():
	enemy_bar.max_value = threshold

func _process(delta):
	enemy_bar.value = Global.enemies_killed
	
	if Global.enemies_killed >= threshold and player.health < 10:
		heart.show()
		can_regain = true
		
	if Input.is_action_just_pressed("regain") and can_regain:
		Global.total_enemies_killed += Global.enemies_killed
		Global.enemies_killed = 0
		player.health += 1
		can_regain = false
		heart.hide()
