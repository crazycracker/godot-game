extends Control

onready var scene_tree: = get_tree()
onready var pause_overlay: ColorRect = $PauseOverlay
onready var score_label: Label = $Label
onready var pause_label: Label = $PauseOverlay/Title
var paused: = false setget set_paused

func _ready() -> void:
	PlayerData.connect("score_updated", self, "update_interface")
	PlayerData.connect("player_died", self, "_on_PlayerData_player_died")
	update_interface()

func _on_PlayerData_player_died() -> void:
	self.paused = true
	pause_label.text = "You died"
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause") and pause_label.text != "You died":
		self.paused = not paused
		scene_tree.set_input_as_handled()

func set_paused(value: bool) -> void:
	paused = value
	scene_tree.paused = value
	pause_overlay.visible = value

func update_interface() -> void:
	score_label.text = "Score : %s" % PlayerData.score
