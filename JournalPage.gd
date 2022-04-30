extends Area2D

export var page_num = 0
export var text = ""
export var text2 = ""

var can_interact = false
var collected

func _ready():
	if DataManager.scene_change == "New Game":
		DataManager.data["Objects"][name] = false
	if DataManager.scene_change == "Continue" || DataManager.scene_change == "Respawn" || DataManager.scene_change == "GameOver":
		if DataManager.data["Objects"].has(name):
			collected = DataManager.data["Objects"][name]
	if collected == true:
		queue_free()

func _physics_process(delta):
	interact()


func interact():
	if can_interact == true:
		if Input.is_action_just_pressed("ui_accept"):
			collected = true
			DataManager.data["Objects"][name] = true
			JournalEntries.entry_left[page_num] = text
			JournalEntries.entry_right[page_num] = text2
			monitorable = false
			monitoring = false
			$Sprite.visible = false
			$CanvasLayer/Popup.visible = true
			$CanvasLayer/TextFade.start()
			

func _on_JournalPage_area_entered(area):
	if area.is_in_group("Player"):
		can_interact = true
		$Label.visible = true


func _on_JournalPage_area_exited(area):
	can_interact = false
	$Label.visible = false


func _on_TextFade_timeout():
	$CanvasLayer/Popup.visible = false
	
