extends Sprite2D

@onready var tile_manager = $"/root/Game/%TileManager"

func _ready() -> void:
	texture = tile_manager.get_tile("floor")
