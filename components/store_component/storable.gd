extends Node


var stored: bool:
    get:
        return get_parent().get_parent().get_node_or_null("ContainerComponent") != null

func _process(_delta: float) -> void:
    if stored:
        get_parent().hide()
        get_parent().position = Vector2(0, 0)
    else:
        get_parent().show()