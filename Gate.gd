extends StaticBody2D


func _physics_process(delta):
	if DataManager.prison_gate_open:
		queue_free()
