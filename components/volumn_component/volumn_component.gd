extends Node

@export var basic_volumn: float:
    get:
        if $AttributeComponent.basic_value == null:
            $AttributeComponent.basic_value = 0
        return $AttributeComponent.basic_value
    set(value):
        $AttributeComponent.basic_value = value

var volumn: float:
    get:
        return $AttributeComponent.value