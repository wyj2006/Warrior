from typing import Any
from Block import Block
from Collider import Collider
from Disable import Disable
from GameObject import GameObject
from Operate import Operate
from Texture import Texture


class Open(Operate):
    def __init__(self, parent=None):
        super().__init__("打开", parent)
        self.name = self.tr("打开")

    def __call__(self) -> Any:
        getattr(self.parent(), "open", lambda: None)()


class Close(Operate):
    def __init__(self, parent=None):
        super().__init__("关闭", parent)
        self.name = self.tr("关闭")

    def __call__(self) -> Any:
        getattr(self.parent(), "close", lambda: None)()


class Door(Block):
    def __init__(self, x=0, y=0, z=0, parent=None):
        super().__init__(Texture("+"), x, y, z, parent)
        self.state = 0  # 0表示关闭, 1表示打开
        Open(self)
        Disable(Close(self))

    def open(self):
        self.state = 1
        self.change()

    def close(self):
        self.state = 0
        self.change()

    def change(self):
        if self.state == 0:
            for texture in GameObject.getObject(self, Texture):
                texture.setParent(None)
            Texture("+", self)
            if GameObject.getObject(self, Collider) == []:
                Collider(self)
            for d in GameObject.getObject(self, Open, Disable, ignore_disabled=False):
                d.setParent(None)
            Disable(GameObject.getObject(self, Close)[0])
        elif self.state == 1:
            for texture in GameObject.getObject(self, Texture):
                texture.setParent(None)
            Texture("-", self)
            for c in GameObject.getObject(self, Collider):
                c.setParent(None)
            for d in GameObject.getObject(self, Close, Disable, ignore_disabled=False):
                d.setParent(None)
            Disable(GameObject.getObject(self, Open)[0])
