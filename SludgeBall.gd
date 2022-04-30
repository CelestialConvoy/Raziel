extends KinematicBody2D


var velocity = Vector2()
var rand_veloc = rand_range(-100, -300)

func _ready():
	randomize()

func _physics_process(delta):
	velocity.y += 10
	if velocity.y >= 250:
		velocity.y = 250
	velocity.x = lerp (rand_veloc, 0, .05)

	velocity = move_and_slide(velocity)


func _on_Area2D_area_entered(area):
	queue_free()


func _on_Area2D_body_entered(body):
	queue_free()
