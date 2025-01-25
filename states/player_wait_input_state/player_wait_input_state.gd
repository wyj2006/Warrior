extends Node

@onready var game: Game = $/root/Game


func _input(_event: InputEvent) -> void:
    if game.cur_state != self:
        return
    var direction = null
    if Input.is_action_pressed("move_up"):
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
    elif Input.is_action_pressed("pick"):
        game.cur_state = $/root/Game/%States/PickPosChooseState
    elif Input.is_action_pressed("show_inventory"):
        game.cur_state = $/root/Game/%States/ShowInventoryState
    if direction:
        $/root/Game/%Player/MoveAction.move(direction)
