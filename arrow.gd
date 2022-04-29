# arrow.gd

extends RigidBody2D

#signal arrow_fired()
signal arrow_out()
signal arrow_sound()

const MAX_FORCE = 18
const MAX_SPEED = -260
const Y0 = -10
const ARROW_POS0 = Vector2(0,Y0)

onready var max_y = position.y + MAX_FORCE
#onready var shoot = false
# var speed

func _ready():
	gravity_scale = 0.0 # remove gravity force!
	print(max_y)
	
# Physics
func impulse():
	var posy = position.y
	var force = range_lerp(posy, Y0, max_y, 10, 100) #
	var impulse =  -force * (position - ARROW_POS0) # todo: considerar angulo
	print("posy=", posy, " force=", force, " impulse=", impulse)
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
