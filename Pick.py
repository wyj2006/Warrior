from typing import Any
from Disable import Disable
from GameObject import GameObject
from Operate import Operate
from Texture import Texture
from Transform import Transform


class Pick(Operate):
    """捡起, 作为子操作使用"""

    def __init__(self, parent: Operate = None):
        super().__init__("捡起", parent)
        self.name = self.tr("捡起")

    def __call__(self):
        for transform in GameObject.getObject(self, "..", "..", Transform):
            transform.setParent(None)
        for texture in GameObject.getObject(self, "..", "..", Texture):
            Disable(texture)

        self.setParent(None)  # 只能捡一次
