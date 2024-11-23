extends Node

class_name PickObjChooseState

@onready var origin = $/root/Game/%Player # 起点
@onready var direction = Vector2(0, 0) # 方向
@onready var game: Game = $/root/Game
@onready var mapmanager: MapManager = $/root/Game/%MapManager
@onready var UiScene = preload("res://states/pick_obj_choose_state/pick_obj_choose_ui.tscn")
@onready var ui: PickObjChooseUi = null

func _process(_delta: float) -> void:
    if game.cur_state != self:
        disable_ui()
    elif not PickComponent.can_pick(origin) or not StoreComponent.can_store(origin):
        game.cur_state = $/root/Game/%States/PlayerWaitInputState
        print("无法切换到PickObjChooseState")
        #TODO: 提示信息
    else:
        enable_ui()

func disable_ui():
    if ui != null and ui.get_parent() == self:
        remove_child(ui)
        ui = null

func enable_ui():
    if ui != null:
        return
    ui = UiScene.instantiate()
    add_child(ui)

func _input(_event: InputEvent) -> void:
    if game.cur_state != self:
        return
    if Input.is_action_pressed("finish_pick_selection"):
        pick_objects()
        game.cur_state = $/root/Game/%States/PlayerWaitInputState

func pick_objects():
    var objects = ui.get_pick_objects()
    #TODO: 更多选项
    var store_component: StoreComponent = origin.get_node("StoreComponent")
    var container = origin.find_child("ContainerComponent").get_parent() # TODO: 有效性检查&玩家选择容器
    for object in objects:
        store_component.store(object, container)
