extends Area2D


export var text = ""
export var text2 = ""
export var text3 = ""
export var text4 = ""

var can_interact = false

func _process(_delta):
	npc_interaction()


func _on_Sign_area_entered(_area):
	if _area.is_in_group("Player"):
		can_interact = true
		$Label.visible = true

func npc_interaction():
	if can_interact == true:
		if Input.is_action_just_pressed("ui_accept"):
			get_tree().paused = true
			TextManager.queue_text(text)
			TextManager.speaker_name = ""
			TextManager.interacting = true
#			can_interact = false


func _on_Sign_area_exited(_area):
	can_interact = false
	$Label.visible = false
	TextManager.text_queue.clear()
