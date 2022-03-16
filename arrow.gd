# arrow.gd

extends Area2D

signal arrow_fired()
signal arrow_out()

const MAX_FORCE = 18
const MAX_SPEED = -260

onready var max_y = position.y + MAX_FORCE
onready var shoot = false
var speed

func _ready():
	set_process(false)

func _process(delta):
	position.y += speed * delta

func reset():
	emit_signal("arrow_out")
	set_process(false)
	shoot = false
	position = Vector2(0,-10)

func _input(_event):
	if shoot: return
	if Input.is_action_just_released("ui_select"):
		speed = MAX_SPEED * sqrt(MAX_FORCE-(max_y-position.y)+1)
		shoot = true
		emit_signal("arrow_fired")
		set_process(true)
		$shoot.play()
	elif Input.is_action_pressed("ui_select"):
		if position.y <= max_y:
			position.y += 2

func _on_VisibilityNotifier2D_screen_exited(): # out-of-screen
	reset()

func _on_arrow_area_entered(_area):
	Global.Score += 100
	reset()
