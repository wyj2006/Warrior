use bevy::prelude::*;
use godot::prelude::*;

///Container的成员exclude在godot中的类型
pub type GExcludeType = Array<GString>;

#[derive(Component, Default)]
pub struct Container {
    pub exclude: Vec<String>, //不属于容器内容的节点名称
}

pub fn transform_exclude_type(a: Array<GString>) -> Vec<String> {
    let mut exclude = Vec::new();
    for i in a.iter_shared() {
        exclude.push(i.to_string());
    }
    exclude
}
