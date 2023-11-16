extends Node

class_name GameItem


var owner_id;


func _set_owner(character_owner):
	owner_id = character_owner
	

func _get_owner() -> CharacterBody2D:
	return get_tree().current_scene.get_node("player")
