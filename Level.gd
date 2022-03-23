# Level.gd

# Background: https://www.flickr.com/photos/29638108@N06/51690240835/in/dateposted/
# Credits: Jennifer C. www.metaphoricalplatypus.com

extends Node2D

const target = preload("res://Target.tscn")

onready var targets = [] # target-ids array

func _ready():
	# warning-ignore:return_value_discarded
	$player/arrow.connect("arrow_sound", self, "next")
	$player.global_rotation_degrees = Global.Angle # Restore last bow-angle
	var cols = Global.Cols.duplicate() # copy array
	randomize()
	cols.shuffle() # random order
	for i in range(Global.Level): # create targets
		var obj = target.instance()
		obj.id = i
		obj.set_position(Vector2(cols.pop_back(), Global.TargetWidth))
		targets.append(i) # contador targets
		obj.connect("target_signal", self, "update_targets") # target signal
		add_child(obj)

func update_targets(id):
	targets.erase(id) # remove target
	if targets.empty():
		next()

func next():
	if targets.empty(): # no more targets? go next level
		yield(get_tree().create_timer(0.25), "timeout") # pause for end-arrow-sound
		Global.Angle = $player.global_rotation_degrees  # store last bow-angle
		if Global.Level < Global.Cols.size(): # more levels?
			Global.Level += 1
			# warning-ignore:return_value_discarded
			get_tree().reload_current_scene() # restart
		else: # game over!
			Global.game_over()
			get_tree().paused = true
