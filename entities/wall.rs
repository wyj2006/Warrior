use bevy::prelude::*;
use godot_bevy::prelude::*;

#[derive(Bundle, GodotNode, Default)]
#[godot_node(base(StaticBody2D), class_name(Wall2D))]
pub struct WallBundle {}
