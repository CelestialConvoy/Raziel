extends KinematicBody2D

const UP = Vector2(0, -1)


var ACCELERATION = StatsManager.ACCELERATION
var MAX_FALL_SPEED = StatsManager.MAX_FALL_SPEED
var GRAVITY = StatsManager.GRAVITY
var JUMP_FORCE = StatsManager.JUMP_FORCE
var DODGE_FORCE = StatsManager.DODGE_FORCE
var max_health = StatsManager.max_health
var MAX_SPEED = StatsManager.MAX_SPEED
var knockback = StatsManager.knockback
var friction_force = StatsManager.friction_force
var damage = StatsManager.damage
var defense = StatsManager.defense

var velocity = Vector2()
var direction = 1
var facing_right = true
var on_ground = false
var current_health = max_health
var is_attacking = false
var attack_cooldown_check = true
var is_dodging = false
var dodge_cooldown_check = true
var is_moving = false
var is_crouching = false
var is_hit = false
var is_dead = false
var can_dodge = true
var can_move = true
var input_vector = velocity
var game_over = false
var start_position = Vector2(-274, -543)
var checkpoint_position = Vector2(-274, -543)
var journal_open = false
var controllable = true
var key_count = 0
var can_interact = false


var life_count = 2

var player_data = {}

var abilities = {
	air_dodge = StatsManager.abilities.air_dodge
}

var current_state

enum state {
	IDLE,
	MOVRIGHT,
	MOVLEFT,
	JUMPING,
	ATTACKING,
	DODGING,
	CROUCHING,
	WALLJUMP,
	WALLSLIDE,
	HIT
}


onready var attack_timer = get_node("Attack_Cooldown")
onready var dodge_timer = get_node("Dodge_Cooldown")
onready var hit_timer = get_node("Invincibility_Cooldown")
onready var animation = $AnimationPlayer
onready var punchBox = $PunchBox/HitBox

signal scene_change
signal dead
signal respawn

func _ready():
	load_data()
	position = checkpoint_position
	if current_health <= 0:
		current_health = max_health

func load_data():
	if DataManager.scene_change == "New Game":
		checkpoint_position = start_position
		game_over = false
		life_count = 2
		StatsManager.reset()
		save_data()
	if DataManager.scene_change == "Continue":
		player_data = DataManager.data["Entities"][name]
		life_count = player_data["lives"]
		current_health = player_data["Health"]
		checkpoint_position = player_data["Checkpoint"]
		key_count = player_data["Keys"]
		print(checkpoint_position)
		StatsManager.abilities = player_data["Abilities"]
	if DataManager.scene_change == "Respawn":
		player_data = DataManager.data["Entities"][name]
		life_count = player_data["lives"]
		current_health = max_health
		checkpoint_position = player_data["Checkpoint"]
		StatsManager.abilities = player_data["Abilities"]
		key_count = player_data["Keys"]
	if DataManager.scene_change == "GameOver":
		player_data = DataManager.data["Entities"][name]
		life_count = 2
		current_health = max_health
		checkpoint_position = player_data["Checkpoint"]
		StatsManager.abilities = player_data["Abilities"]
		key_count = player_data["Keys"]

func save_data():
	player_data = {
		"Health": current_health,
		"lives": life_count,
		"Checkpoint": checkpoint_position,
		"Abilities": StatsManager.abilities,
		"Keys": key_count
	}
	DataManager.data["Entities"][name] = player_data
	DataManager.save_data()


func _physics_process(_delta):
	player_movement()
	key_check()
	health_status()
	stats_check()
	life_count()
	squish_detect()


func change_state(next_state):
	current_state = next_state
	match current_state:
		state.IDLE:
			is_moving = false
			if on_ground && is_attacking == false && is_dodging == false:
				animation.play("Idle")
		state.MOVRIGHT:
			right()
		state.MOVLEFT:
			left()
		state.JUMPING:
			velocity.y = JUMP_FORCE
		state.ATTACKING:
			is_attacking = true
			animation.play("Punch_Right")
		state.DODGING:
			can_dodge = false
			velocity.y = 0
			$Dodge.play()
			is_dodging = true
			StatsManager.can_attack = false
			velocity.x = 300 * direction
			animation.play("Dodge")
		state.WALLJUMP:
			velocity.x = -150 * direction
			velocity.y = JUMP_FORCE
			can_dodge = true
		state.WALLSLIDE:
			velocity.y = 50
			animation.play("Wall_Grab")
			can_dodge = false
			is_dodging = false
		state.HIT:
			can_dodge = false
			animation.play("Hurt")


