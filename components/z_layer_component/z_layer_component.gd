extends Node

class_name ZLayerComponent

##将父节点作为一个z层
##父节点的二维坐标将自动分配

var _z_coord = 0

##z坐标
@export var z_coord: float:
	get:
		return _z_coord
	set(value):
		if value == _z_coord:
			return
		_z_coord = value
		if is_node_ready():
			map_manager.add_z_layer(self)

@onready var map_manager: MapManager = $/root/Game/%MapManager

func _ready() -> void:
	map_manager.add_z_layer(self)

func _process(_delta: float) -> void:
	get_parent().position = map_manager.get_z_layer_position(self)