from Disable import Disable
from GameObject import GameObject
from Operate import Operate
from Pick import Pick
from Texture import Texture
from Transform import Transform


class Throw(Operate):
    """丢弃"""

    def __init__(self, parent=None):
        super().__init__("丢弃", parent)
        self.name = self.tr("丢弃")

        Pick(self)

        self.origin = self.parent().parent()

    def __call__(self):
        from Worn import Worn
        from Store import Store

        for i in GameObject.getObject(self, Operate):
            i()

        # 恢复空间信息
        for texture in GameObject.getObject(self, "..", Texture, ignore_disabled=False):
            for d in GameObject.getObject(texture, Disable, ignore_disabled=False):
                d.setParent(None)

        Transform(self.parent(), *Transform.globalXYZ(self.parent()))

        Disable(self)

        for t in (
            Worn,
            Store,
        ):
            for i in GameObject.getObject(self, "..", t, ignore_disabled=False):
                for d in GameObject.getObject(i, Disable, ignore_disabled=False):
                    d.setParent(None)
                Pick(i)

        self.parent().setParent(self.origin)

        getattr(self.parent(), "throw", lambda: None)()
