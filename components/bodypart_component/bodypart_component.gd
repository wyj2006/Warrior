extends Node

class_name BodypartComponent

## 身体部位组件

## 可穿在这个身体部位的物体id
@export var wearable_ids: Array[String] = []

## 判断要穿上的物品是否有效
func is_valid(node: Node) -> bool:
    var wearable = node.get_node_or_null("Wearable")
    if wearable == null or wearable.id not in wearable_ids:
        return false
    return true