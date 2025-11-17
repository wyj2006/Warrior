use crate::components::*;
use bevy::prelude::*;
use godot::prelude::*;
use godot_bevy::prelude::*;

#[derive(Bundle, GodotNode, Default)]
#[godot_node(base(Node2D), class_name(Sword2D))]
pub struct SwordBundle {
    #[export_fields(kind(export_type(GString), transform_with(gstring_to_string)))]
    pub item: Item,
    #[export_fields(
        can_pick(export_type(bool)),
        can_be_picked(export_type(bool), default(true)),
        pick_area_size(export_type(Vector2))
    )]
    pub pick_up: PickUp,
    #[export_fields(basic_name(
        export_type(GString),
        transform_with(gstring_to_string),
        default(GString::from("剑"))
    ))]
    pub display_name: DisplayName,
}
