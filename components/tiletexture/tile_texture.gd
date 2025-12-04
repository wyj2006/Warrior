extends MeshInstance3D

@onready var tile_manager: TileManager = $/root/World/%TileManager

@export var tile_id: String
@export var size_related: Array[Node] = []
@onready var texture = tile_manager[tile_id]

func _ready() -> void:
	mesh.size = texture.get_size()
	mesh.material = StandardMaterial3D.new()
	mesh.material.albedo_texture = texture
	for node in size_related:
		if node is CollisionShape3D:
			var shape = node.shape
			if shape is BoxShape3D:
				shape.size = Vector3(mesh.size.x, mesh.size.y, tile_manager.tile_height)