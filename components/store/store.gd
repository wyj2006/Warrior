class_name Store extends Node

func do(node: Node, to: Node) -> void:
	node.reparent(to)
