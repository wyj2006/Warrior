extends LimboState

@onready var player: Player = $/root/World/%Player
var pick: Pick:
	get:
		return player.get_node_or_null("Pick")
var store: Store:
	get:
		return player.get_node_or_null("Store")

func _setup() -> void:
	$%None.hide()
	$%Some.hide()
	$%One.hide()

func _enter() -> void:
	if pick == null or len(pick.pickables) == 0:
		$%None.show()
	else:
		$%Some.show()

func _exit() -> void:
	$%None.hide()
	$%Some.hide()
	$%One.hide()

func _update(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_cancel"):
		if $%One.visible:
			$%One.hide()
			$%Some.show()
		else:
			dispatch(EVENT_FINISHED)

func clear_children(node: Node):
	while node.get_child_count() > 0:
		node.remove_child(node.get_child(0))

func _on_some_visibility_changed() -> void:
	if not $%Some.visible:
		return
	if pick == null or len(pick.pickables) == 0:
		$%None.show()
		#不用call_deferred会无法正常隐藏
		$%Some.hide.call_deferred()
		return
	clear_children($%ItemList)
	for pickable in pick.pickables:
		var item_button = Button.new()
		var item = pickable.get_parent()
		item_button.text = DisplayName.get_full(item, item.name)
		item_button.connect("pressed", func():
			clear_children($%ActionList)
			if item.get_node_or_null("Storable") != null and store != null:
				for container in player.find_children("Container"):
					var action_button = Button.new()
					action_button.text = tr("存入 {container_name}").format({"container_name": DisplayName.get_full(container.get_parent(), container.get_parent().name)})
					action_button.connect("pressed", func():
						pick.do(item, func(node): store.do(node, container))
						$%One.hide()
						$%Some.show()
					)
					$%ActionList.add_child(action_button)
			$%One.show()
			$%Some.hide()
		)
		$%ItemList.add_child(item_button)
