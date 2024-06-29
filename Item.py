from PyQt5.QtCore import QObject

from typing import Any
from Material import Material
from Tile import Tile


class Item(QObject):
    id: str  # 物品标识符名称
    name: str  # 物品名称
    volume: float  # 体积
    weight: float  # 重量
    material: Material
    tile: Tile

    def __init__(self, material: Material, belongto=None):
        super().__init__(belongto)
        self.material = material

        self._init()

    def _init(self):
        pass

    @property
    def belongto(self):
        return self.parent()

    def throw(self):
        getattr(self.belongto, "throw", lambda _: None)(self)

    def __str__(self):
        return f"{self.name} ({self.material.name})"
