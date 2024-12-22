extends CanvasLayer

class_name PickObjChooseUi

@onready var map_manager: MapManager = $/root/Game/%MapManager
@onready var origin: Node2D = get_parent().origin
@onready var direction: Vector2 = get_parent().direction
@onready var all_containers:
    get:
        return origin.find_children("ContainerComponent") as Array[ContainerComponent]
@onready var all_bodyparts:
    get:
        return origin.find_children("BodypartComponent") as Array[BodypartComponent]

var item_action = {}
var pickable_nodes
var stored_nodes = [] # 已经被存起来的节点(还没有真的进行存储操作)
var selected_items = {}

func _ready() -> void:
    var origin_pos: Vector3 = map_manager.get_tilemap_position(origin)
    var pos = origin_pos + Vector3(direction.x, direction.y, 0)

    pickable_nodes = (origin.get_node("PickAction") as PickAction).pickable_objects
    pickable_nodes = pickable_nodes.filter(func(x): return map_manager.get_tilemap_position(x) == pos)

    var root = $"%PickableObjects".create_item()

    for node in pickable_nodes:
        if not PickAction.can_be_picked(node):
            continue
        var object_item = $"%PickableObjects".create_item(root)
        object_item.set_text(0, NameAttribute.get_self_name(node))
        object_item.set_selectable(0, false)
        
        if StoreAction.can_store(origin) and StoreAction.can_be_stored(origin, node):
            for container in all_containers:
                var action_item = $"%PickableObjects".create_item(object_item)
                action_item.set_text(0, "存入 " + NameAttribute.get_self_name(container.get_parent()))
                item_action[action_item] = func():
                    var store_action: StoreAction = origin.get_node("StoreAction")
                    store_action.store(node, container.get_parent())
        if WearAction.can_wear(origin) and WearAction.can_be_wore(origin, node):
            for bodypart in all_bodyparts:
                if not bodypart.is_valid(node):
                    continue
                var action_item = $"%PickableObjects".create_item(object_item)
                action_item.set_text(0, "穿在 " + NameAttribute.get_self_name(bodypart.get_parent()) + " 上")
                item_action[action_item] = func():
                    var wear_action: WearAction = origin.get_node("WearAction")
                    wear_action.wear(node, bodypart.get_parent())

func _process(_delta: float) -> void:
    update_item_states()

## 获得所有行为
func get_actions():
    var actions = []
    for item in selected_items.values():
        if item in item_action:
            actions.append(item_action[item])
    return actions

func update_item_states():
    for object_item in $"%PickableObjects".get_root().get_children():
        for action_item in object_item.get_children():
            if object_item not in selected_items or action_item != selected_items[object_item]:
                action_item.set_custom_color(0, Color.WHITE)
            else:
                action_item.set_custom_color(0, Color.GREEN)

## 选中某个item
## 如果已经被选中, 那么就取消选中
func select(item: TreeItem):
    var parent = item.get_parent()
    if parent in selected_items and selected_items[parent] == item:
        selected_items.erase(parent)
    else:
        selected_items[parent] = item
    
func _input(event: InputEvent) -> void:
    var item = null
    if is_instance_of(event, InputEventMouseButton):
        if event.is_pressed():
            item = $"%PickableObjects".get_item_at_position(event.position)
    elif Input.is_action_pressed("ui_accept"):
        item = $"%PickableObjects".get_selected()
    if item:
        select(item)