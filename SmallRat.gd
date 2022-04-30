extends KinematicBody2D

const UP = Vector2(0, -1)

var velocity = Vector2()
var knockback = -100
var accel = 10
var direction = 1
var max_fall = 250
var health = 2
var can_move = true

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	velocity.y += 10
	
	if velocity.y >= max_fall:
		velocity.y = max_fall
	
	if is_on_wall():
		direction = -direction
	if is_on_floor():
		can_move = true
	
	if $DetectLeft.is_colliding():
		direction = -1
	elif $DetectRight.is_colliding():
		direction = 1
	
	if !$DetectEdge.is_colliding() && is_on_floor():
		direction = -direction
	
	
	if direction == 1 && can_move == true:
		right()
	elif direction == -1 && can_move == true:
		left()
	
	$Sprite.scale.x = -direction
	
	velocity = move_and_slide(velocity, UP)

func right():
	$DetectEdge.position.x = 17
	$HitBox.position.x = 6.5
	$Area2D/HurtBox.position.x = 6.5
	$Particle.initial_velocity = -15
	$Particle.position.x = 12
	direction = 1
	velocity.x = min(velocity.x + accel, 100 )

func left():
	$DetectEdge.position.x = -17
	$HitBox.position.x = -6.5
	$Area2D/HurtBox.position.x = -6.5
	$Particle.initial_velocity = 15
	$Particle.position.x = -12
	direction = -1
	velocity.x = max(velocity.x - accel, -100 )


func _on_Area2D_area_entered(area):
	if area.is_in_group("Attacks"):
		can_move = false
		health -= 1
		velocity.x = 400 * -direction
		velocity.y = -100
		if health <= 0:
			queue_free()
