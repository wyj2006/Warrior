from PyQt5.QtWidgets import QWidget, QGridLayout, QPushButton

from Block import Block
from GameObject import GameObject
from Item import Item
from Load import Load
from Operate import Operate
from OperateViewer import OperateViewer
from Texture import Texture


class InteractPanel(QWidget):
    def __init__(self, obj):
        super().__init__()
        self.obj = obj

        self.setLayout(QGridLayout())

        self.refresh()

    def refresh(self):
        while self.layout().count():
            item = self.layout().takeAt(0)
            if item.widget() != None:
                item.widget().deleteLater()

        for item in GameObject.getObject(self.obj, "*", Item):
            viewer = QPushButton()
            viewer.adjustSize()
            viewer.setText(str(item))
            viewer.clicked.connect(lambda _, o=item: OperateViewer(o).show())
            self.layout().addWidget(viewer)


class Interact(Operate):
    """互动"""

    def __init__(self, parent=None):
        super().__init__("互动", parent)
        self.name = self.tr("互动")

    def __call__(self):
        self.interactpanel = InteractPanel(self.parent())
        self.interactpanel.show()
        super().__call__()


class Chest(Block):
    def __init__(self, x=0, y=0, z=0, parent=None):
        super().__init__(Texture(chr(239)), x, y, z, parent)

        Load(self)
        Interact(self)
