extends Sprite

var can_interact = false
var text_id = "Prisoner"
var disabled = false

func _ready():
	if DataManager.scene_change == "New Game":
		disabled = false
		DataManager.prison_gate_open = false
		DataManager.data["Entities"][name] = disabled
		DataManager.save_data()
	if DataManager.data["Entities"].has(name):
		disabled = DataManager.data["Entities"][name]
	else:
		disabled = false


func _process(delta):
	if DataManager.prison_gate_open:
		$ProximityBox.monitoring = true
		disabled = false
		text_id = "Prisoner_alt"
	npc_interaction()

func _on_ProximityBox_area_entered(area):
	if area.is_in_group("Player"):
		if !disabled:
			can_interact = true
			$Label.visible = true


func npc_interaction():
	if can_interact == true:
		if !disabled:
			if Input.is_action_just_pressed("ui_accept"):
				TextManager.change_text(text_id)
				TextManager.interacting = true


func _on_ProximityBox_area_exited(area):
	can_interact = false
	TextManager.text_queue.clear()
	$Label.visible = false


func _on_PrisonerDialogueChange_disable():
	disabled = true
	$ProximityBox.monitoring = false
	DataManager.data["Entities"][name] = disabled
	DataManager.save_data()


func _on_PrisonerQueue_OutOfFrame():
	queue_free()
