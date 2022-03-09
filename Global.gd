# Global.gd

extends Node2D

const TargetImage = preload("res://images/target.png")

onready var Score = 0
onready var Level = 1

var Rnd
var ScreenW
var ScreenH
var Cols # array
var TargetWidth

func _ready():
	ScreenW = get_viewport().size.x # screen size
	ScreenH = get_viewport().size.y
	Rnd = RandomNumberGenerator.new()
	Rnd.randomize()
	TargetWidth = TargetImage.get_width()
	Cols = range(TargetWidth, ScreenW, TargetWidth) # generate cols array
	z_index = 1
	set_process(true)

func _process(_delta):
	$scoreLabel.text = "Level: " + String(Level) + "  Score: " + String(Score) # SOL: Tarea-1: update score
	# EQUIV: get_node("scoreLabel").set_text("Score: " + String(Score)) 

func game_over():
	$scoreLabel.set_text("GAME OVER!  Score = "+String(Score))
