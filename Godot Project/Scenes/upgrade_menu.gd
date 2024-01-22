extends PanelContainer

var choice1 : String
var choice2 : String
var choice3 : String
var type : String

@onready var player = get_node("/root/Game/Player")

func upgrade():
	get_tree().paused = true
	show()
	match Global.current_round:
		2:
			type = "weapon"
			$VBoxContainer/Choice1.text = "Minigun"
			choice1 = "minigun"
			$VBoxContainer/Choice2.text = "Cannon"
			choice2 = "cannon"
			$VBoxContainer/Choice3.text = "Flamethrower"
			choice3 = "flamethrower"
		3:
			type = "item"
			$VBoxContainer/Choice1.text = "Dash"
			choice1 = "dash"
			$VBoxContainer/Choice2.text = "Repulsion"
			choice2 = "repulsion"
			$VBoxContainer/Choice3.text = "Shield"
			choice3 = "shield"

func _on_choice_1_pressed():
	get_tree().paused = false
	hide()
	if type == "weapon":
		player.change_weapon(choice1)
	elif type == "item":
		player.add_item(choice1)
		

func _on_choice_2_pressed():
	get_tree().paused = false
	hide()
	if type == "weapon":
		player.change_weapon(choice2)
	elif type == "item":
		player.add_item(choice2)

func _on_choice_3_pressed():
	get_tree().paused = false
	hide()
	if type == "weapon":
		player.change_weapon(choice3)
	elif type == "item":
		player.add_item(choice3)
