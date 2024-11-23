extends Node

@onready var game: Game = $/root/Game
@onready var pick_obj_choose_state: PickObjChooseState = $/root/Game/%States/PickObjChooseState
@onready var ui = preload("res://states/pick_pos_choose_state/pick_pos_choose_ui.tscn").instantiate()


func _ready() -> void:
    disable_ui()


func _process(_delta: float) -> void:
    if game.cur_state != self:
        disable_ui()
    else:
        enable_ui()


func enable_ui():
    if ui.get_parent() != self:
        add_child(ui)


func disable_ui():
    if ui.get_parent() == self:
        remove_child(ui)


func _input(_event: InputEvent) -> void:
    if game.cur_state != self:
        return
    var direction = null
    if Input.is_action_pressed("ui_cancel"):
        game.cur_state = $/root/Game/%States/PlayerWaitInputState
    elif Input.is_action_pressed("move_up"):
        direction = Vector2(0, -1)
    elif Input.is_action_pressed("move_down"):
        direction = Vector2(0, 1)
    elif Input.is_action_pressed("move_left"):
        direction = Vector2(-1, 0)
    elif Input.is_action_pressed("move_right"):
        direction = Vector2(1, 0)
    elif Input.is_action_pressed("move_upleft"):
        direction = Vector2(-1, -1)
    elif Input.is_action_pressed("move_upright"):
        direction = Vector2(1, -1)
    elif Input.is_action_pressed("move_downright"):
        direction = Vector2(1, 1)
    elif Input.is_action_pressed("move_downleft"):
        direction = Vector2(-1, 1)
    if direction:
        pick_obj_choose_state.direction = direction
        game.cur_state = pick_obj_choose_state
