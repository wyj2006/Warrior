from PyQt5.QtWidgets import qApp

from Events import NextTurnEvent
from GameObject import GameObject


class Action(GameObject):
    """行为"""

    def __call__(self):
        from Player import Player

        if isinstance(self.parent(), Player):
            qApp.sendEvent(self.get("/")[0], NextTurnEvent())
