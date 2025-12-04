class_name Modifier extends Node

enum Operation {
	ADD_VALUE, ## Op0
	ADD_MUL_BASE, ## Op1
	ADD_MUL_TOTAL, ## Op2
}

@export var amount: Variant
@export var operation = Operation.ADD_VALUE