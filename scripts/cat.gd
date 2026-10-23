extends AnimatedSprite2D

@export var player: CharacterBody2D
const SPEED = 120
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(1.0).timeout
	play("getting up")
	await get_tree().create_timer(2.0).timeout
	play("walking")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = (1 if player.position.x > position.x else -1)
	if direction != 0:
		flip_h = false if direction == 1 else true
	if abs(player.position.x - position.x) > SPEED * 2 and animation == "walking":
		position.x += SPEED * direction * delta
