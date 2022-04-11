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
	speed = Vector2(0, Global.Rnd.randf_range(MIN_SPEED, MAX_SPEED - 2 * Global.Level)) # falling speed
	#set_process(true)
	$efecto.interpolate_property($sprite, 'scale', tam, 1.25 * tam, 0.3, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$efecto.interpolate_property($sprite, 'modulate:a', 1, 0, 0.4, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)

#func _process(delta):
#	position += speed * delta

func end():
	$efecto.start()
	emit_signal("target_signal", id)
	
func _on_VisibilityNotifier2D_screen_exited():
	end()

func _on_Target_area_entered(_area):
	end() # collision

func _on_efecto_tween_completed(_object, _key):
	queue_free()
