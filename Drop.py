from Entity import Entity
from Item import Item
from World import World


class Drop(Entity):
    """掉落物"""

    def _init(self, x, y, z, item: Item):
        self.tile = item.tile
        self._x = x
        self._y = y
        self._z = z
        self.id = item.id
        self.name = item.name
        self.item = item

    def __str__(self):
        return str(self.item)
