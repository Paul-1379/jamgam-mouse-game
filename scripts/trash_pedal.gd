extends Area2D
@export var name_of_task: String
@export var trash : AnimatedSprite2D
@export var raycast : RayCast2D
@export var particles: CPUParticles2D
signal cat_crushed_signal(task_name)

func _ready() -> void:
	%"tasks text".register_task(name_of_task)
func _on_body_entered(body: Node2D) -> void:
	if 'Player' in body.name and body.position.y < position.y:
		trash.play("open")
		$"trash sound".play()
		if raycast.is_colliding():
			particles.emitting = true
			cat_crushed_signal.emit(name_of_task)
		await get_tree().create_timer(1.0).timeout
		trash.play("close")
