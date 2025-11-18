pub mod components;
pub mod entities;

use bevy::{prelude::*, state::app::StatesPlugin};
use components::*;
use godot::prelude::*;
use godot_bevy::prelude::*;
use std::collections::HashMap;

#[bevy_app]
fn build_app(app: &mut App) {
    app.add_plugins(GodotDefaultPlugins)
        .add_plugins(StatesPlugin)
        .init_state::<GameState>()
        .insert_resource(NodeEntityMap::default())
        .add_event::<PickUpEvent>()
        .add_systems(Update, sync_node_entity_map)
        .add_systems(
            Update,
            control_user_in_waitinput.run_if(in_state(GameState::WaitInput)),
        )
        .add_systems(Update, install_pick_detector)
        .add_systems(Update, pick_up)
        .add_systems(OnEnter(GameState::WaitUserPickUp), spawn_pick_up_ui)
        .add_systems(
            Update,
            control_user_in_waituserpickup.run_if(in_state(GameState::WaitUserPickUp)),
        )
        .add_systems(OnExit(GameState::WaitUserPickUp), unspawn_pick_up_ui)
        .add_systems(OnEnter(GameState::UserPickingUp), submit_user_pick_up);
}

#[derive(States, Default, Debug, Clone, Eq, PartialEq, Hash)]
pub enum GameState {
    #[default]
    WaitInput,
    //用户选择需要拾取的东西
    WaitUserPickUp,
    UserPickingUp,
}

#[derive(Resource, Default)]
pub struct NodeEntityMap(HashMap<i64, Entity>, HashMap<Entity, i64>);

pub fn sync_node_entity_map(
    mut map: ResMut<NodeEntityMap>,
    added: Query<(Entity, &GodotNodeHandle), Added<GodotNodeHandle>>,
    mut removed: RemovedComponents<GodotNodeHandle>,
) {
    for (entity, handle) in added {
        let id = handle.instance_id().to_i64();
        map.0.insert(id, entity);
        map.1.insert(entity, id);
    }
    for entity in removed.read() {
        if let Some(id) = map.1.remove(&entity) {
            map.0.remove(&id);
        }
    }
}
