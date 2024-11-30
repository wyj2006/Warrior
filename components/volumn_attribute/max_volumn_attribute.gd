extends Node

class_name MaxVolumnAttribute

@export var basic_max_volumn: float:
    get:
        if $AttributeComponent.basic_value == null:
            $AttributeComponent.basic_value = 0
        return $AttributeComponent.basic_value
    set(value):
        $AttributeComponent.basic_value = value

var max_volumn: float:
    get:
        return $AttributeComponent.value

static func get_max_volumn(node: Node):
    var max_volumn_attr: MaxVolumnAttribute = node.get_node_or_null("MaxVolumnAttribute")
    if max_volumn_attr == null:
        return INF
    return max_volumn_attr.max_volumn