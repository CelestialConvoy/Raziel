extends Node2D

onready var transition = get_node("Transition Screen")


func _ready():
	DataManager.current_level = "res://World Scenes/Level 1.tscn"
	DataManager.level = "1"


func _on_KinematicBody2D_dead():
	$AudioStreamPlayer.stop()
	$AnimationPlayer.play("Dissolve")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Dissolve":
		transition.transition()
