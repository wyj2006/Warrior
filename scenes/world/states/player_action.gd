extends LimboState

@onready var player: Player = $/root/World/%Player
@onready var tile_manager: TileManager = $/root/World/%TileManager
@onready var tile_size = Vector2(tile_manager.tile_set.tile_size)

func _update(_delta: float) -> void:
	if Input.is_action_just_pressed("pick"):
		dispatch("to_player_pick")
		return
	var speed = Attribute.get_attr(player, Speed.attr_name, 0)
	var direction = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	if direction == Vector2.ZERO:
		return
	player.velocity = direction * speed * tile_size
	player.move_and_slide()
	dispatch(EVENT_FINISHED)