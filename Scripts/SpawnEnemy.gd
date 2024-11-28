extends Area

export var player_path : NodePath
export var spawn_point_path : NodePath
export var pause_menu_path : NodePath
export var end_text_animation_path : NodePath

onready var player : KinematicBody = get_node(player_path)
onready var spawn_point : Spatial = get_node(spawn_point_path)
onready var pause_menu : Control = get_node(pause_menu_path)
onready var end_text_animation : AnimationPlayer = get_node(end_text_animation_path)

onready var enemy_prefab = load("res://Prefabs/Enemy.tscn")

func spawn_enemy():
	pause_menu.set_process_input(false)
	spawn_point.add_child(enemy_prefab.instance())
	pause_menu.pause_level_audio(true)
	player.flashlight.enable_flashlight(false)
	player.set_player_state(false)
	player.set_translation(self.get_translation() + Vector3(0.0, 0.0, -2.0))
	player.set_rotation_degrees(Vector3(0.0, 0.0, 0.0))
	player.camera.set_rotation_degrees(Vector3(0.0, 0.0, 0.0))
	end_text_animation.play("Text Up")

func _on_End_Event_Trigger_body_entered(body):
	if body.is_in_group("Player"):
		spawn_enemy()

func _on_Animation_animation_finished(anim_name):
	LevelManager.load_level(3)
