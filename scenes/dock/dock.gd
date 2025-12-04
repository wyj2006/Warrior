class_name Dock extends MarginContainer

signal close_requested
signal detach_requested

@onready var dock_manager: DockManager = $/root/World/%DockManager

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_cancel"):
		close_requested.emit()
	if Input.is_action_just_pressed("detach"):
		detach_requested.emit()

func _on_close_requested() -> void:
	get_parent().remove_child(self)

func _on_detach_requested() -> void:
	dock_manager.detach_dock(self)
