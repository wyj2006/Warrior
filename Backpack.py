from Disable import Disable
from GameObject import GameObject
from Item import Item
from Load import Load
from Texture import Texture
from Throw import Throw
from Volume import Volume
from Worn import Worn


class Backpack(Item):
    """
    背包
    没有把握不要随便setParent, 否则后果自负
    """

    def __init__(self, parent):
        super().__init__(parent)

        Load(self)
        Worn(self)
        Disable(Throw(self))

        Texture(chr(233), self)

        self.max_volume = 1  # 最大体积

    def capacity(self):
        """获取当前背包的容量"""
        v = 0
        volume: Volume
        for volume in GameObject.getObject(self, "+", Volume):
            v += volume.val
        return v
