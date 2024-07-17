from Events import NextTurnEvent
from GameObject import GameObject
from HeartPoint import HeartPoint
from Operate import Operate


class Kill(Operate):
    def __init__(self, parent=None):
        super().__init__("杀死", parent)
        self.name = self.tr("杀死")

    def __call__(self):
        getattr(self, "kill", lambda _: None)(self.parent())

        self.parent().setParent(None)

        super().__call__()

    def event(self, e):
        if isinstance(e, NextTurnEvent):
            h: HeartPoint
            for h in GameObject.getObject(self, "..", HeartPoint):
                if h.val <= h.min_val:
                    self()
                    break
        return super().event(e)
