# arrow.gd

extends KinematicBody2D

signal arrow_fired()
signal arrow_out()
signal arrow_sound()

const MAX_FORCE = 18
const MAX_SPEED = -260

onready var max_y = position.y + MAX_FORCE
onready var shoot = false
var speed

func _ready():
	pass
	#set_process(false)
	#gravity_scale = 0.0 # remove gravity force!

#func _process(delta):
#	position.y += speed * delta # Can't set position!!

func _physics_process(delta):
	if shoot:
		var movement = speed * delta
		if move_and_collide(movement):
			print("chocaron!")

func reset():
	emit_signal("arrow_out") # sale flecha pantalla o si dio en el target
	set_process(false)
	shoot = false
	position = Vector2(0,-10)

func _input(_event):
	if shoot: return
	if Input.is_action_just_released("ui_select"):
		speed = Vector2(300,MAX_SPEED * sqrt(MAX_FORCE-(max_y-position.y)+1))
		shoot = true
		emit_signal("arrow_fired")
		#set_process(true)
		$shoot.play()
	elif Input.is_action_pressed("ui_select"):
		if position.y <= max_y:
			position.y += 2

func _on_VisibilityNotifier2D_screen_exited(): # out-of-screen
	reset()

func _on_arrow_area_entered(_area):
	Global.Score += 100
	$hit.play()
	reset()

func _on_hit_finished():
	emit_signal("arrow_sound")
