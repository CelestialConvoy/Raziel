extends Node

onready var fade_out = get_node("Transition Screen")

func _ready():
	$MarginContainer/VBoxContainer/VBoxContainer/TextureButton.grab_focus()
	$AudioStreamPlayer.play()

func _physics_process(delta):
	if $MarginContainer/VBoxContainer/VBoxContainer/TextureButton.is_hovered() == true:
		$MarginContainer/VBoxContainer/VBoxContainer/TextureButton.grab_focus()
	if $MarginContainer/VBoxContainer/VBoxContainer/TextureButton2.is_hovered() == true:
		$MarginContainer/VBoxContainer/VBoxContainer/TextureButton2.grab_focus()
	if $AudioStreamPlayer.playing == false:
		$AudioStreamPlayer.play()


func _on_TextureButton_pressed():
	fade_out.transition()
	DataManager.scene_change = "GameOver"


func _on_TextureButton2_pressed():
	fade_out.transition()
	get_tree().change_scene("res://Menu Scenes/Main Menu.tscn")

func _on_Transition_Screen_transitioned():
	get_tree().change_scene(DataManager.current_level)
