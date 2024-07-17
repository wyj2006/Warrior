from Disable import Disable
from GameObject import GameObject
from Operate import Operate
from Pick import Pick
from Throw import Throw
from Wear import Wear


class Worn(Operate):
    """被穿"""

    def __init__(self, parent=None):
        super().__init__("穿戴", parent)
        self.name = self.tr("穿戴")

        Pick(self)  # 先捡起来再穿

    def __call__(self, wear: Wear):
        from Store import Store

        for i in GameObject.getObject(self, Operate):
            i()

        Disable(self)

        for t in (Throw, Store):
            for i in GameObject.getObject(self, "..", t, ignore_disabled=False):
                for d in GameObject.getObject(i, Disable, ignore_disabled=False):
                    d.setParent(None)

        wear(self.parent())

        super().__call__()
