extends CanvasLayer

signal show_detail_request(item: ItemComponent)

@onready var player = $"..".player
@onready var itemlist = $"%ItemList"
## 结构:
## {root: [index,child1, child2], child1: [index, ...], child2: [index,...]}
@onready var item_tree: Dictionary = {}

func _ready() -> void:
    var items = player.find_children("ItemComponent")

    #根据item之间的父子关系构造itemtree
    for item in items:
        var path = item.get_item_path()
        for i in range(len(path)):
            if path[i] not in item_tree:
                item_tree[path[i]] = [0]
            if i > 0:
                item_tree[path[i]][0] = path[i - 1]
            if i < len(path) - 1:
                item_tree[path[i]].append(path[i + 1])
    add_item_tree()

## 根据item_tree添加item
func add_item_tree():
    for i in item_tree:
        item_tree[i][0] = itemlist.item_count
        itemlist.add_item(NameAttribute.get_self_name(i.get_parent()))

func _on_item_list_item_selected(index: int) -> void:
    var related = [] # 子物品的index
    for i in item_tree:
        if item_tree[i][0] != index:
            continue
        for j in range(1, len(item_tree[i])):
            related.append(item_tree[item_tree[i][j]][0])
        break
    
    for i in range(itemlist.item_count):
        itemlist.set_item_custom_fg_color(i, Color.WHITE)
        if i in related:
            itemlist.set_item_custom_fg_color(i, Color.GREEN)


func _on_show_detail_pressed() -> void:
    var indexs = itemlist.get_selected_items()
    if len(indexs) == 0: return
    var index = indexs[0]
    for i in item_tree:
        if item_tree[i][0] == index:
            show_detail_request.emit(i)
            break