extends Node

class_name VolumnAttribute

@export var basic_volumn: float:
    get:
        if $AttributeComponent.basic_value == null:
            $AttributeComponent.basic_value = 0
        return $AttributeComponent.basic_value
    set(value):
        $AttributeComponent.basic_value = value

var volumn: float:
    get:
        return $AttributeComponent.value

static func get_volumn(node: Node):
    var volumn_attr: VolumnAttribute = node.get_node_or_null("VolumnAttribute")
    if volumn_attr == null:
        return 0
    return volumn_attr.volumn