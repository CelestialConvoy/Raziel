extends Area2D

var collected = false

func _ready():
	if DataManager.scene_change == "New Game":
		DataManager.data["Objects"][name] = false
		$AnimationPlayer.play("Default")
	if DataManager.scene_change == "Continue" || DataManager.scene_change == "Respawn" || DataManager.scene_change == "GameOver":
		if DataManager.data["Objects"].has(name):
			collected = DataManager.data["Objects"][name]
	if collected == true:
		queue_free()
	else:
		$AnimationPlayer.play("Default")
		
	print(collected)


func _on_1UP_area_entered(area):
	collected = true
	DataManager.data["Objects"][name] = collected
	DataManager.save_data()
	queue_free()
