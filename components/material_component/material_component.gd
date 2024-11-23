extends Node

## 材料组件
## 自动将父节点的属性贡献到祖父节点中

var contributors: Array[AttributeContributor] = []
@onready var AttributeContributorScene = preload("res://components/attribute_component/attribute_contributor.tscn")

func _ready() -> void:
    var parent: Node = get_parent()
    for node in parent.get_children():
        if node is AttributeContributor:
            contributors.append(node)
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

    for grand_attr in AttributeComponent.get_all_attributes(grand):
        for contributor in contributors:
            if grand_attr.id != contributor.attr_id:
                break
            contributor.get_parent().remove_child.call_deferred(contributor)
            grand_attr.get_parent().add_child.call_deferred(contributor)

func discontribute():
    for contributor in contributors:
        contributor.get_parent().remove_child(contributor)
        add_child(contributor)