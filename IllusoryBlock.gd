extends StaticBody2D





func _on_Area2D_area_entered(area):
	if area.is_in_group("Player"):
		$AnimationPlayer.play("Fade")


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
