extends Node

@onready var game = $/root/Game


func _process(_delta: float) -> void:
	if game.cur_state == self:
		game.cur_state = $/root/Game/%States/PlayerWaitInputState
