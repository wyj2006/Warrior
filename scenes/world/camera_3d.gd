extends Camera3D

@onready var tile_manager: TileManager = $/root/World/%TileManager

func _ready() -> void:
	position.z = tile_manager.tile_height