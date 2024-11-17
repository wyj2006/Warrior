extends Node

## 材料组件
## 自动将父节点的属性贡献到祖父节点中

var contributed_nodes = [] ## 已经贡献的节点

func _ready() -> void:
    var parent: Node = get_parent()
    parent.connect("tree_entered", _on_parent_tree_entered)
    parent.connect("tree_exiting", _on_parent_tree_exiting)
    contribute()

func _on_parent_tree_entered():
    contribute()

func _on_parent_tree_exiting():
    discontribute()

func contribute():
    var parent = get_parent()
    var grand = parent.get_parent()

    var grand_attr = {}
    for attr in AttributeComponent.get_all_attributes(grand):
        grand_attr[attr.id] = attr
        
    for attr in AttributeComponent.get_all_attributes(parent):
        if attr.id in grand_attr:
            if attr.get_parent() not in grand_attr[attr.id].extern_contributors:
                grand_attr[attr.id].extern_contributors.append(attr.get_parent())
                contributed_nodes.append([grand_attr[attr.id], attr.get_parent()])

func discontribute():
    for i in contributed_nodes:
        if i[1] in i[0].extern_contributors:
            i[0].extern_contributors.erase(i[1])