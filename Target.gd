# Target.gd

extends Node2D

signal kill(id)

var id
var speed

onready var floorY = Global.ScreenH - Global.TargetWidth

func _ready():
	var y = Global.Rnd.randf_range(80.0, 160.0) # falling spped
	speed = Vector2(0, y) # set speed
	set_process(true)

func _process(delta):
	var pos = get_position()
	if pos.y < floorY: # falling?
		set_position(pos + speed * delta) # move
	else: # on the floor?
		queue_free()  # ISSUE: Evitar click en objeto en el suelo
		emit_signal("kill", id)
