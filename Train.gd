extends KinematicBody2D


var velocity = Vector2()
var move = false

func _ready():
	$CPUParticles2D.emitting = false

func _physics_process(delta):
	if move == true:
		velocity.x = lerp(velocity.x, 300, 0.01)
		$AnimationPlayer.play("Move")
		$CPUParticles2D.emitting = true
	else:
		$CPUParticles2D.emitting = false
	
	move_and_slide(velocity)


func _on_NewGame_pressed():
	move = true


func _on_Resume_pressed():
	move = true
