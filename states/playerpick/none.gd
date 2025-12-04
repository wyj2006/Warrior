extends LimboState

func _setup() -> void:
	$CanvasLayer.hide()

func _enter() -> void:
	$CanvasLayer.show()

func _exit() -> void:
	$CanvasLayer.hide()