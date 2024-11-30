extends Node

class_name NameAttribute

@export var basic_name: String:
    get:
        return $AttributeComponent.basic_value
    set(value):
        $AttributeComponent.basic_value = value

var self_name: String:
    get:
        return $AttributeComponent.value

static func get_self_name(node: Node):
    var name_component: NameAttribute = node.get_node("NameAttribute")
    if name_component != null:
        return name_component.self_name
    return node.to_string()