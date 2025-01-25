extends Node

class_name StoreAction

## 存储组件

## 将node存到des_node中
func store(node: Node, container: Node):
    var node_parent = node.get_parent()
    if node_parent != null:
        node_parent.remove_child(node)
    container.add_child(node)
    node.owner = container
    if node is Node2D:
        node.position = Vector2(0, 0)

func _ready() -> void:
    $ActionComponent.can_be_done = func(obj):
        return obj.get_node_or_null("Storable") != null
    $ActionComponent.has_been_done = func(obj):
        var storable: Storable = obj.get_node_or_null("Storable")
        return storable != null and storable.stored
    $ActionComponent.get_available_action = func(obj):
        var available_actions = {}
        for container_component in get_parent().find_children("ContainerComponent"):
            if obj.get_node_or_null("ContainerComponent") == container_component: # 自己装自己
                continue
            var container = container_component.get_parent()
            var action_name = "存入 " + NameAttribute.get_self_name(container)
            available_actions[action_name] = func():
                store(obj, container)
        return available_actions