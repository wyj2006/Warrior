extends Node

class_name ActionComponent

var can_be_done: Callable = func(_x): return false
var has_been_done: Callable = func(_x): return false
var get_available_action: Callable = func(_x): return {}