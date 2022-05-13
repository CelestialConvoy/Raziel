extends CanvasLayer

const CHAR_READ_RATE = 0.05

onready var textbox_container = $TextBoxContainer
onready var start_symbol = $TextBoxContainer/MarginContainer/HBoxContainer/Start
onready var end_symbol = $TextBoxContainer/MarginContainer/HBoxContainer/End
onready var label = $TextBoxContainer/MarginContainer/HBoxContainer/Label

enum State {
	READY,
	READING,
	FINISHED
}

var current_state


func _ready():
	hide_textbox()
	

func _process(delta):
	if TextManager.interacting == true:
		get_tree().paused = true
		change_state(State.READY)
		TextManager.interacting = false
	match current_state:
		State.READY:
			if !TextManager.text_queue.empty():
				display_text()
			else:
				hide_textbox()
				change_state(State.FINISHED)
				get_tree().paused = false
		State.READING:
			if Input.is_action_just_pressed("ui_accept"):
				label.percent_visible = 1.0
				$Tween.remove_all()
				end_symbol.text = "Enter"
				$AudioStreamPlayer.stop()
				change_state(State.FINISHED)
		State.FINISHED:
			$AudioStreamPlayer.stop()
			if Input.is_action_just_pressed("ui_accept"):
				change_state(State.READY)


func hide_textbox():
	start_symbol.text = ""
	end_symbol.text = ""
	label.text = ""
	TextManager.interacting = false
	TextManager.text_queue.clear()
	textbox_container.hide()


func show_textbox():
	start_symbol.text = str(TextManager.speaker_name) + ":"
	textbox_container.show()


func display_text():
	var next_text = TextManager.text_queue.pop_front()
	label.text = next_text
	label.percent_visible = 0.0
	change_state(State.READING)
	show_textbox()
	$Tween.interpolate_property(label, "percent_visible", 0.0, 1.0, len(next_text) * CHAR_READ_RATE, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	$AudioStreamPlayer.play()


func _on_Tween_tween_completed(object, key):
	end_symbol.text = "C"
	change_state(State.FINISHED)


func change_state(next_state):
	current_state = next_state
	match current_state:
		State.READY:
			print("Changing state to: State.READY")
		State.READING:
			print("Changing state to: State.READING")
		State.FINISHED:
			print("Changing state to: State.FINISHED")
