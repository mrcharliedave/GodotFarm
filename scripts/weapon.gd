extends Tool

class_name Weapon


var damage = 1
var cooldown = 1
var attack_arc = 45
var attack_length = 2


func _use():
	# Get player facing direction
	var attack_direction = _get_owner().get_forward_direction()
	print(attack_direction)
	
	# Find enemies in attack wedge
	var enemies_in_wedge
	for enemy in globals.find_nodes_by_class($mobContainer, "Mob"):
		if(!enemy._is_dead()):
			if(globals.is_in_cone(_get_owner().position, attack_length * attack_direction, attack_arc, enemy)):
				enemies_in_wedge.append(enemy)
	
	# Deal damage to everything in wegde
	for enemy in enemies_in_wedge:
		_apply_damage(enemy)
		if(!enemy._is_dead()):
			_apply_effect(enemy)


func _apply_damage(enemy):
	enemy.update_health(damage)


func _apply_effect(enemy):
	pass
