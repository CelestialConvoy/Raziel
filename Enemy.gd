extends KinematicBody2D

onready var stats = $Stats

const GRAVITY = 10
const UP = Vector2(0, -1)

var health = 10
export var SPEED = 20
export var MAX_FALL_SPEED = 250

var velocity = Vector2()
var direction = 1
var knockback = Vector2()
var active

signal damaged

func _ready():
	active = true

func _physics_process(delta):
	
	if active == true:
		knockback = knockback.move_toward(Vector2.ZERO, 10)
		knockback = move_and_slide(knockback)
		velocity.x = SPEED * direction
		velocity.y += GRAVITY
		
		if velocity.y >= MAX_FALL_SPEED:
			velocity.y = MAX_FALL_SPEED
		
		velocity = move_and_slide(velocity, UP)
		
		if is_on_wall():
			direction = direction * -1
			$Sprite.scale.x = 1 * direction

func _on_HurtBox_area_entered(area):
		if area.is_in_group("Attacks"):
			knockback.x = area.direction * area.knockback_force/2
			health -= 1
			if health < 1:
				queue_free()
#		if area.is_in_group("Player"):
#			emit_signal("damaged")


func _on_Player_dead():
	set_deferred("$HurtBox/CollisionShape2D.disabled", true)
