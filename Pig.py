import random

from Attack import Attacked
from Collider import Collider
from Events import NextTurnEvent
from GameObject import GameObject
from HeartPoint import HeartPoint
from Kill import Kill
from Motion import Motion
from Texture import Texture
from Transform import Transform


class AIController(GameObject):
    @property
    def motion(self) -> Motion:
        return GameObject.getObject(self, "..", Motion)[0]

    def doTurn(self):
        self.motion.move(tuple(random.randint(-1, 1) for _ in range(2)) + (0,))

    def event(self, e):
        if isinstance(e, NextTurnEvent):
            self.doTurn()
        return super().event(e)


class Pig(GameObject):
    def __init__(self, parent, x=0, y=0, z=0):
        super().__init__(parent)

        Texture("P", self)
        Transform(self, x, y, z)
        Motion(self)
        Collider(self)
        AIController(self)
        Attacked(self)
        Kill(self)
        HeartPoint(self)
