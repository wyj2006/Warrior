class_name Pick extends Area3D

@export var pick_range = Vector3(3, 3, 1)
@onready var tile_manager: TileManager = $/root/World/%TileManager
@onready var tile_size = Vector2(tile_manager.tile_set.tile_size)

var pickables: Array[Pickable] = []

func _ready() -> void:
	$CollisionShape3D.shape.size = pick_range * Vector3(tile_size.x, tile_size.y, tile_manager.tile_height)

func _on_area_entered(area: Area3D) -> void:
	if area is Pickable and not area.picked and area not in pickables:
		pickables.append(area)

func _on_area_exited(area: Area3D) -> void:
	pickables.erase(area)

func do(node: Node, next_action: Callable) -> void:
	next_action.call(node)
