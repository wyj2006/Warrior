extends Node

## 属性的贡献者

class_name AttributeContributor

## 如何将值贡献到其它节点
enum ContributeMode {
    POST_ADD, ## 加在后面
    POST_SUB, ## 减在后面
    POST_MUL, ## 乘在后面
    POST_DIV, ## 除在后面
    PRE_ADD, ## 加在前面
    PRE_SUB, ## 减在前面
    PRE_MUL, ## 乘在前面
    PRE_DIV, ## 除在前面
}

@export var contribute_mode: ContributeMode = ContributeMode.POST_ADD
@export var attribute: Node
@export var source: Node
## 处理得到的值
var value_process: Callable = func(x): return x

var value:
    get:
        return value_process.call(attribute.get_node("AttributeComponent").value)

var attr_id:
    get:
        return attribute.get_node("AttributeComponent").id