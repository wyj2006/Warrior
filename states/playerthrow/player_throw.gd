extends LimboHSM

func _setup() -> void:
	add_transition($Start, $Some, "something_to_throw")
	add_transition($Start, $None, "nothing_to_throw")
	add_transition($Start, $Error, "cannot_throw")
	add_transition($Some, $Start, "threw")

func _update(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_cancel"):
		dispatch(EVENT_FINISHED)