extends Area

func _on_Lava_body_entered(body):
	if body.is_in_group("Player"):
		LevelManager.restart_current_level()
