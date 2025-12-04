extends Node3D

func _ready() -> void:
	$%HSM.add_transition($%PlayerAction, $%PlayerPick, "to_player_pick")
	$%HSM.add_transition($%PlayerPick, $%PlayerAction, $%PlayerPick.EVENT_FINISHED)
	
	$%HSM.add_transition($%PlayerAction, $%PlayerThrow, "to_player_throw")
	$%HSM.add_transition($%PlayerThrow, $%PlayerAction, $%PlayerThrow.EVENT_FINISHED)

	$%HSM.initialize(self)
	$%HSM.set_active(true)
