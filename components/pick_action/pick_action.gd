extends Area2D

class_name PickAction

@onready var tile_manager: TileManager = $/root/Game/%TileManager
@onready var tile_width = tile_manager.tile_width
@onready var tile_height = tile_manager.tile_height

var pickable_objects = [] # 当前可以捡起的物品

func _on_area_entered(area: Area2D) -> void:
    # area是Pickable节点
    pickable_objects.append(area.get_parent())

func _on_area_exited(area: Area2D) -> void:
    if area.get_parent() in pickable_objects:
        pickable_objects.erase(area.get_parent())
