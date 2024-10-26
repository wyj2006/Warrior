from GameObject import GameObject
from Generators import generate_room
from Player import Player


class World(GameObject):
    """世界, 父对象必须为None"""

    def __init__(self):
        super().__init__()
        Player(self)
        generate_room(self, 2)