func stats_check():
	ACCELERATION = StatsManager.ACCELERATION
	MAX_FALL_SPEED = StatsManager.MAX_FALL_SPEED
	GRAVITY = StatsManager.GRAVITY
	JUMP_FORCE = StatsManager.JUMP_FORCE
	DODGE_FORCE = StatsManager.DODGE_FORCE
	max_health = StatsManager.max_health
	MAX_SPEED = StatsManager.MAX_SPEED
	knockback = StatsManager.knockback
	friction_force = StatsManager.friction_force
	damage = StatsManager.damage
	defense = StatsManager.defense

func life_count():
	$LifeCounter/LifeCount.text = str(life_count)

func player_movement():
	if is_dodging == false:
		velocity.y += GRAVITY
		if velocity.y > MAX_FALL_SPEED:
			velocity.y = MAX_FALL_SPEED
	if controllable: #Prevents all of the following code from executing if the player dies
		var _friction = false
		$Sprite.scale.x = direction
		if facing_right == true:
			$PunchBox.rotation_degrees = 0
#			$Right.position.x = -3
			$Left.position.x = 5
		else:
			$PunchBox.rotation_degrees = 180
#			$Right.position.x = 3
			$Left.position.x = -5
		
		if Input.is_action_just_pressed("Journal"):
			if journal_open:
				journal_open = false
			else:
				journal_open = true
		
		if journal_open:
			can_dodge = false
			can_move = false
		else:
			can_move = true
			can_dodge = true
		
		
		if Input.is_action_pressed("ui_right") && can_move == true:
			right()
		elif Input.is_action_pressed("ui_left") && can_move == true:
			left()
		else:
			is_moving = false
			if on_ground && is_attacking == false && is_dodging == false:
				animation.play("Idle")
			if is_dodging == false:
				_friction = true
		
		if is_on_floor():
			if $Attacks/Cooldown.get_time_left() > 0:
				StatsManager.can_attack = false
			else:
				StatsManager.can_attack = true
				
			if is_on_wall():
				if is_attacking == false && is_dodging == false:
					animation.play("Idle")
			if is_dodging == false:
				can_dodge = true
			on_ground = true
			attack()
			dodge(_friction)
			jump(_friction)
		else:
			StatsManager.can_attack = false
			on_ground = false
			if _friction == true && is_dodging == false:
				velocity.x = lerp(velocity.x, 0, 0.025)
			in_air()
			wall_jump()
		
	velocity = move_and_slide(velocity, UP)

func right():
	if is_attacking == false && is_dodging == false:
		is_moving = true
		velocity.x = min(velocity.x + ACCELERATION, MAX_SPEED)
		facing_right = true
		direction = 1
		if on_ground == true:
			animation.play("Run_Right")


func left():
	if is_attacking == false && is_dodging == false:
		is_moving = true
		velocity.x = max(velocity.x - ACCELERATION, -MAX_SPEED)
		facing_right = false
		direction = -1
		if on_ground == true:
			animation.play("Run_Right")


func jump(friction):
	if is_attacking == false && is_dodging == false:
		if Input.is_action_just_pressed("ui_up") && is_dodging == false:
			velocity.y = JUMP_FORCE
	if friction == true:
		velocity.x = lerp(velocity.x, 0, 0.15)


func in_air():
	if StatsManager.abilities.air_dodge == true:
		if can_dodge == true:
			if Input.is_action_just_pressed("Dodge"):
				can_dodge = false
				dodge_timer.start()
				change_state(state.DODGING)
	if velocity.y < 0 && is_attacking == false && is_dodging == false:
		animation.play("Jump")
	elif velocity.y > -80 && velocity.y < 0:
		animation.play("Jump_2")
	if is_dodging == false && is_attacking == false && is_crouching == false:
		animation.play("Fall")


func wall_jump():
	if is_on_wall() && is_moving == true && velocity.y >= 0:
		change_state(state.WALLSLIDE)
		if Input.is_action_just_pressed("ui_up"):
			change_state(state.WALLJUMP)


func attack():
	if StatsManager.is_attacking == true:
		can_move = false
		$Right.emitting = true
	else:
		can_move = true
		$Right.emitting = false
		$Left.emitting = false
	if Input.is_action_just_pressed("attack"):
		if StatsManager.can_attack == true:
#			StatsManager.can_attack = false
			$Right.emitting = true
#			$Left.emitting = true
#			$Attack_Cooldown.start()
			velocity.x = lerp(velocity.x, 0, 0.08)


func dodge(_friction):
	if Input.is_action_just_pressed("Dodge") && can_dodge == true && is_attacking == false && dodge_cooldown_check == true && !is_on_wall():
		$HurtBox/HurtBox.monitoring = false
		$Dodge_Cooldown.start()
		change_state(state.DODGING)

