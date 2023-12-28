extends CharacterBody2D


@export var movement_speed = 300.0
@export var camera_zoom = 2.0
@export var health_max = 100
@export var health_energy = 100

var health_max_modifier = 1
var current_health = 0

var energy_max_modifier = 1
var current_energy = 0

func _ready():
	$Camera.zoom = Vector2(camera_zoom, camera_zoom)
	current_health = health_max + health_max_modifier
	
	var newHoe = Hoe.new()
	$Inventory.add_child(newHoe)
	$Inventory.give_item(newHoe)
	
	var newPick = Pickaxe.new()
	$Inventory.add_child(newPick)
	$Inventory.give_item(newPick)
	
	$Inventory.equip_item(0)


func _process(delta):
	if(current_health <= 0):
		queue_free()
	
	if(Input.is_action_just_pressed("interact")):
		interact()
	
	if(Input.is_action_just_pressed("item1")):
		$Inventory.equip_item(0)
	
	if(Input.is_action_just_pressed("item2")):
		$Inventory.equip_item(1)


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


func interact():
	$Inventory.use_equipped_item()
	#var map = get_tree().current_scene.get_node("TileMap")
	#var mapLocation = map.local_to_map(map.to_local(get_global_mouse_position()))
	
	#map.set_cell(0, mapLocation, 0, Vector2i(4,2))
