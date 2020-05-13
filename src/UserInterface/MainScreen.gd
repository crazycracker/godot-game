extends Button

export(String, FILE) var next_scene_path: = ""


func _get_configuration_warning() -> String:
	return "next_scene path is not set" if next_scene_path == "" else ""
	
func _on_button_up() -> void:
	get_tree().change_scene(next_scene_path)
	get_tree().paused = false
