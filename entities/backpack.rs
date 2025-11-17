use crate::components::*;
use bevy::prelude::*;
use godot::prelude::*;
use godot_bevy::prelude::*;

#[derive(Bundle, GodotNode, Default)]
#[godot_node(base(Node2D), class_name(Backpack2D))]
pub struct BackpackBundle {
    #[export_fields(kind(export_type(GString), transform_with(gstring_to_string)))]
    pub item: Item,
    #[export_fields(exclude(export_type(GExcludeType), transform_with(transform_exclude_type)))]
    pub container: Container,
    #[export_fields(basic_name(
        export_type(GString),
        transform_with(gstring_to_string),
        default(GString::from("背包"))
    ))]
    pub display_name: DisplayName,
}
