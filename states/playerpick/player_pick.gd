extends LimboHSM

func _setup() -> void:
	add_transition($Start, $Some, "something_to_pick")
	add_transition($Start, $None, "nothing_to_pick")
	add_transition($Start, $Error, "cannot_pick")
	add_transition($Some, $One, "try_pick")
	add_transition($One, $Start, "picked")
	add_transition($One, $Start, $One.EVENT_FINISHED)

func _update(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_cancel"):
		if get_active_state() != $One:
			dispatch(EVENT_FINISHED)
