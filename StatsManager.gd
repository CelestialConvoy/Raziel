extends Node



var ACCELERATION = 10
var MAX_FALL_SPEED = 250
var GRAVITY = 10
var JUMP_FORCE = -220
var DODGE_FORCE = 220
var max_health = 10.0
var MAX_SPEED = 115
var knockback = -75
var friction_force = 0.2
var damage = 1
var defense = 1.0

var can_attack = true
var is_attacking = false

var abilities = {
	air_dodge = false
}


func reset():
	ACCELERATION = 10
	MAX_FALL_SPEED = 250
	GRAVITY = 10
	JUMP_FORCE = -220
	DODGE_FORCE = 220
	max_health = 10.0
	MAX_SPEED = 115
	knockback = -75
	friction_force = 0.2
	damage = 1
	defense = 1.0
	abilities.air_dodge = false
