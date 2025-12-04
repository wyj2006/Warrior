class_name DockManager extends CanvasLayer

var WindowWrapperScene = preload("res://managers/dockmanager/window_wrapper.tscn")

func embed_dock(dock: Dock):
	if dock.get_parent() == null:
		add_child(dock)
	else:
		dock.reparent(self)

func detach_dock(dock: Dock):
	var window = WindowWrapperScene.instantiate()
	window.dock = dock
	window.show()
	add_child(window)