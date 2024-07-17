from PyQt5.QtCore import QEvent, Qt
from PyQt5.QtWidgets import qApp

from Camera import Camera
from Collider import Collider
from Events import NextTurnEvent
from GameObject import GameObject
from Motion import Motion
from Texture import Texture
from Transform import Transform
from Wear import Wear


class KeyController(GameObject):
    """键盘控制器(通过键盘控制移动)"""

    @property
    def motion(self) -> Motion:
        return GameObject.getObject(self, "..", Motion)[0]

    def event(self, e: QEvent):
        if e.type() == QEvent.Type.KeyPress:
            if e.key() == Qt.Key.Key_Up:
                self.motion.move((0, 1, 0))
                qApp.sendEvent(GameObject.getObject(self, "/")[0], NextTurnEvent())
            if e.key() == Qt.Key.Key_Down:
                self.motion.move((0, -1, 0))
                qApp.sendEvent(GameObject.getObject(self, "/")[0], NextTurnEvent())
            if e.key() == Qt.Key.Key_Left:
                self.motion.move((-1, 0, 0))
                qApp.sendEvent(GameObject.getObject(self, "/")[0], NextTurnEvent())
            if e.key() == Qt.Key.Key_Right:
                self.motion.move((1, 0, 0))
                qApp.sendEvent(GameObject.getObject(self, "/")[0], NextTurnEvent())
        return super().event(e)


class Body(GameObject):
    """身体"""

    def __init__(self, parent=None):
        super().__init__(parent)

        Wear(self)


class RightHand(GameObject):
    """右手"""

    def __init__(self, parent=None) -> None:
        super().__init__(parent)

        Wear(self)


class Player(GameObject):
    def __init__(self, parent=None):
        super().__init__(parent)

        Texture("@", self)
        Transform(self)
        Motion(self)
        KeyController(self)
        Camera(self)
        Collider(self)
        Body(self)
        RightHand(self)
