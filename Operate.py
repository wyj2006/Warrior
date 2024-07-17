from PyQt5.QtWidgets import qApp

from typing import Any
from Events import NextTurnEvent
from GameObject import GameObject


class Operate(GameObject):
    """操作"""

    def __init__(self, name, parent=None):
        super().__init__(parent)
        self.name = name  # 操作名称

    def __call__(self, *args: Any, **kwds: Any) -> Any:
        """执行操作"""
        if self.isPlayer():
            qApp.sendEvent(GameObject.getObject(self, "/")[0], NextTurnEvent())

    def isPlayer(self):
        """是否属于玩家操作"""
        from Player import Player

        p = self
        while p != None:
            if isinstance(p, Player):
                return True
            p = p.parent()
        return False
