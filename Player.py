from PyQt5.QtCore import QObject

from Drop import Drop
from Entity import Entity
from Item import Item
from Tile import Tile


class RightHand(QObject):
    def __init__(self, player: "Player"):
        super().__init__(player)

    @property
    def items(self) -> list[Item]:
        return self.findChildren(Item)


class Player(Entity):
    id = "Player"
    name = "Player"

    def _init(self):
        self.tile = Tile("@")
        self.speed = 0.1

        self.righthand = RightHand(self)

    @property
    def inventory(self):
        return self.righthand.items

    def move(self, vec: tuple[int, int]):
        assert vec[0] in (-1, 0, 1) and vec[1] in (-1, 0, 1)
        _x = self._x
        _y = self._y
        self._x += vec[0] * self.speed
        self._y += vec[1] * self.speed
        if not self.world.map.can_pass(self.x, self.y, self.z):
            self._x = _x
            self._y = _y
        self.world.game.do_turn()

    def throw(self, item: Item):
        Drop(self.world, self.x, self.y, self.z, item)
        self.world.game.do_turn()

    def pick(self, entity: Drop):
        entity.kill()
        self.world.game.do_turn()

    def equip(self, part: str, item: Item):
        item.setParent(self.__dict__[part])
        self.world.game.do_turn()
