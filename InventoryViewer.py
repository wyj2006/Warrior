from PyQt5.QtWidgets import (
    QListWidget,
    QListWidgetItem,
    QPushButton,
    QWidget,
    QGridLayout,
    QGroupBox,
)

from BodyPart import Body
from Events import NextTurnEvent
from GameObject import GameObject
from Item import Item
from ActionViewer import ActionViewer
from Player import Player, RightHand


class InventoryViewer(QWidget):
    """浏览库存(Player)"""

    def __init__(self, player: Player):
        super().__init__()
        self.resize(1000, 618)

        self.player = player
        self.player.installEventFilter(self)

        self.setLayout(QGridLayout())

        self.refresh()

    def refresh(self):
        while self.layout().count():
            item = self.layout().takeAt(0)
            widget = item.widget()
            if widget is not None:
                widget.deleteLater()  # 安排删除控件

        for t in (RightHand, Body):
            groupbox = QGroupBox(self)
            groupbox.setTitle(str(t))

            listwidget = QListWidget(groupbox)
            for item in self.player.get(t, "*", Item):
                listitem = QListWidgetItem()
                viewer = QPushButton()
                viewer.adjustSize()
                viewer.setText(str(item))
                viewer.clicked.connect(lambda _, o=item: ActionViewer(o).show())
                listitem.setSizeHint(viewer.size())
                listwidget.addItem(listitem)
                listwidget.setItemWidget(listitem, viewer)

            groupbox.setLayout(QGridLayout())
            groupbox.layout().addWidget(listwidget)

            self.layout().addWidget(groupbox)

    def eventFilter(self, obj, e):
        if isinstance(e, NextTurnEvent):
            self.refresh()
        return super().eventFilter(obj, e)
