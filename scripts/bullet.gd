extends Area2D

var direction: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	direction = get_parent().get_node("Player").get_meta("rotation")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var spd: float = 100

	translate(Vector2.from_angle(direction) * spd * delta)

func _on_timer_timeout() -> void:
	queue_free()
