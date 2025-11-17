class_name Tile extends Sprite2D

@export var id: String


func _ready() -> void:
    texture = $"/root/World/%TileManager".get_tile(id)