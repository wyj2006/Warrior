from Collider import Collider
from GameObject import GameObject
from Texture import Texture
from Transform import Transform


class Block(GameObject):
    """方块"""

    def __init__(self, x=0, y=0, z=0, parent=None):
        super().__init__(parent)
        Transform(self, x, y, z)
        Collider(self)


class Floor(Block):
    def __init__(self, x=0, y=0, z=0, parent=None):
        super().__init__(x, y, z, parent)
        Texture(chr(0), self, back_color=(100, 100, 100))


class Wall(Block):
    def __init__(self, x=0, y=0, z=0, parent=None):
        super().__init__(x, y, z, parent)
        Texture("O", self)
