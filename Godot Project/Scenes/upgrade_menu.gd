extends PanelContainer

var choice1 : String
var choice2 : String
var choice3 : String
var type : String
var pre_text = "Choose your "

@onready var choice1_but = %Choice1
@onready var choice2_but = %Choice2
@onready var choice3_but = %Choice3
@onready var upgrade_label = %UpgradeLabel

@onready var player = get_node("/root/Game/Player")

func upgrade():
	Global.is_upgrading = true
	get_tree().paused = true
	show()
	match Global.current_round:
		2:
			type = "weapon"
			upgrade_label.text = pre_text + type + ":"
			choice1_but.text = "Minigun"
			choice1_but.icon = load("res://Sprites/minigun.png")
			choice1 = "minigun"
			choice2_but.text = "Cannon"
			choice2_but.icon = load("res://Sprites/Cannon.png")
			choice2 = "cannon"
			choice3_but.text = "Flamethrower"
			choice3_but.icon = load("res://Sprites/Flamethrower.png")
			choice3 = "flamethrower"
		3:
			type = "item"
			upgrade_label.text = pre_text + type + ":"
			choice1_but.text = "Dash"
			choice1_but.icon = load("res://Sprites/Dash.png")
			choice1 = "dash"
			choice2_but.text = "Repulsion"
			choice2_but.icon = load("res://Sprites/Repulsion.png")
			choice2 = "repulsion"
			choice3_but.text = "Shield"
			choice3_but.icon = load("res://Sprites/Shield.png")
			choice3 = "shield"

func _on_choice_1_pressed():
	Global.is_upgrading = false
	get_tree().paused = false
	hide()
	if type == "weapon":
		player.change_weapon(choice1)
	elif type == "item":
		player.add_item(choice1)

func _on_choice_2_pressed():
	Global.is_upgrading = false
	get_tree().paused = false
	hide()
	if type == "weapon":
		player.change_weapon(choice2)
	elif type == "item":
		player.add_item(choice2)

func _on_choice_3_pressed():
	Global.is_upgrading = false
	get_tree().paused = false
	hide()
	if type == "weapon":
		player.change_weapon(choice3)
	elif type == "item":
		player.add_item(choice3)
