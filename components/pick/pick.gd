class_name Pick extends Area2D

@export var pick_range = Vector2(3, 3)
@onready var tile_manager: TileManager = $/root/World/%TileManager
@onready var tile_size = Vector2(tile_manager.tile_set.tile_size)

var pickables: Array[Pickable] = []

func _ready() -> void:
	$CollisionShape2D.shape.size = pick_range * tile_size

func _on_area_entered(area: Area2D) -> void:
	if area is Pickable and not area.picked and area not in pickables:
		pickables.append(area)

func _on_area_exited(area: Area2D) -> void:
	pickables.erase(area)

func do(node: Node, next_action: Callable) -> void:
	next_action.call(node)
