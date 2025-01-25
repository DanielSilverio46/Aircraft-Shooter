extends CharacterBody2D

var life: float = 10.0
const speed: float = 10.0

var target: Node2D
var move_away: bool = false
var move_away_node: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target = get_parent().get_node("Player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if life == 0:
		queue_free()
	
	var walk_to = Vector2.from_angle(position.angle_to_point(target.position)) * speed * delta

	if move_away == true and move_away_node != null:
		if position.x > move_away_node.position.x: walk_to += Vector2(2, 0) * delta
		else: walk_to += Vector2(-2, 0) * delta
		
		if position.y > move_away_node.position.y: walk_to += Vector2(0, 2) * delta
		else: walk_to -= Vector2(0, -2) * delta

	translate(walk_to)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if "Enemy" in body.name and body != self:
		move_away = true
		move_away_node = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if "Enemy" in body.name:
		move_away = false
