extends Window

@export var dock: Dock

func _init() -> void:
	size = Vector2(ProjectSettings.get_setting("display/window/size/viewport_width"), ProjectSettings.get_setting("display/window/size/viewport_height"))
	initial_position = Window.WINDOW_INITIAL_POSITION_CENTER_PRIMARY_SCREEN
	content_scale_size = size
	connect("close_requested", func(): get_parent().remove_child.call_deferred(self))

func _ready() -> void:
	if dock.get_parent() == null:
		add_child(dock)
	else:
		dock.reparent(self)

func _on_child_exiting_tree(node: Node) -> void:
	if node == dock:
		close_requested.emit()
