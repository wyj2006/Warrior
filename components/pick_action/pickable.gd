extends Area2D

@onready var tile_manager: TileManager = $/root/Game/%TileManager
@onready var tile_width = tile_manager.tile_width
@onready var tile_height = tile_manager.tile_height

## 被捡起
var picked: bool:
    get:
        return get_parent().get_parent().get_node_or_null("ZLayerComponent") == null

func _ready() -> void:
    $CollisionShape2D.shape.size = Vector2(tile_width * 3, tile_height * 3)

func _process(_delta: float) -> void:
    if picked:
        set_physics_process(false)
    else:
        set_physics_process(true)