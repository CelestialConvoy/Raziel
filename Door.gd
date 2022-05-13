extends StaticBody2D

onready var animation = $AnimationPlayer
onready var door_smash = $DoorSmash

var is_open = 0

func _ready():
	if DataManager.scene_change == "New Game":
		pass
	elif DataManager.scene_change == "Continue":
		if DataManager.data["Objects"].has(name):
			is_open = DataManager.data["Objects"][name]
		if is_open == 1:
			$Sprite.scale.x = 1
			animation.play("Open")
			door_smash.play()
	$CollisionShape2D.disabled = false
	$Area2D/CollisionShape2D2.disabled = false
	

func _physics_process(delta):
	DataManager.data["Objects"][name] = is_open
	DataManager.save_data()


func _on_Area2D_area_entered(area):
	if area.is_in_group("Attacks"):
#		$CollisionShape2D.disabled = true
		set_deferred("$CollisionShape2D.disabled", true)
		is_open = 1
		
		if area.direction == 1:
			$Sprite.scale.x = 1
			animation.play("Open")
			door_smash.play()
		else:
			$Sprite.scale.x = -1
			$Sprite.offset.x = 28
			animation.play("Open")
			door_smash.play()
