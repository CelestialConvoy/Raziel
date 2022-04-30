extends CanvasLayer


var paused = false
var is_fullscreen = false
var data = {}


func _ready():
#	load_data()
	paused = false
	$ColorRect.visible = false
	$MarginContainer.visible = false

func _physics_process(_delta):
	pause_unpause()

func pause_unpause():
	if Input.is_action_just_pressed("ui_cancel"):
		if get_tree().paused == false:
			$ColorRect.visible = true
			$MarginContainer.visible = true
			get_tree().paused = true
		else:
			$ColorRect.visible = false
			$MarginContainer.visible = false
			$Settings.visible = false
			get_tree().paused = false

func _on_Resume_pressed():
	$ColorRect.visible = false
	$MarginContainer.visible = false
	paused = false
	get_tree().paused = false

func _on_Quit_pressed():
	get_tree().change_scene("res://Menu Scenes/Main Menu.tscn")
	get_tree().paused = false

func _on_Settings_pressed():
	$MarginContainer.visible = false
	$Settings.visible = true

func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(1, value)

func _on_HSlider2_value_changed(value):
	AudioServer.set_bus_volume_db(2, value)

func _on_CheckBox_pressed():
	if is_fullscreen == false:
		OS.set_window_fullscreen(true)
		is_fullscreen = true
		save_data()
	else:
		OS.set_window_fullscreen(false)
		is_fullscreen = false
		save_data()

func save_data():
	data = {
		"Music": $Settings/VBoxContainer/HSlider.value,
		"Sfx": $Settings/VBoxContainer/HSlider2.value,
		"Fullscreen": is_fullscreen
	}
	DataManager.data["Settings"][name] = data

func load_data():
	if DataManager.data["Settings"].has(name):
		data = DataManager.data["Settings"][name]
		$Settings/VBoxContainer/HSlider.value = data["Music"]
		$Settings/VBoxContainer/HSlider2.value = data["Sfx"] 
		is_fullscreen = data["Fullscreen"]
