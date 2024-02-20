extends CharacterBody2D


class_name Mob


@export var movement_speed = 200

@export var health = 1

var dead = false


func update_health(healthModifier):
	health += healthModifier
	on_health_change()


func on_health_change():
	if(health <= 0):
		set_dead(true)
		process_dead()


func set_dead(newDead):
	dead = newDead


func process_dead():
	if(dead):
		$AnimatedSprite2D.play("die")
		rotate(PI)
		
		await get_tree().create_timer(2).timeout
		
		queue_free()


func _is_dead():
	return dead


func _physics_process(delta):
	if(dead):
		return
	
	if(!$AnimatedSprite2D.is_playing()):
		$AnimatedSprite2D.play("move")
	
	velocity = Vector2(get_tree().current_scene.get_node("player").position - position).normalized() * movement_speed * delta

	move_and_slide()


func _hit_player():
	update_health(-1)
	# Knockback
