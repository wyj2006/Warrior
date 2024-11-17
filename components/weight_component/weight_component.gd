extends Node

@export var basic_weight: float:
    get:
        if $AttributeComponent.basic_value == null:
            $AttributeComponent.basic_value = 0
        return $AttributeComponent.basic_value
    set(value):
        $AttributeComponent.basic_value = value

@export var contribute_mode: AttributeComponent.ContributeMode:
    get:
        return $AttributeComponent.contribute_mode
    set(value):
        $AttributeComponent.contribute_mode = value

@export var extern_contributors: Array[Node]:
    get:
        return $AttributeComponent.extern_contributors
    set(value):
        $AttributeComponent.extern_contributors = value

var weight: float:
    get:
        return $AttributeComponent.value
