extends Area2D

onready var anim_player:AnimationPlayer = $AnimationPlayer

export var score: = 100

func _ready() -> void:
	anim_player.play("bouncing")
	
func _on_Coin_body_entered(_body: Node) -> void:
	PlayerData.score += score
	anim_player.play("faded")
