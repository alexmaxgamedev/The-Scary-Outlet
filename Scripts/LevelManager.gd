extends Node

func _init():
	OS.set_min_window_size(Vector2(480, 270))
	OS.set_window_size(OS.get_screen_size())

func load_level(index: int):
	match index:
		1: get_tree().change_scene("res://Scenes/Main Menu.tscn")
		2: get_tree().change_scene("res://Scenes/Main Level.tscn")
		3: get_tree().change_scene("res://Scenes/Credits.tscn")

func restart_current_level():
	get_tree().reload_current_scene()

func quit():
	get_tree().quit()
