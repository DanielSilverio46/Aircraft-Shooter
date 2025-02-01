extends Node2D

const forward_spd = 30
const low_spd: float = 15
const rotation_spd: float = 0.05
const max_life: float = 200

var life: float = max_life
var recoil: bool = false

var Bullet = preload("res://scenes/objects/comum_bullet.tscn")

func _ready() -> void:
	$LifeBar.max_value = max_life
	$LifeBar.value = max_life

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var move_left_right = 0

	$LifeBar.value = life
	if life <= 0: queue_free()

	if Input.is_key_pressed(KEY_W):
		$AnimatedSprite2D.visible = true
		$AnimatedSprite2D.play()

		translate(Vector2.from_angle(rotation) * forward_spd * delta)
	else:
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.visible = false

	if Input.is_key_pressed(KEY_S):
		translate(-(Vector2.from_angle(rotation) * low_spd * delta))

	if Input.is_key_pressed(KEY_A): move_left_right = -1
	if Input.is_key_pressed(KEY_D): move_left_right = 1

	if Input.is_key_pressed(KEY_LEFT): rotation -= rotation_spd
	if Input.is_key_pressed(KEY_RIGHT): rotation += rotation_spd

	if Input.is_action_just_released("atirar"): fire()
	
	translate(Vector2.from_angle(rotation + PI / 2) * low_spd * delta
		* move_left_right)
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
