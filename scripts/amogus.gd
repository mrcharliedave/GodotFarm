extends CharacterBody2D


@export var movement_speed = 200

var dead = false


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
	dead = true
	
	$AnimatedSprite2D.play("die")
	rotate(PI)
	
	await get_tree().create_timer(2).timeout
	
	queue_free()
