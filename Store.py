from Disable import Disable
from GameObject import GameObject
from Operate import Operate
from Pick import Pick
from Throw import Throw


class Store(Operate):
    """存储"""

    def __init__(self, parent=None):
        super().__init__("存储", parent)
        self.name = self.tr("存储")

        Pick(self)

    def __call__(self, load: Operate):
        from Worn import Worn

        for i in GameObject.getObject(self, Operate):
            i()

        Disable(self)

        for t in (Throw, Worn):
            for i in GameObject.getObject(self, "..", t, ignore_disabled=False):
                for d in GameObject.getObject(i, Disable, ignore_disabled=False):
                    d.setParent(None)

        load(self.parent())

        super().__call__()
