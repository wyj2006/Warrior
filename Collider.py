from GameObject import GameObject
from Transform import Transform


class Collider(GameObject):
    """碰撞器"""

    def __init__(self, parent=None, x_size=1, y_size=1, z_size=1):
        super().__init__(parent)

        # 碰撞箱在各个方向的大小
        self.x_size = x_size
        self.y_size = y_size
        self.z_size = z_size

        Transform(self)  # 碰撞器的相对位置

    def detect(self) -> bool:
        """检测碰撞"""
        x, y, z = Transform.globalXYZ(self)

        collider: Collider
        for collider in GameObject.getObject(self, "/", "*", Collider):
            if collider == self:
                continue
            cx, cy, cz = Transform.globalXYZ(collider)
            if (
                cx < x + self.x_size
                and cx + collider.x_size > x
                and cy < y + self.y_size
                and cy + collider.y_size > y
                and cz < z + self.z_size
                and cz + collider.y_size > z
            ):
                return True
        return False
