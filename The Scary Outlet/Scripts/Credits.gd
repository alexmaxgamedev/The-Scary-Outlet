extends Node

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_Exit_pressed():
	LevelManager.load_level(1)
