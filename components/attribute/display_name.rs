use super::Attribute;
use bevy::prelude::*;

#[derive(Component, Default)]
pub struct DisplayName {
    pub basic_name: String,
}

impl Attribute<String> for DisplayName {
    fn basic_value(&self) -> String {
        self.basic_name.clone()
    }
}
