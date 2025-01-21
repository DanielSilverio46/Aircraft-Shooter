extends Area2D

const speed: float = 10
var target: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target = get_parent().get_node("Player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	translate(Vector2.from_angle(position.angle_to_point(target.position))
		* speed * delta)
