extends Node2D

const forward_spd = 30
const low_spd = 15
const rotation_spd = 0.05
var recoil: bool = false

var Bullet = preload("res://scenes/objects/comum_bullet.tscn")
#var AnimatedSprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#	AnimatedSprite = get_node("AnimatedSprite2D")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_W):
		$AnimatedSprite2D.visible = true
		$AnimatedSprite2D.play()

		translate(Vector2.from_angle(rotation) * forward_spd * delta)

	else:
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.visible = false
		
	if Input.is_key_pressed(KEY_LEFT):
		rotation -= rotation_spd

	if Input.is_key_pressed(KEY_RIGHT):
		rotation += rotation_spd

	if Input.is_key_pressed(KEY_S):
		translate(-(Vector2.from_angle(rotation) * low_spd * delta))

	if Input.is_key_pressed(KEY_A):
		translate(-(Vector2.from_angle(rotation + PI / 2)) * low_spd * delta)
	
	if Input.is_key_pressed(KEY_D):
		translate(Vector2.from_angle(rotation + PI / 2) * low_spd * delta)
	
	if Input.is_action_just_released("atirar"):
		fire()

	set_meta("rotation", rotation)

func fire() -> void:
	if recoil == false:
		var bullet = Bullet.instantiate()
		bullet.position = position

		get_parent().add_child(bullet)
		recoil = true

		$Timer.start()

func _on_timer_timeout() -> void:
	recoil = false
