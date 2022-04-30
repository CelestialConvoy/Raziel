extends Node2D

var timeouts = 0

onready var transition = get_node("Transition Screen")

func _ready():
	$CanvasLayer2/Sprite.visible = false




func _on_Transition_Screen_faded_in():
	$Duration.start()


func _on_Duration_timeout():
	timeouts += 1
	transition.transition()


func _on_Transition_Screen_transitioned():
	if timeouts == 1:
		$CanvasLayer/Sprite.visible = false
		$CanvasLayer2/Sprite.visible = true
		transition.fade_in()
	else:
		get_tree().change_scene("res://Menu Scenes/Main Menu.tscn")
