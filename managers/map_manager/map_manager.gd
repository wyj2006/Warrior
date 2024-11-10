extends Node

class_name MapManager

@onready var tile_manager: TileManager = $%TileManager
@onready var tile_width: int = tile_manager.tile_width
@onready var tile_height: int = tile_manager.tile_height
@onready var game = $/root/Game
@onready var map = $/root/Game/%Map
@onready var FloorScene = preload("res://objects/floor/floor.tscn")
@onready var WallScene = preload("res://objects/wall/wall.tscn")
@onready var ZLayerComponentScene = preload("res://components/zlayer_component/z_layer_component.tscn")

var z_layers: Dictionary = {}
##各个z坐标的实际二维坐标
var z_coord_position: Dictionary = {}

func _ready() -> void:
    ## 扫描Map
    for z_layer_component in $/root/Game/%Map.find_children("ZLayerComponent"):
        add_z_layer(z_layer_component)

    for i in range(10):
        for j in range(10):
            @warning_ignore("shadowed_global_identifier")
            var floor = FloorScene.instantiate()
            add_node(floor, Vector3(i, j, 0))
    var wall = WallScene.instantiate()
    add_node(wall, Vector3(5, 5, 0))

## 加入一个z_layer
func add_z_layer(z_layer: ZLayerComponent):
    var z_coord = z_layer.z_coordinate

    if z_coord not in z_layers:
        z_layers[z_coord] = []
    if z_layer in z_layers[z_coord]:
        return

    if z_layer.get_parent().get_parent() == $/root/Game/%Map: # 直属于Map
        z_layers[z_coord].push_front(z_layer)
    else:
        z_layers[z_coord].append(z_layer)

    if z_coord not in z_coord_position:
        z_coord_position[z_coord] = Vector2(z_coord, z_coord * 100) # TODO:

## 创建一个新的直属于Map的z_layer
func create_new_zlayer(z_coord: float):
    var z = Node2D.new()
    var z_layer: ZLayerComponent = ZLayerComponentScene.instantiate()
    z_layer.z_coordinate = z_coord
    z.add_child(z_layer)
    $/root/Game/%Map.add_child(z)
    add_z_layer(z_layer)

##查看z_layer是否存在
##如果不存在就创建
func check_z_layer(z_layer: ZLayerComponent):
    var z_coord = z_layer.z_coordinate
    if z_coord not in z_layers:
        create_new_zlayer(z_coord)
    if z_layer not in z_layers[z_coord]:
        add_z_layer(z_layer)

func check_z_coord(z_coord: float):
    if z_coord not in z_layers:
        create_new_zlayer(z_coord)

## 获取z_layer的实际二维坐标
func get_z_layer_position(z_layer: ZLayerComponent) -> Vector2:
    check_z_layer(z_layer)
    var z_coord = z_layer.z_coordinate
    return z_coord_position[z_coord]

func add_node(node: Node2D, pos: Vector3):
    check_z_coord(pos.z)

    if node.get_parent() != null:
        node.get_parent().remove_child(node)
    z_layers[pos.z][0].get_parent().add_child(node)
    node.position = Vector2(pos.x * tile_width, pos.y * tile_height)


## 获得属于指定Z坐标的所有节点
func get_z_node(z_coord: float) -> Array:
    check_z_coord(z_coord)
    var nodes = []
    for i in z_layers[z_coord]:
        for j in i.get_parent().get_children():
            if is_instance_of(j, Node2D):
                nodes.append(j)
    return nodes

## 将地图作为一个tilemap, 返回节点在tilemap中的坐标(包括z坐标)
func get_tilemap_position(node: Node2D) -> Vector3:
    var x = node.position.x / tile_width
    var y = node.position.y / tile_height
    var z

    var p = node.get_parent()
    while p != null:
        var z_layer_component: ZLayerComponent = p.get_node_or_null("ZLayerComponent")
        if z_layer_component != null:
            z = z_layer_component.z_coordinate
            break
        p = p.get_parent()
    return Vector3(x, y, z)

## 获取在指定坐标的节点
func get_node_at_pos(pos: Vector3) -> Array:
    var nodes = []
    
    for node in get_z_node(pos.z):
        if node.position.x == pos.x * tile_width and node.position.y == pos.y * tile_height:
            nodes.append(node)
    return nodes
