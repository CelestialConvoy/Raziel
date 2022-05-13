extends Node2D

onready var player = get_node("Player")
onready var fade_out = get_node("Transition Screen")

var can_play = true
var pos = Vector2(50,153)

func _process(delta):
	if player.is_dead == true:
		$AudioStreamPlayer.stop()

func _ready():
	if DataManager.scene_change == "Respawn":
		player.position = pos
	else:
		pass


func _on_Transition_Screen_transitioned():
	get_tree().change_scene("res://Menu Scenes/DeathScreen.tscn")


func _on_Player_scene_change():
	fade_out.transition()


func _on_Player_respawn():
	fade_out.transition()
