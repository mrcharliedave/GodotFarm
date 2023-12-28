extends Node


var items : Array
var equipped_item_idx = -1


func give_item(item : GameItem):
	item._set_owner(get_parent().name)
	items.append(item)


func update_equipped_item():
	pass


func equip_item(index):
	equipped_item_idx = index
	update_equipped_item()


func get_energy_use_of_equipped_item():
	if(equipped_item_idx >= 0 && equipped_item_idx < items.size()):
		return items[equipped_item_idx]._get_use_cost()
	return 0


func can_use_equipped_item(energy):
	return energy >= get_energy_use_of_equipped_item()


func use_equipped_item():
	if(equipped_item_idx >= 0 && equipped_item_idx < items.size()):
		return items[equipped_item_idx]._use()
	return false
