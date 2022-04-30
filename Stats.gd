extends Node

export(float) var max_health = 10
var health = max_health setget set_health



func set_health(value):
	health = value
