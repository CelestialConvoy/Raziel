extends Node

onready var button_sound = $ButtonPressed
onready var fade_out = get_node("Transition Screen")

var button_type

func _ready():
	$MarginContainer/VBoxContainer/Resume.grab_focus()
	if DataManager.has_data == false:
		$MarginContainer/VBoxContainer/Resume.disabled = true

#func _physics_process(delta):
#	if $MarginContainer/VBoxContainer/Resume.is_hovered() == true:
#		$MarginContainer/VBoxContainer/Resume.grab_focus()

func _on_Resume_pressed():
	$MarginContainer/VBoxContainer/Resume.disabled = true
	$MarginContainer/VBoxContainer/NewGame.disabled = true
	$MarginContainer/VBoxContainer/Credits.disabled = true
	$MarginContainer/VBoxContainer/Quit.disabled = true
	DataManager.scene_change = "Continue"
	button_type = "Continue"
	button_sound.play()
	$Delay.start()

func _on_NewGame_pressed():
	$MarginContainer/VBoxContainer/Resume.disabled = true
	$MarginContainer/VBoxContainer/NewGame.disabled = true
	$MarginContainer/VBoxContainer/Credits.disabled = true
	$MarginContainer/VBoxContainer/Quit.disabled = true
	DataManager.scene_change = "New Game"
	button_type = "New Game"
	button_sound.play()
	$Delay.start()


func _on_Credits_pressed():
	$MarginContainer/VBoxContainer/Resume.disabled = true
	$MarginContainer/VBoxContainer/NewGame.disabled = true
	$MarginContainer/VBoxContainer/Credits.disabled = true
	$MarginContainer/VBoxContainer/Quit.disabled = true
	button_type = "Credits"
	button_sound.play()
	$Delay.start()


func _on_Quit_pressed():
	$MarginContainer/VBoxContainer/Resume.disabled = true
	$MarginContainer/VBoxContainer/NewGame.disabled = true
	$MarginContainer/VBoxContainer/Credits.disabled = true
	$MarginContainer/VBoxContainer/Quit.disabled = true
	button_type = "Quit"
	button_sound.play()
	$Delay.start()


func _on_Transition_Screen_transitioned():
	if button_type == "Continue":
		get_tree().change_scene("res://World Scenes/Level 1.tscn")
	if button_type == "New Game":
		get_tree().change_scene("res://Menu Scenes/Name_Input.tscn")
	if button_type == "Credits":
		get_tree().change_scene("res://Menu Scenes/Credits.tscn")
	if button_type == "Quit":
		get_tree().quit()


func _on_Delay_timeout():
	$AnimationPlayer.play("fade")
	fade_out.transition()
