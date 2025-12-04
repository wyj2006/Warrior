class_name DisplayName extends Node

@export var base_name = ""
@export var adjectives: Array[String] = []
@export var adverbs: Array[String] = []

var full_name:
	get:
		return " ".join(adverbs) + " ".join(adjectives) + base_name

static func get_full(node: Node, default = null) -> String:
	var display_name = node.get_node_or_null("DisplayName")
	if display_name == null:
		display_name = node.get("display_name")
		if display_name == null:
			return default
		return display_name
	return display_name.full_name

static func set_base(node: Node, val: String) -> void:
	var display_name = node.get_node_or_null("DisplayName")
	if display_name == null:
		node.set("display_name", val)
		return
	display_name.base_name = val