extends Node

@onready var game = $/root/Game
@onready var UiScene = preload("res://states/show_detail_state/detail_ui.tscn")
var ui

var item_component: ItemComponent
var return_state

func _process(_delta: float) -> void:
    if game.cur_state == self:
        if ui == null:
            ui = UiScene.instantiate()
            add_child(ui)
        ui.show()
    else:
        if ui != null:
            remove_child(ui)
        ui = null

func _input(_event: InputEvent) -> void:
    if game.cur_state != self:
        return
    if Input.is_action_pressed("ui_cancel"):
        game.cur_state = return_state
