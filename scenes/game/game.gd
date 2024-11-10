extends Node2D

class_name Game

var next_state = null
var state_changed = false

var cur_state:
	get:
		return _cur_state
	set(state):
		next_state = state
		state_changed = true

@onready var _cur_state = $%States/InitState


func _process(_delta: float) -> void:
	if state_changed == true:
		_cur_state = next_state
		state_changed = false
