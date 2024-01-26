extends PanelContainer

var choice1 : String
var choice2 : String
var choice3 : String
var type : String
var pre_text = "Choose your "
var tooltip1
var tooltip2
var tooltip3
var bigtext = "Press Shift to repel enemies around you. You're protected while it is active. (10 sec cooldown)"

signal finished_upgrading

@onready var choice1_but = %Choice1
@onready var choice2_but = %Choice2
@onready var choice3_but = %Choice3
@onready var upgrade_label = %UpgradeLabel
@onready var tooltext = $MarginContainer/VBoxContainer/ToolText

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
			tooltip1 = "Hold Left Click to start the wind up and fire rapidly."
			choice1 = "minigun"
			choice2_but.text = "Cannon"
			choice2_but.icon = load("res://Sprites/Cannon.png")
			tooltip2 = "Fire hard hitting missiles that convert a large area."
			choice2 = "cannon"
			choice3_but.text = "Flamethrower"
			choice3_but.icon = load("res://Sprites/Flamethrower.png")
			tooltip3 = "Hold Left Click to fire a rapid stream of flames."
			choice3 = "flamethrower"
		3:
			type = "item"
			upgrade_label.text = pre_text + type + ":"
			choice1_but.text = "Dash"
			choice1_but.icon = load("res://Sprites/Dash.png")
			tooltip1 = "Press Shift to get a burst of speed. You're invincible while dashing. (10 sec cooldown)"
			choice1 = "dash"
			choice2_but.text = "Repulsion"
			choice2_but.icon = load("res://Sprites/Repulsion.png")
			tooltip2 = "Press Shift to repel enemies around you. You're protected while it is active. (10 sec cooldown)"
			choice2 = "repulsion"
			choice3_but.text = "Shield of Color"
			choice3_but.icon = load("res://Sprites/Shield.png")
			tooltip3 = "Prevents an enemy hit. Recharges in 20 seconds. Also leaves a trail of color while equipped."
			choice3 = "shield"

func _on_choice_1_pressed():
	Global.is_upgrading = false
	get_tree().paused = false
	hide()
	if type == "weapon":
		player.change_weapon(choice1)
		finished_upgrading.emit()
	elif type == "item":
		player.add_item(choice1)
		finished_upgrading.emit()

func _on_choice_2_pressed():
	Global.is_upgrading = false
	get_tree().paused = false
	hide()
	if type == "weapon":
		player.change_weapon(choice2)
		finished_upgrading.emit()
	elif type == "item":
		player.add_item(choice2)
		finished_upgrading.emit()

func _on_choice_3_pressed():
	Global.is_upgrading = false
	get_tree().paused = false
	hide()
	if type == "weapon":
		player.change_weapon(choice3)
		finished_upgrading.emit()
	elif type == "item":
		player.add_item(choice3)
		finished_upgrading.emit()

func _on_choice_1_mouse_entered():
	tooltext.text = "[center]%s[/center]" % tooltip1
	tooltext.add_theme_color_override("default_color", Color(1, 1, 1, 1))
	
func _on_choice_1_mouse_exited():
	tooltext.add_theme_color_override("default_color", Color(0.4, 0.4, 0.4, 1))
	tooltext.text = bigtext
	
func _on_choice_2_mouse_entered():
	tooltext.text = "[center]%s[/center]" % tooltip2
	tooltext.add_theme_color_override("default_color", Color(1, 1, 1, 1))

func _on_choice_2_mouse_exited():
	tooltext.add_theme_color_override("default_color", Color(0.4, 0.4, 0.4, 1))
	tooltext.text = bigtext

func _on_choice_3_mouse_entered():
	tooltext.text = "[center]%s[/center]" % tooltip3
	tooltext.add_theme_color_override("default_color", Color(1, 1, 1, 1))

func _on_choice_3_mouse_exited():
	tooltext.text = bigtext
	tooltext.add_theme_color_override("default_color", Color(0.4, 0.4, 0.4, 1))
