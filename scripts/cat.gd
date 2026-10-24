extends AnimatedSprite2D

@export var player: CharacterBody2D
@export var mouse_trap: Node2D
var can_drink: bool = true
const SPEED = 150

func _ready() -> void:
	await get_tree().create_timer(1.0).timeout
	play("getting up")
	await get_tree().create_timer(2.0).timeout
	play("walking")

func _process(delta: float) -> void:
	var direction = (1 if player.position.x > position.x else -1)
	if direction != 0:
		flip_h = false if direction == 1 else true
		$"Head area".position.x = 225 if direction == 1 else -225
	if abs(player.position.x - position.x) > SPEED * 2 and animation == "walking":
		position.x += SPEED * direction * delta

func _on_cat_crushed_signal(_task_name) -> void:
	play("crushed")
	await get_tree().create_timer(3.0).timeout
	play("walking")

func _on_head_area_body_entered(body: Node2D) -> void:
	if "drink" in body.name:
		play("drinking")
		mouse_trap.drink()
		await get_tree().create_timer(2.0).timeout
		play("walking")
		can_drink = false
		await get_tree().create_timer(4.0).timeout
		can_drink = true
		
