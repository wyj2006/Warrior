use super::Attribute;
use bevy::prelude::*;

#[derive(Component, Default)]
pub struct Speed {
    pub basic_speed: f32,
}

impl Attribute<f32> for Speed {
    fn basic_value(&self) -> f32 {
        self.basic_speed
    }
}
