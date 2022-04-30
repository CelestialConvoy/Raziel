extends KinematicBody2D

export(PackedScene) var BALL: PackedScene = preload("res://Entity scenes/SludgeBall.tscn")

var health = 12
var knockback = 100
var velocity = Vector2()
var start_move = false

# Called when the node enters the scene tree for the first time.
func _ready():
#	$Atk_Cooldown.start()
	pass


func _physics_process(delta):
	if $RayCast2D.is_colliding():
		start_move = true
	if start_move == true:
		velocity.x = lerp(velocity.x, -20, .1)
	
	move_and_slide(velocity)


func _on_Area2D_area_entered(area):
	if area.is_in_group("Attacks"):
		health -= 1
		velocity.x += knockback
		if health <= 0:
			queue_free()


func _on_Atk_Cooldown_timeout():
	var ball = BALL.instance()
	get_tree().current_scene.add_child(ball)
	ball.global_position = self.global_position
	ball.velocity.y = -100
	$Atk_Cooldown.start()
