extends Sprite2D
@export var task_name: String
@export var player: Node2D
var grabbed: bool
var can_be_grabbed: bool
var offset_before_grabbed: Vector2
signal cat_crushed_signal(name_of_task)

func _ready() -> void:
	%"tasks text".register_task(task_name)
func _process(delta: float) -> void:
	if can_be_grabbed and Input.is_action_just_pressed("grab"):
		grabbed = not grabbed
		if grabbed:
			offset_before_grabbed = position - player.position
		else:
			position = player.position + offset_before_grabbed
	if grabbed:
		position = player.position
		z_index = 100
		
func _on_grab_area_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		can_be_grabbed = true
		$"../UI/GrabInfo".show()

func _on_grab_area_body_exited(body: Node2D) -> void:
	if "Player" in body.name:
		can_be_grabbed = false
		$"../UI/GrabInfo".hide()


func _on_player_jumped() -> void:
	if grabbed:
		if $RayCast2D.is_colliding() and $RayCast2D.get_collider().name == "Head area":
			cat_crushed_signal.emit(task_name)
