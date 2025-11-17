extends Node2D

var WallScene = preload("res://entities/wall/wall.tscn")

func _ready() -> void:
	for i in range(10):
		var wall = WallScene.instantiate()
		wall.position = Vector2(randi_range(-100, 100), randi_range(-100, 100))
		add_child(wall)
