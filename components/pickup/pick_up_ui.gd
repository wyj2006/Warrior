extends PickUpUi

func _ready() -> void:
    update()

func update():
    $%ObjectList.clear()
    for child in $%ContainerList.get_children():
        $%ContainerList.remove_child(child)

    var display_name

    for id in objects_to_pick:
        display_name = objects_to_pick[id]
        $%ObjectList.add_item(display_name)
        
    for id in containers:
        if id not in container_contents:
            container_contents[id] = {}
        display_name = containers[id]
        var content_list = ItemList.new()
        content_list.connect("item_clicked", _on_content_list_item_clicked)
        content_list.name = display_name
        for object_id in container_contents[id]:
            content_list.add_item(container_contents[id][object_id])
        $%ContainerList.add_child(content_list)

func _on_ok_pressed() -> void:
    var event = InputEventAction.new()
    event.pressed = true
    event.action = "ui_accept"
    event.strength = 1
    Input.parse_input_event(event)

func _on_cancel_pressed() -> void:
    var event = InputEventAction.new()
    event.pressed = true
    event.action = "ui_cancel"
    event.strength = 1
    Input.parse_input_event(event)

func _on_object_list_item_clicked(index: int, _at_position: Vector2, _mouse_button_index: int) -> void:
    var object_id = objects_to_pick.keys()[index]
    var object_name = objects_to_pick[object_id]
    objects_to_pick.erase(object_id)
    var container_id = containers.keys()[$%ContainerList.current_tab]
    container_contents[container_id][object_id] = object_name
    update()

func _on_content_list_item_clicked(index: int, _at_position: Vector2, _mouse_button_index: int) -> void:
    var container_id = containers.keys()[$%ContainerList.current_tab]
    var object_id = container_contents[container_id].keys()[index]
    var object_name = container_contents[container_id][object_id]
    objects_to_pick[object_id] = object_name
    container_contents[container_id].erase(object_id)
    update()