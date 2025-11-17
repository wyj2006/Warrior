use crate::GameState;
use crate::attribute::{Attribute, Speed};
use bevy::prelude::*;
use godot::classes::*;
use godot::prelude::*;
use godot_bevy::prelude::*;

#[derive(Component, Default)]
pub struct UserController;

pub fn control_user_in_waitinput(
    mut next: ResMut<NextState<GameState>>,
    mut action_events: EventReader<ActionInput>,
    query: Query<(&mut GodotNodeHandle, &Speed), (With<UserController>, With<RigidBody2DMarker>)>,
) {
    let mut move_up = false;
    let mut move_down = false;
    let mut move_left = false;
    let mut move_right = false;
    let mut pickup = false;

    for event in action_events.read() {
        if event.strength == 0. {
            continue;
        }
        match event.action.as_str() {
            "move_up" => move_up = true,
            "move_down" => move_down = true,
            "move_left" => move_left = true,
            "move_right" => move_right = true,
            "move_upleft" => {
                move_up = true;
                move_left = true;
            }
            "move_downleft" => {
                move_down = true;
                move_left = true;
            }
            "move_upright" => {
                move_up = true;
                move_right = true;
            }
            "move_downright" => {
                move_down = true;
                move_right = true;
            }
            "pickup" => {
                pickup = true;
            }
            _ => continue,
        }
    }

    if move_up || move_down || move_left || move_right {
        for (mut handle, speed) in query {
            let speed = speed.value();
            let Some(mut rigid_body) = handle.try_get::<RigidBody2D>() else {
                continue;
            };
            let mut velocity = Vector2::new(0.0, 0.0);

            if move_up {
                velocity.y = -speed;
            }
            if move_down {
                velocity.y = speed;
            }
            if move_right {
                velocity.x = speed;
            }
            if move_left {
                velocity.x = -speed;
            }
            rigid_body.set_linear_velocity(velocity);
        }
        next.set(GameState::WaitInput);
    } else if pickup {
        next.set(GameState::WaitUserPickUp);
    }
}

pub fn control_user_in_waituserpickup(
    mut next: ResMut<NextState<GameState>>,
    mut action_events: EventReader<ActionInput>,
) {
    for event in action_events.read() {
        if event.strength == 0. {
            continue;
        }
        match event.action.as_str() {
            "ui_accept" => next.set(GameState::UserPickingUp),
            "ui_cancel" => next.set(GameState::WaitInput),
            _ => continue,
        }
    }
}
