extends Control

var revive = false

func _ready():
	changeGUI(0)

func changeGUI(stage : int):
	if (stage == 0):
		$title.visible = true
		$death.visible = false
	elif (stage == 1):
		$title.visible = false
		$death.visible = false
	else:
		$title.visible = false
		$death.visible = true

func _process(delta):
	pass


func _on_play_button_pressed():
	changeGUI(1)

func _on_quit_button_pressed():
	get_tree().quit();

func _on_retry_button_pressed():
	revive = true
	changeGUI(1)
