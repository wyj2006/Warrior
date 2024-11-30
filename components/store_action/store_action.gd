extends Node

class_name StoreAction

## 存储组件

##可以被存储
static func can_be_stored(doer: Node, node: Node):
    #没有Storable肯定不能被存
    if node.get_node_or_null("Storable") == null:
        return false
    var pick_component: PickAction = doer.get_node_or_null("PickAction")
    if PickAction.can_be_picked(node) and pick_component == null: # 可以被捡却无法捡(没有拾取组件)
        return false
    return true

##可以存
static func can_store(node: Node):
    return node.get_node_or_null("StoreAction") != null and node.find_child("ContainerComponent") != null

## 将node存到des_node中
func store(node: Node, container: Node):
    if PickAction.can_be_picked(node):
        #follow_action就是这段函数的后面一部分
        $"../PickAction".pick(node, func(_x): pass )

    var node_parent = node.get_parent()
    if node_parent != null:
        node_parent.remove_child(node)
    container.add_child(node)