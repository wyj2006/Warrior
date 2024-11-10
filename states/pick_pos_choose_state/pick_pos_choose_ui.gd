extends CanvasLayer


func _ready() -> void:
    for i in [
        ["%Up", "move_up"],
        ["%Down", "move_down"],
        ["%Right", "move_right"],
        ["%Left", "move_left"],
        ["%UpRight", "move_upright"],
        ["%UpLeft", "move_upleft"],
        ["%DownRight", "move_downright"],
        ["%DownLeft", "move_downleft"]
    ]:
        var text = ""
        for j in InputMap.action_get_events(i[1]):
            text += "("
            if is_instance_of(j, InputEventKey):
                text += j.as_text_physical_keycode()
            else:
                text += j.to_string()
            text += ")"
        get_node(i[0] + "/LabelKey").text = text