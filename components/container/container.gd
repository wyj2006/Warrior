extends Node2D


func _on_child_entered_tree(node: Node) -> void:
	if not node is Node2D:
		return
	node.position = Vector2(0, 0)
	node.hide()
