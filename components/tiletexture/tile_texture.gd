extends Sprite2D

@onready var tile_manager: TileManager = $/root/World/%TileManager

@export var tile_id: String
@export var size_related: Array[Node] = []

func _process(_delta: float) -> void:
	texture = tile_manager[tile_id]
	for node in size_related:
		if node is CollisionShape2D:
			var shape = node.shape
			if shape is RectangleShape2D:
				shape.size = texture.get_size()
