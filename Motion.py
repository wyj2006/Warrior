from Collider import Collider
from GameObject import GameObject
from Transform import Transform


class Motion(GameObject):
    """赋予父对象运动的能力"""

    def __init__(self, parent, speed: float = 1):
        super().__init__(parent)

        self._x = self.transform.x
        self._y = self.transform.y
        self._z = self.transform.z

        self.speed = speed

    @property
    def transform(self) -> Transform:
        return GameObject.getObject(self, "..", Transform)[0]

    @property
    def colliders(self) -> list[Collider]:
        return GameObject.getObject(self, "..", Collider)

    @property
    def x(self):
        return self._x

    @x.setter
    def x(self, val):
        self._x = val
        self.transform.x = int(self._x)

    @property
    def y(self):
        return self._y

    @y.setter
    def y(self, val):
        self._y = val
        self.transform.y = int(self._y)

    @property
    def z(self):
        return self._z

    @z.setter
    def z(self, val):
        self._z = val
        self.transform.z = int(self._z)

    def move(self, vec: tuple[int, int, int]):
        """朝vec的方向移动"""
        _x = self.x
        _y = self.y
        _z = self.z
        self.x += vec[0] * self.speed
        self.y += vec[1] * self.speed
        self.z += vec[2] * self.speed

        for collider in self.colliders:
            if collider.detect():
                self.x = _x
                self.y = _y
                self.z = _z
                break
