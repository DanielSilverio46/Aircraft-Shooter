extends Area2D

var spd: float = 100
var direction: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	direction = get_parent().get_node("Player").get_meta("rotation")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation += (spd/4) * delta
	translate(Vector2.from_angle(direction) * spd * delta)

func _on_body_entered(body: Node2D) -> void:
	if "Enemy" in body.name:
		body.life -= 5
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	queue_free()

func _on_timer_timeout() -> void:
	queue_free()
