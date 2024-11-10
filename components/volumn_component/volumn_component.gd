extends Node

@export var basic_volumn: float:
    get:
        return $AttributeComponent.basic_value
    set(value):
        $AttributeComponent.basic_value = value

var volumn: float:
    get:
        return $AttributeComponent.value