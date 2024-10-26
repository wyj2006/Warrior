from GameObject import GameObject
from Transform import Transform


class Collider(GameObject):
    """碰撞器"""

    def __init__(self, parent, x_size=1, y_size=1, z_size=1):
        super().__init__(parent)

        # 碰撞箱在各个方向的大小
        self.x_size = x_size
        self.y_size = y_size
        self.z_size = z_size

    def detect(self) -> bool:
        """
        检测碰撞
        如果发生碰撞, 返回碰撞物体的坐标
        否则返回None
        """
        x, y, z = Transform.globalPos(self)

        collider: Collider
        for collider in self.get("/", "*", Collider):
            if collider == self:
                continue
            cx, cy, cz = Transform.globalPos(collider)
            if (
                cx < x + self.x_size
                and cx + collider.x_size > x
                and cy < y + self.y_size
                and cy + collider.y_size > y
                and cz < z + self.z_size
                and cz + collider.y_size > z
            ):
                return cx, cy, cz
        return None
