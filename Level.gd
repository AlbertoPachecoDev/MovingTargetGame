# Level.gd

# Background: https://www.flickr.com/photos/29638108@N06/51690240835/in/dateposted/
# Credits: Jennifer C. www.metaphoricalplatypus.com

extends Node2D

const sprite = preload("res://Target.tscn")

var target # target-ids array

func _ready():
	target = [] # ids
	var cols = Global.Cols.duplicate() # copy array
	randomize()
	cols.shuffle() # random order
	for i in range(Global.Level): # create targets
		var obj = sprite.instance()
		var img = obj.get_node("sprite")
		obj.id = i
		img.set_texture(Global.TargetImage)
		# img.set_scale(Vector2(0.8, 0.8))
		img.set_position(Vector2(cols.pop_back(), Global.TargetWidth/2))
		target.append(i)
		add_child(obj)
