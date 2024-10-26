from PyQt5.QtCore import QEvent, Qt

from GameObject import GameObject
from Move import Move


class KeyController(GameObject):
    """键盘控制器(通过键盘控制移动)"""

    @property
    def move(self) -> Move:
        return self.get("..", Move)[0]

    def event(self, e: QEvent):
        if e.type() == QEvent.Type.KeyPress:
            if e.key() == Qt.Key.Key_Up:
                self.move((0, 1, 0))
            if e.key() == Qt.Key.Key_Down:
                self.move((0, -1, 0))
            if e.key() == Qt.Key.Key_Left:
                self.move((-1, 0, 0))
            if e.key() == Qt.Key.Key_Right:
                self.move((1, 0, 0))
        return super().event(e)
