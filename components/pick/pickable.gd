class_name Pickable extends Area3D

## CollisionShape3D 或 CollisionPolygon3D
@export var collision: Node2D = null

var picked:
	get:
		var p = get_parent()
		while p != null:
			if p.get_node_or_null("Pick") != null:
				return true
			p = p.get_parent()
		return false

func _ready() -> void:
	if collision != null:
		add_child(collision.duplicate())
