extends Area2D


var item_ID = ItemManager.item_ID.AIRDODGE

func _ready():
	if StatsManager.abilities.air_dodge == true:
		queue_free()


func _on_Area2D_area_entered(area):
	ItemManager.item_ID(item_ID)
	TextManager.change_text("Airdodge")
	TextManager.interacting = true
	queue_free()
