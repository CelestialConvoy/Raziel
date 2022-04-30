extends CanvasLayer

signal transitioned
signal faded_in

func transition():
	$ColorRect.visible = true
	$AnimationPlayer.play("Fade_to_black")

func fade_in():
	$ColorRect.visible = true
	$AnimationPlayer.play("Fade_to_normal")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Fade_to_black":
		emit_signal("transitioned")
	if anim_name == "Fade_to_normal":
		$ColorRect.visible = false
		emit_signal("faded_in")
