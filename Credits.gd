extends Node


var scroll = ["Start", "Art", "Programming", "Story", "Music", "Game Design"]

var scroll_num = 0

onready var transition = get_node("Transition Screen")

#func _ready():
#	$AnimationPlayer.play(scroll[scroll_num])
#	$Hold.start()

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		transition.transition()
		$AnimationPlayer.play("FadeAudio")


func _on_Hold_timeout():
	if scroll_num < 5:
		scroll_num += 1
		$AnimationPlayer.play(scroll[scroll_num])
		$Hold.start()


func _on_Transition_Screen_transitioned():
	get_tree().change_scene("res://Menu Scenes/Main Menu.tscn")


func _on_Transition_Screen_faded_in():
	$AudioStreamPlayer.play()
	$AnimationPlayer.play(scroll[scroll_num])
	$Hold.start()
