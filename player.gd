# player.gd

extends Node2D

const RMax = 75
const LMax = -RMax
const SAng = 3.0
const RSmall = deg2rad(SAng)
const LSmall = deg2rad(-SAng)
const BAng = 12.0
const RBig = deg2rad(BAng)
const LBig = deg2rad(-BAng)

const arrowTemplate = preload("res://arrow.tscn") ## Sol

onready var keys_disabled = false

var arrow ## Sol: Refencia a la flecha

func _ready():
	z_index = 2
	arrow = $arrow
	# warning-ignore:return_value_discarded
	arrow.connect("arrow_out", self, "arrow_out") # arrow signal

func _input(event):
	if keys_disabled: return
	if Input.is_action_pressed("ui_right") and rotation_degrees <= RMax:
		rotate(RBig if event.shift else RSmall) # shift-key is faster
		Global.Angle = global_rotation # BUG
	elif Input.is_action_pressed("ui_left") and rotation_degrees >= LMax:
		rotate(LBig if event.shift else LSmall)
		Global.Angle = global_rotation # BUG
	elif Input.is_action_just_released("ui_select"):
		arrow.impulse() # Phy: shot arrow
		keys_disabled = true
	elif Input.is_action_pressed("ui_select"):
		arrow.change_pos()

func arrow_out():
	keys_disabled = false
	arrow = arrowTemplate.instance() ## Sol
	arrow.connect("arrow_out", self, "arrow_out")
	set_global_rotation(0)
	Global.Angle = 0
	call_deferred("add_child",arrow)
