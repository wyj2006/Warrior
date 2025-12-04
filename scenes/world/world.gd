extends Node2D

func _ready() -> void:
	$%HSM.add_transition($%PlayerAction, $%PlayerPick, "to_player_pick")
	$%HSM.add_transition($%PlayerPick, $%PlayerAction, $%PlayerPick.EVENT_FINISHED)

	$%HSM.initialize(self)
	$%HSM.set_active(true)
