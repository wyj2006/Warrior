from PyQt5.QtWidgets import (
    QListWidget,
    QWidget,
    QListWidgetItem,
    QGridLayout,
    QLabel,
    QPushButton,
    QSpacerItem,
    QSizePolicy,
)

from Item import Item
from Player import Player


class ItemViewer(QWidget):
    def __init__(self, item: Item):
        super().__init__()
        self.setLayout(QGridLayout())

        self.item = item

        self.le_name = QLabel()
        self.le_name.setText(str(item))
        self.layout().addWidget(self.le_name, 0, 0)

        self.layout().addItem(
            QSpacerItem(0, 0, QSizePolicy.Policy.Expanding, QSizePolicy.Policy.Minimum),
            0,
            1,
        )

        self.pb_throw = QPushButton()
        self.pb_throw.setText(self.tr("丢弃"))
        self.layout().addWidget(self.pb_throw, 0, 2)

        self.adjustSize()


class InventoryViewer(QListWidget):
    """浏览库存(Player)"""

    def __init__(self, player: Player):
        super().__init__()
        self.resize(1000, 618)

        self.player = player

        self.refresh()

    @property
    def inventory(self):
        return self.player.inventory

    def refresh(self):
        self.clear()

        for item in self.inventory:
            listitem = QListWidgetItem()
            itemviewer = ItemViewer(item)
            itemviewer.pb_throw.clicked.connect(
                lambda _, item=item: (item.throw(), self.refresh())
            )
            listitem.setSizeHint(itemviewer.size())
            self.addItem(listitem)
            self.setItemWidget(listitem, itemviewer)
