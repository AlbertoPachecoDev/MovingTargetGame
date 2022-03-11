# target_sprite.gd

extends Sprite

signal kill(id)

func _input(event): # sprite clicked: https://www.youtube.com/watch?v=Om7JzfU_plw
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT: # click?
		if get_rect().has_point(to_local(event.position)): # sprite clicked?
			Global.Score += 100 # winning points
			queue_free() # remove sprite
			emit_signal("kill", get_parent().id)
