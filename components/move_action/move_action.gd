extends CharacterBody2D

## 移动组件
## 用于移动, 速度由SpeedAttribute提供

var speed: float:
    get:
        var speed_component = get_parent().get_node_or_null("SpeedAttribute")
        if speed_component == null:
            return 0
        return speed_component.speed

var last_direction = null

@onready var target: Node2D = get_parent() # 移动的目标
@onready var tile_manager = $/root/Game/%TileManager
@onready var tile_width = tile_manager.tile_width
@onready var tile_height = tile_manager.tile_height


func _ready() -> void:
    $CollisionShape2D.shape.size = Vector2(tile_width / 2 - 1, tile_height / 2 - 1)

func move(direction: Vector2):
    if last_direction == null or last_direction != direction:
        position = Vector2(0, 0)
    var motion = Vector2(direction.x * tile_width, direction.y * tile_height) * speed
    move_and_collide(motion)
    #这里默认target的大小与tile的大小相同
    if abs(position.x) >= tile_width or abs(position.y) >= tile_height: # 移到了下一个块中
        @warning_ignore("integer_division")
        target.position.x += (int(position.x) / tile_width) * tile_width
        @warning_ignore("integer_division")
        target.position.y += (int(position.y) / tile_height) * tile_height
        position = Vector2(0, 0)
    last_direction = direction
