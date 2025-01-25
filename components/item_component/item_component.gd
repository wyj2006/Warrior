extends Node

class_name ItemComponent

func get_item_path() -> Array:
	var path = []
	var p = self.get_parent()
	while p != null:
		var item_component = p.get_node_or_null("ItemComponent")
		if item_component != null:
			path.insert(0, item_component)
		p = p.get_parent()
	return path