use crate::components::*;
use bevy::prelude::*;
use godot::prelude::*;
use godot_bevy::prelude::*;

#[derive(Bundle, GodotNode, Default)]
#[godot_node(base(RigidBody2D), class_name(Player2D))]
pub struct PlayerBundle {
    #[export_fields(basic_speed(export_type(f32)))]
    pub speed: Speed,
    pub controller: UserController,
    #[export_fields(
        can_pick(export_type(bool), default(true)),
        can_be_picked(export_type(bool)),
        pick_area_size(export_type(Vector2))
    )]
    pub pick_up: PickUp,
}
