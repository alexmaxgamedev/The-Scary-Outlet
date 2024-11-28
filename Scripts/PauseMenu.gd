extends Control

export var player_path : NodePath
export var pause_menu_panel_path : NodePath
export var level_ambience_path : NodePath

onready var player : KinematicBody = get_node(player_path)
onready var pause_menu_panel : Panel = get_node(pause_menu_panel_path)
onready var level_ambience : AudioStreamPlayer = get_node(level_ambience_path)

var paused = false

func _exit_tree():
	get_tree().set_pause(false)

func _input(event):
	if event.is_action_pressed("pause"):
		paused = !paused
		set_pause_menu_state(paused)

func set_pause_menu_state(value : bool):
	if value == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	player.set_player_state(!value)
	pause_menu_panel.set_visible(value)
	get_tree().set_pause(value)
	
func pause_level_audio(value : bool):
	level_ambience.set_stream_paused(value)
	
func _on_Resume_pressed():
	set_pause_menu_state(false)
	
func _on_Exit_pressed():
	LevelManager.load_level(1)
