use bevy::prelude::*;
use godot::prelude::*;

#[derive(Component, Default)]
pub struct Item {
    pub kind: String,
}

pub fn gstring_to_string(gstr: GString) -> String {
    gstr.to_string()
}
