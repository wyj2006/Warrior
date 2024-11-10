extends Node

class_name PickComponent

## 拾起组件
## 用来进行拾取操作和判断是否可以拾取
## 拾取不是一个单独的行为, 它要由两个行为(包括它自己)构成一个完整的行为

## 可以被拾取
static func can_be_picked(node: Node):
    var pickable = node.get_node_or_null("Pickable")
    # 有Pickable且没有被捡起来
    return pickable != null and pickable.picked == false

##可以拾取
static func can_pick(node: Node):
    return node.get_node_or_null("PickComponent") != null

## 拾取
## 第一个参数为拾取的物品, 第二个参数为拾取后要做的事
func pick(node: Node, follow_action: Callable):
    follow_action.call(node)