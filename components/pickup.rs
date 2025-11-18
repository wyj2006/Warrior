use crate::GameState;
use crate::NodeEntityMap;
use crate::components::*;
use bevy::prelude::*;
use godot::prelude::*;
use godot_bevy::prelude::*;

#[derive(Component, Default, Debug)]
pub struct PickUp {
    pub can_pick: bool,      //是否可以拾取
    pub can_be_picked: bool, //是否可以被拾取
    pub detector: Option<InstanceId>,
    pub pick_area_size: Vector2,
}

#[derive(GodotClass)]
#[class(init,base=Area2D)]
pub struct PickDetector {
    #[var]
    pub area_size: Vector2,
    #[var]
    pub in_area: Array<i64>, //存的是PickDetector的node id
}

#[derive(GodotClass)]
#[class(init,base=CanvasLayer)]
pub struct PickUpUi {
    //都包含拥有PickUp组件的node id
    #[var]
    pub objects_to_pick: Dictionary,
    #[var]
    pub containers: Dictionary,
    #[var]
    pub container_contents: Dictionary,
}

#[derive(Event, Debug)]
pub struct PickUpEvent {
    pub container: Entity,
    pub object: Entity,
}

#[main_thread_system]
pub fn install_pick_detector(query: Query<(&mut GodotNodeHandle, &mut PickUp), Added<PickUp>>) {
    for (mut handle, mut pick_up) in query {
        if !pick_up.can_pick && !pick_up.can_be_picked {
            continue;
        }
        if let Some(_) = pick_up.detector {
            continue;
        }
        let Some(mut node) = handle.try_get::<Node>() else {
            continue;
        };
        let mut pick_detector =
            match try_load::<PackedScene>("res://components/pickup/pick_detector.tscn") {
                Ok(t) => t.instantiate_as::<PickDetector>(),
                Err(_) => continue,
            };
        pick_detector.bind_mut().area_size = pick_up.pick_area_size;
        node.add_child(&pick_detector);
        pick_up.detector = Some(pick_detector.instance_id());
    }
}

#[main_thread_system]
pub fn spawn_pick_up_ui(
    players: Query<(&mut GodotNodeHandle, &PickUp), With<UserController>>,
    mut query: ParamSet<(
        Query<(&mut GodotNodeHandle, &PickUp, Option<&DisplayName>), Without<UserController>>,
        Query<
            (&mut GodotNodeHandle, Option<&DisplayName>),
            (With<Container>, Without<UserController>),
        >,
    )>,
) {
    for (mut player_handle, player_pickup) in players {
        if !player_pickup.can_pick {
            continue;
        }
        let Some(mut player) = player_handle.try_get::<Node>() else {
            continue;
        };
        let Some(detector_id) = player_pickup.detector else {
            continue;
        };
        let pick_detector: Gd<PickDetector> = Gd::from_instance_id(detector_id);
        let in_player_area = &pick_detector.bind().in_area;

        let mut pick_up_ui =
            match try_load::<PackedScene>("res://components/pickup/pick_up_ui.tscn") {
                Ok(t) => t.instantiate_as::<PickUpUi>(),
                Err(_) => continue,
            };
        {
            //实在不知道取啥名
            let mut pick_up_ui = pick_up_ui.bind_mut();

            for (mut object_handle, object_pickup, display_name) in query.p0().iter_mut() {
                if !object_pickup.can_be_picked {
                    continue;
                }
                let Some(object) = object_handle.try_get::<Node>() else {
                    continue;
                };
                let Some(detector_id) = object_pickup.detector else {
                    continue;
                };
                if in_player_area.contains(detector_id.to_i64()) {
                    pick_up_ui.objects_to_pick.set(
                        object.instance_id(),
                        GString::from(&match display_name {
                            Some(t) => t.value(),
                            None => object.get_name().to_string(),
                        }),
                    );
                }
            }

            for (mut container_handle, display_name) in query.p1().iter_mut() {
                let Some(container) = container_handle.try_get::<Node>() else {
                    continue;
                };
                if !container.is_inside_tree() {
                    continue;
                }
                //这个container是否属于player
                if player.get_path_to(&container).to_string().starts_with("..") {
                    continue;
                }

                pick_up_ui.containers.set(
                    container.instance_id(),
                    GString::from(&match display_name {
                        Some(t) => t.value(),
                        None => container.get_name().to_string(),
                    }),
                );
            }
        }

        player.add_child(&pick_up_ui);
    }
}

#[main_thread_system]
pub fn unspawn_pick_up_ui(query: Query<&mut GodotNodeHandle, With<CanvasLayerMarker>>) {
    for mut handle in query {
        let Some(node) = handle.try_get::<PickUpUi>() else {
            continue;
        };
        if let Some(mut parent) = node.get_parent() {
            parent.remove_child(&node);
        }
    }
}

///将用户选择要拾取的东西提交到event中
#[main_thread_system]
pub fn submit_user_pick_up(
    node_entity_map: Res<NodeEntityMap>,
    mut next: ResMut<NextState<GameState>>,
    mut pick_up_events: EventWriter<PickUpEvent>,
    query: Query<&mut GodotNodeHandle, With<CanvasLayerMarker>>,
) {
    for mut handle in query {
        let Some(node) = handle.try_get::<PickUpUi>() else {
            continue;
        };
        for (container_id, object_ids) in node.bind().container_contents.iter_shared() {
            let Ok(container_id) = container_id.try_to::<i64>() else {
                continue;
            };
            let Ok(object_ids) = object_ids.try_to::<Dictionary>() else {
                continue;
            };
            for (object_id, _) in object_ids.iter_shared() {
                let Ok(object_id) = object_id.try_to::<i64>() else {
                    continue;
                };
                pick_up_events.write(PickUpEvent {
                    container: node_entity_map.0[&container_id],
                    object: node_entity_map.0[&object_id],
                });
            }
        }
    }
    next.set(GameState::WaitInput);
}

#[main_thread_system]
pub fn pick_up(
    node_entity_map: Res<NodeEntityMap>,
    mut pick_up_events: EventReader<PickUpEvent>,
    mut query: Query<&mut PickUp>,
) {
    for event in pick_up_events.read() {
        let Ok(container) = Gd::<Node>::try_from_instance_id(InstanceId::from_i64(
            node_entity_map.1[&event.container],
        )) else {
            continue;
        };
        let Ok(mut object) = Gd::<Node>::try_from_instance_id(InstanceId::from_i64(
            node_entity_map.1[&event.object],
        )) else {
            continue;
        };
        if let Ok(mut t) = query.get_mut(event.object) {
            t.can_be_picked = false;
        }
        object.reparent(&container);
    }
}
