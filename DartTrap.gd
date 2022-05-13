extends KinematicBody2D

export(PackedScene) var DART: PackedScene = preload("res://Assets/Environment/Objects/Scenes/Dart.tscn")
export var dir = 1

func _physics_process(delta):
	if $RayCast2D.is_colliding():
		$RayCast2D.enabled = false
		$Timer.start()
	var dart = DART.instance()
	get_tree().current_scene.add_child(dart)
#		dart.direction = dir


func _on_Timer_timeout():
	$RayCast2D.enabled = true
