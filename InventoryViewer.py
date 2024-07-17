from PyQt5.QtWidgets import (
    QListWidget,
    QListWidgetItem,
    QPushButton,
    QWidget,
    QGridLayout,
    QGroupBox,
)

from GameObject import GameObject
from Item import Item
from OperateViewer import OperateViewer
from Player import Body, Player, RightHand


class InventoryViewer(QWidget):
    """浏览库存(Player)"""

    def __init__(self, player: Player):
        super().__init__()
        self.player = player

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
            for item in GameObject.getObject(self.player, t, "*", Item):
                listitem = QListWidgetItem()
                viewer = QPushButton()
                viewer.adjustSize()
                viewer.setText(str(item))
                viewer.clicked.connect(lambda _, o=item: OperateViewer(o).show())
                listitem.setSizeHint(viewer.size())
                listwidget.addItem(listitem)
                listwidget.setItemWidget(listitem, viewer)

            groupbox.setLayout(QGridLayout())
            groupbox.layout().addWidget(listwidget)

            self.layout().addWidget(groupbox)

        self.adjustSize()
