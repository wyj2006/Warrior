from Container import Container
from Item import Item
from Texture import Texture
from Wear import Wearable
from Wield import Wieldable


class Backpack(Item):
    """
    背包
    """

    def __init__(self, parent):
        super().__init__(parent)

        Texture(chr(233), self)
        Container(self)
        Wieldable(self)
        Wearable(self)
