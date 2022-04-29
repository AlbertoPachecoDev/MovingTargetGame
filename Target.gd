# Target.gd

# Falling Particles: https://www.youtube.com/watch?v=lmzjiMh6LLs

extends RigidBody2D

signal target_signal(id)

const MIN_SPEED = 20.0
const MAX_SPEED = 50.0

var id
var speed

func _ready():
	var tam = $sprite.get_scale()
	var vel_y = Global.Rnd.randf_range(MIN_SPEED, MAX_SPEED - 2 * Global.Level)
	speed = Vector2(0, vel_y) # falling speed
	$efecto.interpolate_property($sprite, 'scale', tam, 1.25 * tam, 0.3, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$efecto.interpolate_property($sprite, 'modulate:a', 1, 0, 0.4, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)

func end():
	$efecto.start()
	emit_signal("target_signal", id) # notify arrow hit target
	
func _on_VisibilityNotifier2D_screen_exited(): # out-of-screen (bottom)
	end()

func _on_Target_area_entered(_area): # collision
	end() 

func _on_efecto_tween_completed(_object, _key): # wait end-tween-effect
	queue_free()
