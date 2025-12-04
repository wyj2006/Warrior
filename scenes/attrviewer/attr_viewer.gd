extends Dock

@export var attribute: Attribute

func _ready() -> void:
	$%Name.text = DisplayName.get_full(attribute, attribute.name)
	$%Value.text = var_to_str(attribute.value)
	var ops = attribute.get_ops()
	$%Details.text = "=({base}".format({"base": attribute.base})
	if len(ops[0]) > 0:
		$%Details.text += "+{op0}".format({"op0": "+".join(ops[0].map(var_to_str))})
	$%Details.text += ")"
	if len(ops[1]) > 0:
		$%Details.text += "*(1+{op1})".format({"op1": "+".join(ops[1].map(var_to_str))})
	if len(ops[2]) > 0:
		$%Details.text += "*{op2}".format({"op2": "*".join(ops[2].map(func(x): return "(1+{0})".format([var_to_str(x)])))})
