extends Node

class_name TileManager

var tile: Texture2D = preload("res://asserts/textures/tiles.bmp")
var tile_width: int = 8
var tile_height: int = 12


func get_tile_texture(index: int, back_color = Color.BLACK, fore_color = Color.WHITE) -> Texture2D:
	@warning_ignore("integer_division")
	var row: int = index / 16
	var col: int = index % 16
	var image = tile.get_image()
	image = image.get_region(Rect2i(col * tile_width, row * tile_height, tile_width, tile_height))
	for i in range(image.get_width()):
		for j in range(image.get_height()):
			var pixel = image.get_pixel(i, j)
			if pixel == Color(1, 0, 1):
				image.set_pixel(i, j, back_color)
			else:
				image.set_pixel(i, j, fore_color)
	return ImageTexture.create_from_image(image)


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
