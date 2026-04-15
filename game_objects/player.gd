extends CharacterBody2D

const JUMP_STRENGTH = 600.0
const SPEED: float = 400.0
const GRAVITY_MULT: float = 1.3
const MAX_AIRJUMP_AMOUNT: int = 1
var airjumps_left: int = MAX_AIRJUMP_AMOUNT

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and airjumps_left > 0:
		velocity.y = -JUMP_STRENGTH
		airjumps_left -= 1

func _physics_process(delta: float) -> void:
	var direction: float = Input.get_axis("move_left", "move_right")
	velocity.x = direction * SPEED
	if !is_on_floor():
		velocity += get_gravity() * GRAVITY_MULT * delta
	
	if is_on_floor() and airjumps_left != MAX_AIRJUMP_AMOUNT:
		airjumps_left = MAX_AIRJUMP_AMOUNT
	
	move_and_slide()
