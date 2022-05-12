extends Node2D

var ai = preload("res://scenes/ai.tscn")

func spawn(amt: int):
	for i in range(amt):
		var new_ai = ai.instance()
		$ais.add_child(new_ai, true)

func _ready() -> void:
	spawn(20)