func dead():
	emit_signal("dead")
	controllable = false
	is_dead = true
	life_count -= 1
	set_deferred("$HurtBox/HurtBox/CollisionShape2D.disabled", true)
	if $Death_Sound.playing == false:
		$Death_Sound.play()
	if life_count >= 0:
		game_over = false
	else:
		game_over = true
	save_data()


func health_status():
	if current_health/max_health == 1:
		$HealthBar/HealthStatus.play("Full")
	elif current_health/max_health > .8:
		$HealthBar/HealthStatus.play("90%")
	elif current_health/max_health > .7:
		$HealthBar/HealthStatus.play("80%")
	elif current_health/max_health > .6:
		$HealthBar/HealthStatus.play("70%")
	elif current_health/max_health > .5:
		$HealthBar/HealthStatus.play("60%")
	elif current_health/max_health > .4:
		$HealthBar/HealthStatus.play("50%")
	elif current_health/max_health > .3:
		$HealthBar/HealthStatus.play("40%")
	elif current_health/max_health > .2:
		$HealthBar/HealthStatus.play("30%")
	elif current_health/max_health > .1:
		$HealthBar/HealthStatus.play("20%")
	elif current_health/max_health > 0:
		$HealthBar/HealthStatus.play("10%")
	else:
		$HealthBar/HealthStatus.play("Empty")


func hit():
	if is_hit == false && is_dead == false:
		$Hit.play()
		change_state(state.HIT)
#		set_deferred("$HurtBox/HurtBox/CollisionShape2D.disabled", true)
		$HurtBox/HurtBox.monitoring = false
		$HurtBox.position.y = 1000
		current_health -= damage
		is_hit = true
		is_attacking = false
		hit_timer.start()
		velocity.x = knockback * direction
		velocity.y = knockback 
		save_data()
	if current_health <= 0:
			dead()

func squish_detect():
	if $SquishDetect.is_colliding() || $SquishDetect2.is_colliding() || $SquishDetect3.is_colliding() || $SquishDetect4.is_colliding():
		$SquishDetect.enabled = false
		$SquishDetect2.enabled = false
		$SquishDetect3.enabled = false
		$SquishDetect4.enabled = false
		current_health = 0
		hit()

func key_check():
	if can_interact:
		if Input.is_action_just_pressed("ui_accept") && key_count > 0:
			DataManager.prison_gate_open = true
			key_count -= 1
	if key_count < 1:
		$Key/Sprite.visible = false


func _on_AnimationPlayer_animation_finished(current_animation):
	if current_animation == "Punch_Right":
		is_attacking = false
		attack_timer.start()
		attack_cooldown_check = false
	if current_animation == "Dodge":
#		StatsManager.can_attack = true
		$HurtBox/HurtBox.monitoring = true
#		$HurtBox.position.x = 0
		dodge_timer.start()
		can_move = true
		set_collision_mask_bit(3, true)
		dodge_cooldown_check = false
		is_dodging = false
		velocity.x = lerp(velocity.x, 0, 0.5)


func _on_Dodge_Cooldown_timeout():
	dodge_cooldown_check = true
	can_dodge = true


func _on_Attack_Cooldown_timeout():
	attack_cooldown_check = true
#	StatsManager.can_attack = true


func _on_Invincibility_Cooldown_timeout():
	if is_dead == true:
		$HurtBox/HurtBox/CollisionShape2D.disabled = true
	else:
		is_hit = false
#		$HurtBox/HurtBox/CollisionShape2D.disabled = false
		$HurtBox.position.y = -6
		$HurtBox/HurtBox.monitoring = true
#		$HurtBox/HurtBox.monitorable = true

func _on_Death_Sound_finished():
	if game_over == false:
		DataManager.scene_change = "Respawn"
		emit_signal("respawn")
		get_tree().reload_current_scene()
	else:
		emit_signal("scene_change")
		get_tree().change_scene("res://Menu Scenes/DeathScreen.tscn")


func _on_HurtBox_area_entered(area):
	if area.is_in_group("1 Damage"):
		damage = 1/defense
		hit()
	if area.is_in_group("2 Damage"):
		damage = 2/defense
		hit()
	if area.is_in_group("Hazard"):
		damage = 1/defense
		hit()
	if area.is_in_group("Sewage"):
		damage = 5/defense
		hit()
	if area.is_in_group("ExtraLife"):
		life_count += 1
	if area.is_in_group("checkpoint"):
		checkpoint_position = position
		print(checkpoint_position)
		save_data()
	if area.is_in_group("Abilities"):
		save_data()
	if area.is_in_group("DisableInput"):
		controllable = false
		velocity.x = 0
	if area.is_in_group("EnableInput"):
		controllable = true
	if area.is_in_group("Key"):
		key_count += 1
		$Key/Sprite.visible = true
	if area.is_in_group("Gate"):
		can_interact = true
