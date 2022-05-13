extends Node2D


var direction = 1


func _ready():
	$Cooldown.start()
	visible = false

func _physics_process(delta):
	if Input.is_action_just_pressed("attack") && StatsManager.can_attack == true:
		StatsManager.can_attack = false
		StatsManager.is_attacking = true
		visible = true
		$CPUParticles2D.emitting = true
		$AnimationPlayer.play("Whip")
	if Input.is_action_just_pressed("ui_right") && StatsManager.is_attacking == false:
		$Sprite.scale.x = 1
		$CPUParticles2D.position.x = -26
		position.x = 43
		direction = 1
	elif Input.is_action_just_pressed("ui_left") && StatsManager.is_attacking == false:
		$Sprite.scale.x = -1
		$CPUParticles2D.position.x = 26
		position.x = -43
		direction = -1


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Whip":
		$Cooldown.start()
		visible = false
		StatsManager.is_attacking = false


func _on_Cooldown_timeout():
	StatsManager.can_attack = true
