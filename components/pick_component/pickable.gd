extends Node

## 被捡起
var picked: bool:
    get:
        return get_parent().get_parent().get_node_or_null("ZLayerComponent") == null