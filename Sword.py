from Attack import Attack
from Disable import Disable
from GameObject import GameObject
from HeartPoint import HeartPoint
from Item import Item
from Store import Store
from Texture import Texture
from Throw import Throw
from Volume import Volume
from Worn import Worn


class Sword(Item):
    def __init__(self, parent=None):
        super().__init__(parent)

        Worn(self)
        Store(self)
        Disable(Throw(self))
        Volume(self, 360e-6)
        Texture("/", self, fore_color=(255, 255, 0))
        Attack(self)

        self.damage = 10

    def attack(self, target):
        h: HeartPoint
        for h in GameObject.getObject(target, HeartPoint):
            h.val -= self.damage
