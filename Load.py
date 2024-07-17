from GameObject import GameObject
from Operate import Operate
from Throw import Throw
from Worn import Worn


class Load(Operate):
    """作为容器装入物品"""

    def __init__(self, parent=None):
        super().__init__("装入", parent)
        self.name = self.tr("装入")

    def __call__(self, target):
        target.setParent(self.parent())

        for t in (Worn, Throw):
            for op in GameObject.getObject(target, t):
                Unload(op)

        super().__call__()


class Unload(Operate):
    """取出, 作为子操作使用"""

    def __init__(self, target, parent: Operate = None):
        """从target中取出parent"""
        super().__init__("取出", parent)
        self.name = self.tr("取出")
        self.target = target

    def __call__(self):
        self.parent().setParent(None)

        self.setParent(None)  # 只能取一次

        super().__call__()
