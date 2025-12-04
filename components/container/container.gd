extends Node3D


func _on_child_entered_tree(node: Node) -> void:
	if not node is Node3D:
		return
	node.position = Vector3.ZERO
	node.hide()

func _on_child_exiting_tree(node: Node) -> void:
	if not node is Node3D:
		return
	node.show()
