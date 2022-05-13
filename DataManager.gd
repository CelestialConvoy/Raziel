extends Node

const file_name = "save.data"
var data = {}
var scene_change
var current_level
var level
var is_fullscreen = false
var has_data
var prison_gate_open = false
var current_audio = 0


func _ready():
	load_data()


func load_data():
	var file = File.new()
	if file.file_exists("user://"+file_name):
		file.open("user://"+file_name, File.READ)
		data = file.get_var()
		file.close()
	else:
		has_data = false
		data = {
			"Entities": {},
			"Objects": {},
			"Settings": {},
			"Items": {},
			"Checkpoints": {}
		}


func save_data():
	has_data = true
	var file = File.new()
	var error = file.open("user://"+file_name, File.WRITE)
	if error == OK:
		file.store_var(data)
		file.close()

