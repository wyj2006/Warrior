class_name Common

static func clear_children(node: Node):
	while node.get_child_count() > 0:
		node.remove_child(node.get_child(0))