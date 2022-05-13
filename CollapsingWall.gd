extends KinematicBody2D

var MOVE = false
var velocity = Vector2()
export var direction = 1
export var speed = 200
export var vspeed = 0



func _physics_process(delta):
	if MOVE:
		velocity.y = lerp(velocity.y, vspeed * direction, 0.1)
		velocity.x = speed*direction
#		velocity.y = vspeed*direction
	else:
		velocity = Vector2.ZERO
	
	
	move_and_slide(velocity)

func _on_Area2D_area_entered(area):
	if area.is_in_group("Player"):
		yield(get_tree().create_timer(.1), "timeout")
		MOVE = true
		yield(get_tree().create_timer(.4), "timeout") 
		MOVE = false
		$Area2D.monitoring = false
#		$Timer.start()
#
#
#func _on_Timer_timeout():
#	MOVE = false
#	velocity = Vector2.ZERO
