class_name Speed extends Attribute

static var attr_name = "speed"

@export var base_speed: float = 0

func get_base() -> Variant:
	return base_speed

func set_base(val: Variant) -> void:
	base_speed = val