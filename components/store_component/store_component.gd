extends Node

class_name StoreComponent

## 存储组件

##可以被存储
static func can_be_stored(node: Node):
    #没有Storable肯定不能被存
    if node.get_node_or_null("Storable") == null:
        return false
    #可以捡起来(说明还在地上)也不能存
    if PickComponent.can_be_picked(node):
        return false
    return true

##可以存
static func can_store(node: Node):
    return node.get_node_or_null("StoreComponent") != null and node.find_child("ContainerComponent") != null

## 将node存到des_node中
func store(node: Node, des_node: Node):
    var node_parent = node.get_parent()
    if node_parent != null:
        node_parent.remove_child(node)
    des_node.add_child(node)