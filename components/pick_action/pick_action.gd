extends Area2D

class_name PickAction

@onready var tile_manager: TileManager = $/root/Game/%TileManager
@onready var tile_width = tile_manager.tile_width
@onready var tile_height = tile_manager.tile_height

var pickable_objects = [] # 当前可以捡起的物品

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
    return node.get_node_or_null("PickAction") != null

func _ready() -> void:
    $CollisionShape2D.shape.size = Vector2(tile_width, tile_height)

## 拾取
## 第一个参数为拾取的物品, 第二个参数为拾取后要做的事
func pick(node: Node, follow_action: Callable):
    follow_action.call(node)

func _on_area_entered(area: Area2D) -> void:
    # area是Pickable节点
    pickable_objects.append(area.get_parent())


func _on_area_exited(area: Area2D) -> void:
    if area.get_parent() in pickable_objects:
        pickable_objects.erase(area.get_parent())
