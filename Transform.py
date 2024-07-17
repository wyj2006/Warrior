from PyQt5.QtCore import Qt

from Disable import Disable
from GameObject import GameObject


class Transform(GameObject):
    """指示空间物体的位置"""

    @staticmethod
    def globalXYZ(self: GameObject) -> tuple[int, int, int]:
        """获取self的全局坐标"""
        flag = True
        x, y, z = 0, 0, 0
        p = self
        while p != None:
            transform: Transform = GameObject.getObject(p, Transform)
            if transform:
                transform = transform[0]
                x += transform.x
                y += transform.y
                z += transform.z
                flag = False
            p = p.parent()
        if flag:
            raise Exception(f"{self}没有空间坐标")
        return x, y, z

    def __init__(self, parent: GameObject, x=0, y=0, z=0):
        assert (
            GameObject.getObject(parent, Transform) == []
        ), "一个对象只能有一个Transform"
        super().__init__(parent)
        self.x = x
        self.y = y
        self.z = z
