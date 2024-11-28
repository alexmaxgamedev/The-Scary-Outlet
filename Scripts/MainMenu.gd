extends Control

export var fullscreen_toggle_path : NodePath
onready var fullscreen_toggle : CheckBox = get_node(fullscreen_toggle_path)

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	OS.set_window_fullscreen(true)
	fullscreen_toggle.set_pressed(true)

func _on_Fullscreen_toggled(button_pressed):
	OS.set_window_fullscreen(button_pressed)

func _on_Play_pressed():
	LevelManager.load_level(2)

func _on_Credits_pressed():
	LevelManager.load_level(3)

func _on_Quit_pressed():
	LevelManager.quit()
