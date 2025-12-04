## 参考https://zh.minecraft.wiki/w/%E5%B1%9E%E6%80%A7?variant=zh-cn
@abstract class_name Attribute extends Node

@export var modifiers: Array[Modifier] = []

var base:
	get:
		return get_base()
	set(val):
		set_base(val)

var value:
	get:
		var val = base
		var ops = get_ops()
		val += sum(ops[0])
		val *= (1 + sum(ops[1]))
		for i in ops[2]:
			val *= (1 + i)
		return val
	set(val):
		var ops = get_ops()
		for i in ops[2]:
			val /= (1 + i)
		val /= (1 + sum(ops[1]))
		val -= sum(ops[0])
		base = val

@abstract func get_base() -> Variant

@warning_ignore("unused_parameter")
func set_base(val: Variant) -> void:
	pass

func get_ops() -> Array:
	var type = typeof(base)
	var op0 = []
	var op1 = []
	var op2 = []
	for modifier in modifiers:
		if typeof(modifier.amount) != type:
			continue
		match modifier.operation:
			Modifier.Operation.ADD_VALUE:
				op0.push_back(modifier.amount)
			Modifier.Operation.ADD_MUL_BASE:
				op1.push_back(modifier.amount)
			Modifier.Operation.ADD_MUL_TOTAL:
				op2.push_back(modifier.amount)
	return [op0, op1, op2]

func sum(a: Array) -> Variant:
	return a.reduce(func(acc, x): return acc + x, 0)

static func get_attr(node: Node, attr_name: String, default: Variant = null) -> Variant:
	var attribute = node.get_node_or_null(attr_name.to_pascal_case())
	if not attribute is Attribute:
		attribute = node.get(attr_name.to_snake_case())
		if attribute == null:
			return default
		return attribute
	return attribute.value

## 设置属性的基础值
static func set_attr_base(node: Node, attr_name: String, base_val: Variant) -> void:
	var attribute = node.get_node_or_null(attr_name.to_pascal_case())
	if not attribute is Attribute:
		node.set(attr_name.to_snake_case(), base_val)
		return
	attribute.base = base_val

## 设置经过修饰后的属性值
static func set_attr_value(node: Node, attr_name: String, val: Variant) -> void:
	var attribute = node.get_node_or_null(attr_name.to_pascal_case())
	if not attribute is Attribute:
		node.set(attr_name.to_snake_case(), val)
		return
	attribute.value = val