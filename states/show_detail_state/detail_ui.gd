extends CanvasLayer

@onready var player = $/root/Game/%Player
@onready var item_component = $"..".item_component

func _ready() -> void:
    var controls = []
    for i in item_component.get_parent().get_children():
        var detail_component = i.get_node_or_null("DetailComponent")
        if detail_component == null:
            continue
        var control = detail_component.get_control.call()
        if control != null:
            controls.append([detail_component.priority, detail_component.get_control.call()])
    controls.sort_custom(func(a, b): return a[0] > b[0])
    for i in controls:
        $"%Details".add_child(i[1])

    var item = item_component.get_parent()
    for action in player.get_children():
        var action_component: ActionComponent = action.get_node_or_null("ActionComponent")
        if action_component == null:
            continue
        if not action_component.can_be_done.call(item):
            continue
        var button: Button = Button.new()
        button.text = NameAttribute.get_self_name(action)
        button.connect("pressed", func():
            for child in $"%ActionCandidates".get_children():
                $"%ActionCandidates".remove_child(child)
            var available_actions = action_component.get_available_action.call(item)
            for action_name in available_actions:
                var button2 = Button.new()
                button2.text = action_name
                button2.connect("pressed", func():
                    available_actions[action_name].call()
                    $"%ActionCandidates".hide()
                )
                $"%ActionCandidates".add_child(button2)
            $"%ActionCandidates".popup()
        )
        $"%Actions".add_child(button)
