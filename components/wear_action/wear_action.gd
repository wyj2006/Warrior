extends Node

class_name WearAction

## 穿戴行为

## 将node存到des_node中
func wear(node: Node, bodypart: Node):
    var node_parent = node.get_parent()
    if node_parent != null:
        node_parent.remove_child(node)
    bodypart.add_child(node)
    node.owner = bodypart
    if node is Node2D:
        node.position = Vector2(0, 0)

func _ready() -> void:
    $ActionComponent.can_be_done = func(obj):
        return obj.get_node_or_null("Wearable") != null
    $ActionComponent.has_been_done = func(obj):
        var wearable: Wearable = obj.get_node_or_null("Wearable")
        return wearable != null and wearable.worn
    $ActionComponent.get_available_action = func(obj):
        var available_actions = {}
        for bodypart_component in get_parent().find_children("BodypartComponent"):
            if obj.get_node_or_null("BodypartComponent") == bodypart_component: # 自己穿自己
                continue
            var bodypart = bodypart_component.get_parent()
            var action_name = "穿在 " + NameAttribute.get_self_name(bodypart) + " 上"
            available_actions[action_name] = func():
                wear(obj, bodypart)
        return available_actions