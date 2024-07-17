from GameObject import GameObject
from World import World


class Game(GameObject):
    def __init__(self):
        super().__init__()

        self.world = World(self)
