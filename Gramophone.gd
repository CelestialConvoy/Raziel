extends Node2D


var can_interact = false
export var audioNum = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	if DataManager.current_audio == audioNum:
		$AudioStreamPlayer.play()


func _process(delta):
	if DataManager.current_audio != audioNum:
		$AudioStreamPlayer.stop()
#	else:
#		$AudioStreamPlayer.play()
	if can_interact:
		if Input.is_action_just_pressed("ui_accept"):
			DataManager.current_audio = audioNum
			$AudioStreamPlayer.play()
			$AnimationPlayer.play("Playing")


func _on_Area2D_area_entered(area):
	if area.is_in_group("Player"):
		can_interact = true
		$Label.visible = true


func _on_Area2D_area_exited(area):
	if area.is_in_group("Player"):
		can_interact = false
		$Label.visible = false


func _on_KinematicBody2D_dead():
	$AudioStreamPlayer.stop()
