from GameObject import GameObject


class Transform(GameObject):
    """指示空间物体的位置"""

    @staticmethod
    def globalPos(obj: GameObject) -> tuple[int, int, int]:
        """获取self的全局坐标"""
        flag = True
        x, y, z = 0, 0, 0
        p = obj
        while p != None:
            transform: Transform = p.get(Transform)
            if transform:
                transform = transform[0]
                x += transform.x
                y += transform.y
                z += transform.z
                flag = False
            p = p.parent()
        if flag:
            raise Exception(f"{obj}没有空间坐标")
        return x, y, z

    def __init__(self, parent: GameObject, x=0, y=0, z=0):
        for i in parent.get(Transform):  # 父对象只保留一个Transform
            i.deleteLater()
        super().__init__(parent)
        self.x = x
        self.y = y
        self.z = z
