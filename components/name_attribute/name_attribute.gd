extends Node

class_name NameAttribute

@export var basic_name: String:
    get:
        if $AttributeComponent.basic_value == null:
            $AttributeComponent.basic_value = ""
        return $AttributeComponent.basic_value
    set(value):
        $AttributeComponent.basic_value = value

var self_name: String:
    get:
        return $AttributeComponent.value

static func get_self_name(node: Node):
    if node is NameAttribute:
        return "名称"
    var name_component: NameAttribute = node.get_node_or_null("NameAttribute")
    if name_component != null:
        return name_component.self_name
    return node.to_string()
