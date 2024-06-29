from PyQt5.QtCore import QObject

from Tile import Tile
from World import World


class Entity(QObject):
    id: str
    name: str

    def __init__(self, world: World, *args, **kwargs):
        super().__init__(world)
        self.tile = Tile(chr(0))

        self._x = 0.0
        self._y = 0.0
        self._z = 0.0

        self._init(*args, **kwargs)

    @property
    def world(self):
        return self.parent()

    def _init(self):
        """自定义的初始化函数"""

    @property
    def x(self):
        return int(self._x)

    @property
    def y(self):
        return int(self._y)

    @property
    def z(self):
        return int(self._z)

    def __str__(self):
        return self.name

    def kill(self):
        self.world.entities.remove(self)
