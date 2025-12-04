class_name Storable extends Node

## CollisionShape2D 或 CollisionPolygon2D
@export var collision: Node2D = null

func _ready() -> void:
	if collision != null:
		add_child(collision.duplicate())