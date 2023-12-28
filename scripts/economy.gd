extends Node2D


var currentEconomy


# Called once a day at the end of the day to handle final transactions
func end_day():
	# Sell Items
	# Give Report
	pass

# Called once a day to set up the economy for the day
func start_new_day():
	# Shuffle Economy
	# Clear buffers
	currentEconomy = get_new_economy()
	pass

# Generate a dictionary of economy modifiers. Can pass in params to wieght the return value.
func get_new_economy():
	return { "Milk" : 1.2 }


# Function to check price changes on a specific item
func check_item_sale_multiplier(item_to_check):
	if(currentEconomy.has(item_to_check)):
		return currentEconomy[item_to_check]
	return 1.0

# Function to get all currently active economic modifiers
func get_current_economy():
	return currentEconomy

# Called when the node enters the scene tree for the first time.
func _ready():
	start_new_day()
