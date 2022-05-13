tool
extends Node2D


export var duration : float = 1
export var move_from : Vector2 = Vector2.ZERO
export var move_to : Vector2 = Vector2.ZERO

onready var line : Node2D = $Debug_Line
onready var base : Node2D = $Platform_Base
onready var tween : Tween = $Platform_Base/Tween

var direction_forward = false


func _process(delta):
	if Engine.is_editor_hint():
		update()
	if $Platform_Base/KinematicBody2D/RayCast2D.is_colliding():
		$Platform_Base/KinematicBody2D/RayCast2D.enabled = false
		set_tween(move_from, move_to)
		

func _draw():
	if Engine.is_editor_hint():
		if line:
			draw_line(line.position + move_from, line.position + move_to, Color.lime, 2)

func set_tween(from, to):
	tween.interpolate_property(base, "position", from, to, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()


func _on_Tween_tween_completed(object, key):
	$AudioStreamPlayer.play()
