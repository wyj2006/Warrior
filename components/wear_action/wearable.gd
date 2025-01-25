extends Node

class_name Wearable

## 与BodypartComponent的wearable_ids对应
@export var id: String = ""

var worn:
	get:
		return get_parent().get_parent().get_node_or_null("BodypartComponent") != null