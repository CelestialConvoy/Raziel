extends Node

#var player_name
onready var button_sound = get_node("ButtonPressed")
onready var fade_out = get_node("Transition Screen")

func _on_LineEdit_text_entered(new_text):
#	DataManager.data["Setings"][name] = new_text
	button_sound.play()
	fade_out.transition()

func _on_ButtonPressed_finished():
	get_tree().change_scene("res://World Scenes/Level 1.tscn")
	
