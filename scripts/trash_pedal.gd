extends Area2D

@export var trash : AnimatedSprite2D
@export var raycast : RayCast2D
@export var particles: CPUParticles2D
func _on_body_entered(body: Node2D) -> void:
	if 'Player' in body.name and body.position.y < position.y:
		print("a", body.name)
		trash.play("open")
		if raycast.is_colliding():
			particles.emitting = true
		await get_tree().create_timer(1.0).timeout
		trash.play("close")
