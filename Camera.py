from GameObject import GameObject
from Transform import Transform


class Camera(GameObject):
    """摄像机"""

    def __init__(self, parent=None):
        super().__init__(parent)
        Transform(self)

    @property
    def x(self):
        return Transform.globalPos(self)[0]

    @property
    def y(self):
        return Transform.globalPos(self)[1]

    @property
    def z(self):
        return Transform.globalPos(self)[2]
