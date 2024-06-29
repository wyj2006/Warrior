class Camera:
    """摄像机"""

    def __init__(self, follow=None):
        self.follow = follow
        self._x = 0
        self._y = 0
        self._z = 0

    @property
    def x(self):
        return getattr(self.follow, "x", self._x)

    @property
    def y(self):
        return getattr(self.follow, "y", self._y)

    @property
    def z(self):
        return getattr(self.follow, "z", self._z)
