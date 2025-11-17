pub mod components;
pub mod entities;

use bevy::{prelude::*, state::app::StatesPlugin};
use components::*;
use godot::prelude::*;
use godot_bevy::prelude::*;

#[bevy_app]
fn build_app(app: &mut App) {
    app.add_plugins(GodotDefaultPlugins)
        .add_plugins(StatesPlugin)
        .init_state::<GameState>()
        .add_event::<PickUpEvent>()
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
