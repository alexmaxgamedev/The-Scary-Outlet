extends KinematicBody

export var walk_speed : float = 6.0
export var jump_speed : float = 12.0
export var gravity : float = 25.0

export var max_time_in_air : float = 2.5
export var mouse_sensitivity : float = 0.11

onready var camera : Camera = $Camera
onready var flashlight : SpotLight = $Camera/Flashlight

var fall : Vector3
var movement : Vector3
var direction : Vector3
var snap : Vector3
var mouse_axis : Vector2

var fall_timer : float = 0.0
var allow_death : bool = true

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		mouse_axis = event.relative

		if mouse_axis.length() > 0:
			self.rotate_y(deg2rad(-mouse_axis.x * mouse_sensitivity))
			camera.rotate_x(deg2rad(-mouse_axis.y * mouse_sensitivity))

			camera.rotation.x = clamp(camera.rotation.x, -1.570796, 1.570796)
			mouse_axis = Vector2.ZERO

func _process(delta):
	direction = Vector3.ZERO
	
	if Input.is_action_pressed("move_forward"):
		direction -= transform.basis.z
	if Input.is_action_pressed("move_back"):
		direction += transform.basis.z
	if Input.is_action_pressed("move_left"):
		direction -= transform.basis.x
	if Input.is_action_pressed("move_right"):
		direction += transform.basis.x

	direction = direction.normalized()
	
	if is_on_floor():
		fall_timer = 0.0
		snap = -get_floor_normal()
		fall.y = 0.0
	else:
		snap = Vector3.DOWN
		fall.y -= gravity * delta

		fall_timer += delta

		if fall_timer > max_time_in_air:
			allow_death = true

			if allow_death == true:
				LevelManager.restart_current_level()
				allow_death = false

	if Input.is_action_just_pressed("jump") and is_on_floor():
		snap = Vector3.ZERO
		fall.y = jump_speed
	
	movement = (direction * walk_speed) + fall
	move_and_slide_with_snap(movement, snap, Vector3.UP, false, 4, 0.785398, true)
	
func set_player_state(value: bool):
	set_process(value)
	set_process_input(value)
	flashlight.set_process_input(value)
