class_name TileManager extends Node

@export var tile_set: TileSet
@export var tile_height: float = 200
@onready var source: TileSetAtlasSource = tile_set.get_source(0)

@onready var player: Texture2D = get_and_tint(Vector2i(0, 4))
@onready var wall: Texture2D = get_and_tint(Vector2i(15, 4))
@onready var sword: Texture2D = get_and_tint(Vector2i(15, 2))
@onready var backpack = get_and_tint(Vector2i(9, 14))

func get_and_tint(coord: Vector2i, fore_color = Color.WHITE, back_color = Color.BLACK, frame = 0) -> Texture2D:
	var region = source.get_tile_texture_region(coord, frame)
	var image = source.texture.get_image().get_region(region)
	for i in range(image.get_width()):
		for j in range(image.get_height()):
			var pixel = image.get_pixel(i, j)
			if pixel == Color(1, 0, 1):
				image.set_pixel(i, j, back_color)
			else:
				image.set_pixel(i, j, fore_color)
	return ImageTexture.create_from_image(image)