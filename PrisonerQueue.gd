extends Area2D



signal OutOfFrame

func _on_PrisonerQueue_area_entered(area):
	if area.is_in_group("Player"):
		if DataManager.prison_gate_open:
			emit_signal("OutOfFrame")
