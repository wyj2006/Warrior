extends Node

class_name AttributeComponent

## 属性组件
## 属性有两部分组成
## 第一部分是基本值
## 第二部分是由其它相同类型的属性组件贡献的

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

var basic_value ## 基本值
@export var contribute_mode: ContributeMode = ContributeMode.POST_ADD
@export var extern_contributors: Array[Node] = [] ## 外部的贡献者
@export var id: String ## 用来区分不同的属性

##总的值
var value:
    get:
        var total_value = basic_value
        for contributor in get_contributors():
            match contributor.contribute_mode:
                ContributeMode.POST_ADD:
                    total_value = total_value + contributor.value
                ContributeMode.POST_SUB:
                    total_value = total_value - contributor.value
                ContributeMode.POST_MUL:
                    total_value = total_value * contributor.value
                ContributeMode.POST_DIV:
                    total_value = total_value / contributor.value
                ContributeMode.PRE_ADD:
                    total_value = contributor.value + total_value
                ContributeMode.PRE_SUB:
                    total_value = contributor.value - total_value
                ContributeMode.PRE_MUL:
                    total_value = contributor.value * total_value
                ContributeMode.PRE_DIV:
                    total_value = contributor.value / total_value
        return total_value

## 获取贡献者节点
## 由直属于parent的相同类型的属性和由`extern_contributors`指定的节点构成
func get_contributors() -> Array[AttributeComponent]:
    var contributors: Array[AttributeComponent] = []
    var parent = get_parent()
    var nodes = parent.get_children() + extern_contributors

    for node in nodes:
        var attribute_component: AttributeComponent = node.get_node_or_null("AttributeComponent")
        if attribute_component == null or attribute_component == self:
            continue
        if attribute_component.id == id:
            contributors.append(attribute_component)
    return contributors

## 获得所有属性
static func get_all_attributes(node: Node) -> Array[AttributeComponent]:
    var nodes: Array[AttributeComponent] = []
    for child in node.get_children():
        var attribute_component: AttributeComponent = child.get_node_or_null("AttributeComponent")
        if attribute_component != null:
            nodes.append(attribute_component)
    return nodes
