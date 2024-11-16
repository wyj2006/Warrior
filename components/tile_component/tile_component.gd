extends Sprite2D

@export var id: String

@onready var tile_manager = $/root/Game/%TileManager

func _ready() -> void:
	texture = tile_manager.get_tile(id)