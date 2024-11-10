extends Node

class_name ZLayerComponent

##将父节点作为一个z层
##父节点的二维坐标将自动分配

##z坐标
@export var z_coordinate: float

@onready var map_manager: MapManager = $/root/Game/%MapManager

func _process(_delta: float) -> void:
	get_parent().position = map_manager.get_z_layer_position(self)