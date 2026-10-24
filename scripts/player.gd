extends CharacterBody2D

@export var player_sprite: Sprite2D
const SPEED = 300.0
const JUMP_VELOCITY = -550.0
const JUMP_RELEASE = 200
var GRAVITY_MULT = 2
var is_jumping = false
signal jumped

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * GRAVITY_MULT * delta
	if is_on_floor():
		is_jumping = false

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_jumping = true
		jumped.emit()
	if Input.is_action_just_released("jump") and is_jumping:
		velocity.y += JUMP_RELEASE

	var direction := Input.get_axis("left", "right")
	if direction != 0:
		player_sprite.flip_h = false if direction == 1 else true
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
