extends Node2D 

onready var transition = get_node("Transition Screen")
var can_play = true

func _ready():
	DataManager.current_level = "res://World Scenes/Level 1.tscn"
	DataManager.level = "1"
	if DataManager.current_audio == 0:
		can_play = true
	else:
		can_play = false
	audio_check()

func _process(delta):
	if DataManager.current_audio != 0:
		$Song.stop()


func audio_check():
	if can_play:
		$Song.play()
	else:
		$Song.stop()

func _on_KinematicBody2D_dead():
	$Song.stop()
	$Ambience.stop()
	$AnimationPlayer.play("Dissolve")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Dissolve":
		transition.transition()
