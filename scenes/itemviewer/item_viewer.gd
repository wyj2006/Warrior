extends Dock

@export var item: Node

var AttrViewerScene = preload("res://scenes/attrviewer/attr_viewer.tscn")

func _ready() -> void:
	var tile_texture = item.get_node_or_null("TileTexture")
	if tile_texture != null:
		$%Texture.texture = tile_texture.texture
	else:
		$%Texture.hide()
	$%Name.text = DisplayName.get_full(item, item.name)
	for child in item.get_children():
		if child is Attribute:
			var attr_viewer = AttrViewerScene.instantiate()
			attr_viewer.attribute = child
			$%Attributes.add_child(attr_viewer)