from Item import Item
from Store import Storable
from Texture import Texture
from Wield import Wieldable


class Sword(Item):
    def __init__(self, parent=None):
        super().__init__(parent)

        Texture("/", self, fore_color=(255, 255, 0))
        Wieldable(self)
        Storable(self)

        self.damage = 10
