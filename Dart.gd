extends KinematicBody2D


var velocity = Vector2()
var direction = 1

func _physics_process(delta):
	velocity.x = 100 * direction
	$Area2D/Sprite.scale.x = -direction
	
	move_and_slide(velocity)
