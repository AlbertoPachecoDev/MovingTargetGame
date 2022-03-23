# Target.gd

# Falling Particles: https://www.youtube.com/watch?v=lmzjiMh6LLs

extends Area2D

signal target_signal(id)

const MIN_SPEED = 20.0
const MAX_SPEED = 50.0

var id
var speed

func _ready():
	speed = Vector2(0, Global.Rnd.randf_range(MIN_SPEED, MAX_SPEED - 2 * Global.Level)) # falling speed
	set_process(true)

func _process(delta):
	position += speed * delta

func end():
	emit_signal("target_signal", id)
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	end()

func _on_Target_area_entered(_area):
	end() # collision
