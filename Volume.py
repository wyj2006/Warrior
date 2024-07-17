from GameObject import GameObject


class Volume(GameObject):
    """指示父对象的体积"""

    def __init__(self, parent, val: float = 0):
        super().__init__(parent)
        self.val = val
