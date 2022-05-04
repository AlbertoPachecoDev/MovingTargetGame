# arrow.gd

extends RigidBody2D

#signal arrow_fired()
signal arrow_out()
signal arrow_sound()

const FORCE = -50
const Y0 = -20
const MAX_Y = -4
const ARROW_POS0 = Vector2(0,Y0)
const OFF_ANG = deg2rad(90)

func _ready():
	gravity_scale = 0.0 # remove gravity force!
	print("posy=", position.y) 
	
# Physics
# Tarea: 
# 1. Evitar que siga disparando flechas
# 2. Colisionar targets!!
func impulse():
	var posy = position.y
	var desp = Y0 - posy - 1
	var force = FORCE * desp
	# https://docs.godotengine.org/en/stable/tutorials/2d/2d_movement.html#rotation-movement
	var impulse = Vector2(force, 0).rotated(Global.Angle - OFF_ANG)
	# print("desp=", desp, " posy=", posy, " force=", force, " impulse=", impulse)
	self.apply_central_impulse(impulse) # aplicar fuerza para mover flecha
	$shoot.play()

#func _physics_process(delta):
#	if shoot:
#		var movement = speed * delta
#		if move_and_collide(movement):
#			print("chocaron!")

func reset():
	emit_signal("arrow_out") # sale flecha pantalla o si dio en el target
	#shoot = false
	position = ARROW_POS0

func change_pos():
	if position.y < MAX_Y:
		position.y += 2


func _on_VisibilityNotifier2D_screen_exited(): # out-of-screen
	reset()

func _on_arrow_area_entered(_area):
	Global.Score += 100
	$hit.play()
	reset()

func _on_hit_finished():
	emit_signal("arrow_sound")
