extends Node2D

func _ready():
	pass

func _process(delta):
	pass


func _on_play_button_pressed():
	#replace with the path to the tutorial level
	get_tree().change_scene_to_file("res://title.tscn")

func _on_quit_button_pressed():
	get_tree().quit();
