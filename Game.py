from PyQt5.QtWidgets import qApp

from GameObject import GameObject
from World import World


class Game(GameObject):
    def __init__(self):
        super().__init__()

        self.world = World()

    def event(self, e):
        qApp.sendEvent(self.world, e)
        return super().event(e)
