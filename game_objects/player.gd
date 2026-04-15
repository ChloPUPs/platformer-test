extends CharacterBody2D

const JUMP_STRENGTH = 600.0
const SPEED: float = 400.0
const GRAVITY_MULT: float = 1.3

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		velocity.y = -JUMP_STRENGTH

func _physics_process(delta: float) -> void:
	var direction: float = Input.get_axis("move_left", "move_right")
	velocity.x = direction * SPEED
	if !is_on_floor():
		velocity += get_gravity() * GRAVITY_MULT * delta
	
	move_and_slide()
