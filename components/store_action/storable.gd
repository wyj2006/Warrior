extends Node

class_name Storable


var stored: bool:
    get:
        return get_parent().get_parent().get_node_or_null("ContainerComponent") != null

func _process(_delta: float) -> void:
    if stored:
        get_parent().hide()
    else:
        get_parent().show()
