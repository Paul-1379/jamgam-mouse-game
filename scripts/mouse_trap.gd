extends AnimatedSprite2D

@export var player: Node2D
@export var task_name: String
@export var task_text: Control
var grabbed: bool
var can_be_grabbed: bool
var offset_before_grabbed: Vector2
var trap_cat: bool = false

func _ready() -> void:
	%"tasks text".register_task(task_name)

func _on_trap_area_body_entered(body: Node2D) -> void:
	if "Player" in body.name and not grabbed:
		get_tree().change_scene_to_file("res://scenes/trap.tscn")

func _process(delta: float) -> void:
	if can_be_grabbed and Input.is_action_just_pressed("grab"):
		grabbed = not grabbed
		if grabbed:
			offset_before_grabbed = position - player.position
		else:
			position = player.position + offset_before_grabbed
	if grabbed:
		position = player.position + Vector2(0, -25)

func _on_grab_area_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		can_be_grabbed = true
		$"../UI/GrabInfo".show()
	if 'Milk' in body.name:
		trap_cat = true

func drink():
	if trap_cat:
		play("trap")
		task_text.task_completed(task_name)
		$"trap sound".play()
		await get_tree().create_timer(2.0).timeout
		play("default")
func _on_grab_area_body_exited(body: Node2D) -> void:
	if "Player" in body.name:
		can_be_grabbed = false
		$"../UI/GrabInfo".hide()
	if 'Milk' in body.name:
		trap_cat = false
