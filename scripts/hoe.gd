extends Tool


class_name Hoe


func _use():
	
	var owner = _get_owner()
	var map = owner.get_tree().current_scene.get_node("map")
	var mapLocation = map.local_to_map(map.to_local(owner.get_global_mouse_position()))
	
	map.set_cell(0, mapLocation, 0, Vector2i(4,2))
	return true
