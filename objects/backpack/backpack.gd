extends Sprite2D

@onready var tile_manager: TileManager = $/root/Game/%TileManager


func _ready() -> void:
	texture = tile_manager.get_tile("backpack")
