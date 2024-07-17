from GameObject import GameObject
from Operate import Operate
from Store import Store
from Throw import Throw


class Wear(Operate):
    def __init__(self, parent=None):
        super().__init__("穿戴", parent)
        self.name = self.tr("穿戴")

    def __call__(self, target):
        target.setParent(self.parent())

        for t in (Store, Throw):
            for op in GameObject.getObject(target, t):
                Undress(op)

        super().__call__()


class Undress(Operate):
    """脱下, 作为子操作使用"""

    def __init__(self, target, parent: Operate = None):
        """将parent从target中脱下"""
        super().__init__("脱下", parent)
        self.name = self.tr("脱下")
        self.target = target

    def __call__(self):
        self.parent().setParent(None)

        self.setParent(None)  # 只能脱一次

        super().__call__()
