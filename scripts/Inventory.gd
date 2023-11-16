extends Node


var items : Array
var equipped_item = -1


func give_item(item : GameItem):
	item._set_owner(get_parent().name)
	items.append(item)


func update_equipped_item():
	pass


func equip_item(index):
	equipped_item = index
	update_equipped_item()


func use_equipped_item():
	if(equipped_item >= 0 && equipped_item < items.size()):
		items[equipped_item]._use()
