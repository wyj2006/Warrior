extends LimboState

@onready var player: Player = $/root/World/Player
var pick: Pick:
	get:
		return player.get_node_or_null("Pick")
var store: Store:
	get:
		return player.get_node_or_null("Store")

func _enter() -> void:
	if pick == null or store == null:
		dispatch("cannot_pick")
	elif len(pick.pickables) == 0:
		dispatch("nothing_to_pick")
	else:
		dispatch("something_to_pick")