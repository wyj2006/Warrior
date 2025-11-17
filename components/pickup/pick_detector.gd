extends PickDetector

func _ready() -> void:
	$CollisionShape2D.shape.size = area_size

func _on_area_entered(area: Area2D) -> void:
	if not area is PickDetector:
		return
	var id = area.get_instance_id()
	if id not in in_area:
		in_area.push_back(id)

func _on_area_exited(area: Area2D) -> void:
	if not area is PickDetector:
		return
	var id = area.get_instance_id()
	if id in in_area:
		in_area.erase(id)


func _on_tree_exited() -> void:
	for signal_name in ["area_entered", "area_exited", "body_entered", "body_exited"]:
		for i in get_signal_connection_list(signal_name):
			var callable = i["callable"]
			if callable != _on_area_entered && callable != _on_area_exited:
				disconnect(signal_name, callable)
