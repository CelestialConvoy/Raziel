extends Area2D

var direction = 1

export var knockback_force = 200

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_right"):
		direction = 1
	elif Input.is_action_just_pressed("ui_left"):
		direction = -1
