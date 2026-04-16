extends CharacterBody2D

const JUMP_STRENGTH: float = 800.0
const SPEED: float = 400.0
const GRAVITY_STATES := { "jump": 1.7, "fall": 2.2 }
const TERMINAL_VELOCITY: float = 1400.0
const MAX_AIRJUMP_AMOUNT: int = 1
var airjumps_left: int = MAX_AIRJUMP_AMOUNT
var current_gravity_mult: float = GRAVITY_STATES["fall"]
var elapsed_since_movement: Dictionary[String, float] = {}

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and airjumps_left > 0:
		velocity.y = -JUMP_STRENGTH
		airjumps_left -= 1
		current_gravity_mult = GRAVITY_STATES["jump"]
	if event.is_action_released("jump") or velocity.y > -10.0:
		current_gravity_mult = GRAVITY_STATES["fall"]
	if event.is_action_pressed("move_left"):
		elapsed_since_movement["left"] = 0.0

func _process(delta: float) -> void:
	for key: String in elapsed_since_movement.keys():
		elapsed_since_movement[key] += delta

func _physics_process(delta: float) -> void:
	var direction: float = Input.get_axis("move_left", "move_right")
	velocity.x = direction * SPEED
	if !is_on_floor():
		_apply_gravity(delta)
	# jump jump jump suhvfjukiobsejh kjals
	if is_on_floor() and airjumps_left != MAX_AIRJUMP_AMOUNT:
		airjumps_left = MAX_AIRJUMP_AMOUNT
	
	move_and_slide()

func _apply_gravity(delta: float) -> void:
	velocity += get_gravity() * current_gravity_mult * delta
	if velocity.y > TERMINAL_VELOCITY:
		velocity.y = TERMINAL_VELOCITY

func die() -> void:
	print("You died I think why are you still moving")
	%DeathUI.visible = true
	%GameplayUI.visible = false
