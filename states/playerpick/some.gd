extends LimboState

@onready var player: Player = $/root/World/Player
@onready var item_list = $CanvasLayer/VBoxContainer/ScrollContainer/ItemList
var pick: Pick:
	get:
		return player.get_node_or_null("Pick")
var store: Store:
	get:
		return player.get_node_or_null("Store")

func _setup() -> void:
	$CanvasLayer.hide()

func _enter() -> void:
	Common.clear_children(item_list)
	for pickable in pick.pickables:
		var item_button = Button.new()
		var item = pickable.get_parent()
		item_button.text = DisplayName.get_full(item, item.name)
		item_button.connect("pressed", func():
			$"../One".blackboard.set_var("item", item)
			dispatch("try_pick")
		)
		item_list.add_child(item_button)
	$CanvasLayer.show()

func _exit() -> void:
	$CanvasLayer.hide()
