extends CharacterBody2D


@export var movement_speed = 300.0
@export var camera_zoom = 2.0
@export var health_max = 100
@export var energy_max = 100

var health_max_modifier = 1
var current_health = 0

var energy_max_modifier = 1
var current_energy = 0

var second_counter = 0


func _ready():
	$Camera.zoom = Vector2(camera_zoom, camera_zoom)
	current_health = health_max * health_max_modifier
	current_energy = energy_max * energy_max_modifier
	
	var newHoe = Hoe.new()
	$Inventory.add_child(newHoe)
	$Inventory.give_item(newHoe)
	
	var newPick = Pickaxe.new()
	$Inventory.add_child(newPick)
	$Inventory.give_item(newPick)
	
	var newWeapon = Weapon.new()
	$Inventory.add_child(newWeapon)
	$Inventory.give_item(newWeapon)
	
	$Inventory.equip_item(0)


func _process(delta):
	if(current_health <= 0):
		queue_free()
	
	second_counter += delta
	
	if(second_counter >= 1):
		if(current_energy < energy_max * energy_max_modifier):
			current_energy = min(current_energy + 1, energy_max * energy_max_modifier)
		second_counter = 0
	
	if(Input.is_action_just_pressed("interact")):
		use_item()
	
	if(Input.is_action_just_pressed("item1")):
		$Inventory.equip_item(0)
	
	if(Input.is_action_just_pressed("item2")):
		$Inventory.equip_item(1)
	
	if(Input.is_action_just_pressed("item3")):
		$Inventory.equip_item(2)


func _physics_process(delta):
	# Handle movement input
	var movement_vec = Vector2(-Input.get_axis("right", "left"), Input.get_axis("up", "down")).normalized()
	velocity = movement_vec * movement_speed * delta

	# Handle movement animation
	update_movement_animation()

	# Call physics based location update
	move_and_slide()


func update_movement_animation():
	
	if(velocity.is_zero_approx()):
		$PlayerAnimator.play("idle")
		$PlayerAnimator.stop()
		return
	
	# This is insanely gross
	$PlayerAnimator.play(get_animation_string())


func get_animation_string():
	return "left" if velocity.x < 0 else "right" if velocity.x > 0 else "down" if velocity.y > 0 else "up" if velocity.y < 0 else "idle"


func _on_hitbox_area_entered(area):
	var collision = area.get_parent()
	
	if((collision.name == "mob" || collision.name == "amogus") && ! collision._is_dead()):
		current_health -= 1
		collision._hit_player()
		print("ouch: " + collision.name)


func get_forward_direction():
	var forward_direction = velocity.normalized()
	return forward_direction

func use_item():
	if($Inventory.can_use_equipped_item(current_energy)):
		if($Inventory.use_equipped_item()):
			current_energy -= $Inventory.get_energy_use_of_equipped_item()
		else:
			print("can't use item for some reason? r u stupid?")
	else:
		print("too tired")
