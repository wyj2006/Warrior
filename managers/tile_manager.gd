class_name TileManager extends Node

@onready var tile = preload("res://assets/curses_640x300.bmp").get_image()
var tile_width = 8
var tile_height = 12

func get_tile_texture(index: int, back_color = Color.BLACK, fore_color = Color.WHITE) -> Texture2D:
    @warning_ignore("integer_division")
    var row: int = index / 16
    var col: int = index % 16
    @warning_ignore("confusable_local_usage")
    @warning_ignore("shadowed_variable")
    var tile = tile.get_region(Rect2i(col * tile_width, row * tile_height, tile_width, tile_height))
    for i in range(tile.get_width()):
        for j in range(tile.get_height()):
            var pixel = tile.get_pixel(i, j)
            if pixel == Color(1, 0, 1):
                tile.set_pixel(i, j, back_color)
            else:
                tile.set_pixel(i, j, fore_color)
    return ImageTexture.create_from_image(tile)


func get_tile(id: String) -> Texture2D:
    match id:
        "player":
            return get_tile_texture("@".unicode_at(0))
        "wall":
            return get_tile_texture("O".unicode_at(0))
        "floor":
            return get_tile_texture(0)
        "backpack":
            return get_tile_texture(235)
        "sword":
            return get_tile_texture("/".unicode_at(0))
        _:
            return get_tile_texture(0, Color.WHITE)