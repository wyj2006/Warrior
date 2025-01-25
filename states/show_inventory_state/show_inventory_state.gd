extends Node

@onready var game: Game = $/root/Game
@onready var UiScene: PackedScene = preload("res://states/show_inventory_state/inventory_ui.tscn")
var ui

var player

func _process(_delta: float) -> void:
    if game.cur_state == self:
        if player == null:
            player = $/root/Game/%Player
        if ui == null:
            ui = UiScene.instantiate()
            add_child(ui)
            ui.connect("show_detail_request", show_detail)
    else:
        if ui != null:
            remove_child(ui)
        player = null
        ui = null

func _input(_event: InputEvent) -> void:
    if game.cur_state != self:
        return
    if Input.is_action_pressed("ui_cancel"):
        game.cur_state = $/root/Game/%States/PlayerWaitInputState

func show_detail(item_component: ItemComponent):
    var state = $/root/Game/%States/ShowDetailState
    state.item_component = item_component
    state.return_state = self
    game.cur_state = state