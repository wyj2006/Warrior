extends Sprite2D

@onready var tile_manager = $/root/Game/%TileManager
@onready var tile_width = tile_manager.tile_width
@onready var tile_height = tile_manager.tile_height

func _ready() -> void:
    texture = tile_manager.get_tile("wall")
    $StaticBody2D/CollisionShape2D.shape.size = Vector2(tile_width / 2 - 1, tile_height / 2 - 1)
