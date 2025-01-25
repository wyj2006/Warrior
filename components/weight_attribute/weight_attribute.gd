extends Node

@export var basic_weight: float:
    get:
        if $AttributeComponent.basic_value == null:
            $AttributeComponent.basic_value = 0
        return $AttributeComponent.basic_value
    set(value):
        $AttributeComponent.basic_value = value

var weight: float:
    get:
        return $AttributeComponent.value

func _ready() -> void:
    if $AttributeComponent.basic_value == null:
        $AttributeComponent.basic_value = basic_weight