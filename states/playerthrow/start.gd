extends LimboState

@onready var player: Player = $/root/World/Player
var throw: Throw:
	get:
		return player.get_node_or_null("Throw")
var throwables:
	get:
		return player.find_children("Throwable")

func _enter() -> void:
	if throw == null:
		dispatch("cannot_throw")
	elif len(throwables) == 0:
		dispatch("nothing_to_throw")
	else:
		dispatch("something_to_throw")