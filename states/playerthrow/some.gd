extends LimboState

@onready var player: Player = $/root/World/Player
@onready var item_list = $CanvasLayer/VBoxContainer/ScrollContainer/ItemList
var throw: Throw:
	get:
		return player.get_node_or_null("Throw")
var throwables:
	get:
		return player.find_children("Throwable")

func _setup() -> void:
	$CanvasLayer.hide()

func _enter() -> void:
	Common.clear_children(item_list)
	for throwable in throwables:
		var item_button = Button.new()
		var item = throwable.get_parent()
		item_button.text = DisplayName.get_full(item, item.name)
		item_button.connect("pressed", func():
			throw.do(item, player.get_parent())
			dispatch("threw")
		)
		item_list.add_child(item_button)
	$CanvasLayer.show()

func _exit() -> void:
	$CanvasLayer.hide()
