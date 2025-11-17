extends Player2D

func _ready() -> void:
    var tile_manager: TileManager = $"/root/World/%TileManager"
    $CollisionShape2D.shape.size = Vector2(tile_manager.tile_width, tile_manager.tile_height)