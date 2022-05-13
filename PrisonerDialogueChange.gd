extends Area2D


signal disable


func _on_PrisonerDialogueChange_area_entered(area):
	if area.is_in_group("Player"):
		emit_signal("disable")
