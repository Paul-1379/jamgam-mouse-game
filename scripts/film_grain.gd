extends TextureRect

@onready var rng = RandomNumberGenerator.new()
var timer = 0
func _process(delta: float) -> void:
	timer += delta
	if timer > 0.25:
		texture.noise.seed = rng.randi()
		timer = 0
