extends Node

class_name WearAction

## 穿戴行为

##可以被穿
static func can_be_wore(doer: Node, node: Node):
    if node.get_node_or_null("Wearable") == null:
        return false
    var pick_action: PickAction = doer.get_node_or_null("PickAction")
    if PickAction.can_be_picked(node) and pick_action == null: # 可以被捡却无法捡(没有拾取组件)
        return false
    return true

##可以穿
static func can_wear(node: Node):
    return node.get_node_or_null("WearAction") != null and node.find_child("BodypartComponent") != null

## 将node存到des_node中
func wear(node: Node, bodypart: Node):
    if PickAction.can_be_picked(node):
        #follow_action就是这段函数的后面一部分
        $"../PickAction".pick(node, func(_x): pass )

    var node_parent = node.get_parent()
    if node_parent != null:
        node_parent.remove_child(node)
    bodypart.add_child(node)
    node.owner = bodypart