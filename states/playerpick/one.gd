extends LimboState

var ItemViewerScene = preload("res://scenes/itemviewer/item_viewer.tscn")

@onready var dock_manager: DockManager = $/root/World/%DockManager
@onready var player: Player = $/root/World/Player
@onready var action_list = $CanvasLayer/VBoxContainer/ScrollContainer/ActionList
var pick: Pick:
	get:
		return player.get_node_or_null("Pick")
var store: Store:
	get:
		return player.get_node_or_null("Store")
var item:
	get:
		return blackboard.get_var("item")

func _setup() -> void:
	$CanvasLayer.hide()

func _enter() -> void:
	Common.clear_children(action_list)
	if item.get_node_or_null("Storable") != null and store != null:
		for container in player.find_children("Container"):
			var action_button = Button.new()
			action_button.text = tr("存入 {container_name}").format({"container_name": DisplayName.get_full(container.get_parent(), container.get_parent().name)})
			action_button.connect("pressed", func():
				pick.do(item, func(node): store.do(node, container))
				dispatch("picked")
			)
			action_list.add_child(action_button)
	$CanvasLayer.show()

func _exit() -> void:
	$CanvasLayer.hide()

func _update(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_cancel"):
		dispatch(EVENT_FINISHED)

func _on_view_button_pressed() -> void:
	var item_viewer = ItemViewerScene.instantiate()
	item_viewer.item = item
	dock_manager.embed_dock(item_viewer)
