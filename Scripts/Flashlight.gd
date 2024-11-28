extends SpotLight

var enabled = false

func _input(event):
	if event.is_action_pressed("flashlight"):
		enabled = !enabled
		enable_flashlight(enabled)

func enable_flashlight(value : bool):
	self.set_visible(value)
