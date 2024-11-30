extends CanvasLayer

class_name PickObjChooseUi

@onready var map_manager: MapManager = $/root/Game/%MapManager
@onready var origin: Node2D = get_parent().origin
@onready var direction: Vector2 = get_parent().direction
@onready var PickableObjectViewScene = preload("res://states/pick_obj_choose_state/pickable_object_view.tscn")
var pickable_nodes

func _ready() -> void:
    var origin_pos: Vector3 = map_manager.get_tilemap_position(origin)
    var pos = origin_pos + Vector3(direction.x, direction.y, 0)

    pickable_nodes = map_manager.get_node_at_pos(pos).filter(func(x): return StoreAction.can_be_stored(origin, x))

    for i in pickable_nodes:
        var view = PickableObjectViewScene.instantiate()
        view.text = NameAttribute.get_self_name(i)
        view.object = i
        $"%PickableObjectContainer".add_child(view)

    if $"%PickableObjectContainer".get_child_count() > 0:
        $"%PickableObjectContainer".get_child(0).grab_focus()
    else:
        var label = Label.new()
        label.text = "这里没有东西可以捡起来"
        label.add_theme_font_override("font", preload("res://asserts/font/minecraft.ttf"))
        $"%PickableObjectContainer".add_child(label)

## 获得要捡起的物品
func get_pick_objects():
    var objects = []
    for i in $"%PickableObjectContainer".get_children():
        if is_instance_of(i, PickableObjectView) and i.select:
            objects.append(i.object)
    return objects