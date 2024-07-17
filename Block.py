from Collider import Collider
from GameObject import GameObject
from Texture import Texture
from Transform import Transform


class Block(GameObject):
    """方块"""

    def __init__(self, texture: Texture, x=0, y=0, z=0, parent=None):
        super().__init__(parent)
        texture.setParent(self)
        Transform(self, x, y, z)
        Collider(self)


class Floor(Block):
    def __init__(self, x=0, y=0, z=0, parent=None):
        super().__init__(Texture(chr(0), back_color=(100, 100, 100)), x, y, z, parent)


class Wall(Block):
    def __init__(self, x=0, y=0, z=0, parent=None):
        super().__init__(Texture("O"), x, y, z, parent)
