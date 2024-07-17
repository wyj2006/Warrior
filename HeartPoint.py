from GameObject import GameObject


class HeartPoint(GameObject):
    def __init__(self, parent=None, val=100, min_val=0, max_val=100):
        super().__init__(parent)
        self._val = val
        self.max_val = max_val
        self.min_val = min_val

    @property
    def val(self):
        return self._val

    @val.setter
    def val(self, v):
        self._val = v
        if self._val > self.max_val:
            self._val = self.max_val
        if self._val < self.min_val:
            self._val = self.min_val
