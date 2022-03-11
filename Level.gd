# Level.gd

# Background: https://www.flickr.com/photos/29638108@N06/51690240835/in/dateposted/
# Credits: Jennifer C. www.metaphoricalplatypus.com

extends Node2D

const target = preload("res://Target.tscn")

var targets # target-ids array

func _ready():
	targets = [] # ids
	var cols = Global.Cols.duplicate() # copy array
	randomize()
	cols.shuffle() # random order
	for i in range(Global.Level): # create targets
		var obj = target.instance()
		var img = obj.get_node("sprite")
		obj.id = i
		img.set_texture(Global.TargetImage)
		img.set_scale(Vector2(0.8, 0.8))
		img.set_position(Vector2(cols.pop_back(), Global.TargetWidth/2))
		targets.append(i) # contador targets
		add_child(obj)
		obj.connect("kill", self, "kill_target") # receive signal

func kill_target(id):
	targets.erase(id) # remove target
	if targets.empty(): # next level?
		if Global.Level < Global.Cols.size(): # more levels?
			Global.Level += 1
			# warning-ignore:return_value_discarded
			get_tree().reload_current_scene() # restart
		else: # game over!
			Global.game_over()
			get_tree().paused = true

	
