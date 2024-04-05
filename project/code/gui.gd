extends Control

var revive = false

func changeGUI(stage : int):
	if (stage == 0):
		$title.visible = true
		$death.visible = false
		$win.visible = false
	elif (stage == 1):
		$title.visible = false
		$death.visible = false
		$win.visible = false
	elif (stage == 2):
		$title.visible = false
		$death.visible = true
		$win.visible = false
	else:
		$title.visible = false
		$death.visible = false
		$win.visible = true

func _process(delta):
	pass

func _on_play_button_pressed():
	changeGUI(1)

func _on_quit_button_pressed():
	get_tree().quit();

func _on_retry_button_pressed():
	Controller.loadLevel(0);

func _on_play_again_button_pressed():
	Controller.loadLevel(0);
