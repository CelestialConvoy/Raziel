extends Area2D


var item_ID = ItemManager.item_ID.SPEED


func _on_Area2D_area_entered(area):
	ItemManager.item_ID(item_ID)
	queue_free()
