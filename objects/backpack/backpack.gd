extends Node2D

var max_volumn: float:
	get:
		return MaxVolumnAttribute.get_max_volumn(get_parent())

## 判断放入这些节点是否可以
func available(nodes: Array[Node]) -> bool:
	var total_volumn = 0
	for node in nodes + get_parent().get_children():
		total_volumn += VolumnAttribute.get_volumn(node)
	return total_volumn <= max_volumn