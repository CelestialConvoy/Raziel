extends Area2D


var point_reached = false




#func _ready():
#	if DataManager.data["Checkpoints"].has(name):
#		point_reached = DataManager.data["Checkpoints"][name]

func _on_Checkpoint_area_entered(area):
	if area.is_in_group("Player"):
		if point_reached == false:
			point_reached = true
			$AudioStreamPlayer2D.play()
			$AnimationPlayer.play("Checked")
			$CPUParticles2D.emitting = true
#			set_collision_mask_bit(1, false)
#			set_collision_layer_bit(0, false)
#			$ColorRect.visible = false
#		DataManager.data["Checkpoints"][name] = point_reached
#		DataManager.save_data()


