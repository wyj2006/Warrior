extends Node

@export var basic_speed: float:
    get:
        return $AttributeComponent.basic_value
    set(value):
        $AttributeComponent.basic_value = value

var speed: float:
    get:
        return $AttributeComponent.value