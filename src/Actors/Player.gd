extends Actor

export var stomp_impulse: = 1000.0
var direction: = Vector2.ZERO

func _on_EnemyDetector_area_entered(_area: Area2D) -> void:
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)

func _on_EnemyDetector_body_entered(_body: PhysicsBody2D) -> void:
	die()
	
func _physics_process(delta: float) -> void:
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	direction = get_direction()
	_velocity = calculate_move_velocity(_velocity, speed, direction, delta, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	return
	
func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_pressed("jump") and is_on_floor() else 1.0
	)

func calculate_move_velocity(
	_linear_velocity: Vector2,
	_speed: Vector2,
	_direction: Vector2,
	_delta: float,
	_is_jump_interrupted: bool
	) -> Vector2:
	var out: = _linear_velocity
	out.x = speed.x * direction.x
	out.y += gravity * _delta
	if _direction.y < 0:
		out.y = _speed.y * _direction.y
	if _is_jump_interrupted:
		out.y = 0.0
	return out

func calculate_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	var out: = linear_velocity
	out.y -= impulse
	return out

func die() -> void:
	PlayerData.deaths += 1
	queue_free()
