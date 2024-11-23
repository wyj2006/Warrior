extends Node

class_name AttributeComponent

## 属性组件
## 属性有两部分组成
## 第一部分是基本值
## 第二部分是由其它相同类型的属性组件贡献的

var basic_value ## 基本值
@export var id: String ## 用来区分不同的属性
var ContributeMode = AttributeContributor.ContributeMode

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
func get_contributors() -> Array[AttributeContributor]:
    var contributors: Array[AttributeContributor] = []
    var parent = get_parent()
    
    for node in parent.get_children():
        if node is not AttributeContributor:
            continue
        if node.attr_id == id:
            contributors.append(node)
    return contributors

## 获得所有属性
static func get_all_attributes(node: Node) -> Array[AttributeComponent]:
    var nodes: Array[AttributeComponent] = []
    for child in node.get_children():
        var attribute_component: AttributeComponent = child.get_node_or_null("AttributeComponent")
        if attribute_component != null:
            nodes.append(attribute_component)
    return nodes
