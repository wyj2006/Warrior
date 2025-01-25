extends Node

class_name PickObjChooseState

@onready var player = $/root/Game/%Player # 起点
@onready var direction = Vector2(0, 0) # 方向
@onready var game: Game = $/root/Game
@onready var mapmanager: MapManager = $/root/Game/%MapManager
@onready var UiScene = preload("res://states/pick_obj_choose_state/pick_obj_choose_ui.tscn")
@onready var ui: PickObjChooseUi = null

func _process(_delta: float) -> void:
    if game.cur_state != self:
        disable_ui()
    else:
        enable_ui()

func disable_ui():
    if ui != null and ui.get_parent() == self:
        remove_child(ui)
        ui = null
    $"%UnableTip".hide()

func enable_ui():
    $"%UnableTip".hide()
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
    if ui == null: # 可能是因无法捡起而导致的
        return
    var actions = ui.get_actions()
    for action in actions:
        action.call()
