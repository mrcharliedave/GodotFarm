class_name globals

static func is_in_cone(startingPoint, coneLength, coneWidth, queryPoint):
	return true;

# Eeuugghh. Brother eeuuugghhh. What's that brother? Eeeuuugghh.
static func find_nodes_by_class(rootNode, className):
	if(rootNode.is_class(className)):
		return rootNode
	var foundArray = Array()
	for child in rootNode.get_children():
		foundArray.append(find_nodes_by_class(child, className))
