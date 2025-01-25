extends VBoxContainer

var attribute: AttributeComponent

func _ready() -> void:
    $"%Name".text = NameAttribute.get_self_name(attribute.get_parent())
    $"%Value".text = str(attribute.value)

    for i in attribute.get_parent().get_children():
        if i is AttributeContributor:
            var hbox = HBoxContainer.new()
            var label = Label.new()
            label.text = "->(" + str(i.contribute_mode) + ")"
            if i.source != null:
                label.text += NameAttribute.get_self_name(i.source)
            hbox.add_child(label)
            var detail_control = i.attribute.get_node("DetailComponent").get_control.call()
            if detail_control == null:
                continue
            hbox.add_child(detail_control)
            $"%Contributors".add_child(hbox)

func _on_show_contributor_toggled(toggled_on: bool) -> void:
    if toggled_on:
        $"%Contributors".show()
        $"%Value".text = str(attribute.value) + "(基础: " + str(attribute.basic_value) + ")"
    else:
        $"%Contributors".hide()
        $"%Value".text = str(attribute.value)
