from PyQt5.QtWidgets import (
    QWidget,
    QListWidgetItem,
    QGroupBox,
    QGridLayout,
    QListWidget,
    QLabel,
    QSpacerItem,
    QSizePolicy,
    QPushButton,
)

from Drop import Drop
from Entity import Entity
from Player import Player


class EntityViewer(QWidget):
    def __init__(self, entity: Entity):
        super().__init__()
        self.entity = entity

        self.setLayout(QGridLayout())

        self.le_name = QLabel()
        self.le_name.setText(str(entity))
        self.layout().addWidget(self.le_name, 0, 0)

        self.layout().addItem(
            QSpacerItem(0, 0, QSizePolicy.Policy.Expanding, QSizePolicy.Policy.Minimum),
            0,
            1,
        )

        self.pb_pick = QPushButton()
        self.pb_pick.setText(self.tr("拾取"))
        if isinstance(entity, Drop):
            self.layout().addWidget(self.pb_pick, 0, 2)

        self.adjustSize()


class Surroundings(QWidget):
    """周围东西"""

    def __init__(self, player: Player):
        super().__init__()
        self.resize(1000, 618)

        self.player = player

        self.setLayout(QGridLayout())
        self.refresh()

    def refresh(self):
        world = self.player.world
        x = self.player.x
        y = self.player.y
        z = self.player.z

        while self.layout().count():
            item = self.layout().takeAt(0)
            widget = item.widget()
            if widget is not None:
                widget.deleteLater()  # 安排删除控件

        i, j = 0, 0
        for vec_id, vec_name, vec in [
            ("northwest", "西北", (-1, 1)),
            ("north", "北", (0, 1)),
            ("northeast", "东北", (1, 1)),
            ("west", "西", (-1, 0)),
            ("center", "中", (0, 0)),
            ("east", "东", (1, 0)),
            ("southwest", "西南", (-1, -1)),
            ("south", "南", (0, -1)),
            ("southeast", "东南", (1, -1)),
        ]:
            groupbox = QGroupBox(self)
            groupbox.setTitle(vec_name)

            listwidget = QListWidget(groupbox)
            for entity in world.entity_at(x + vec[0], y + vec[1], z):
                if entity == self.player:
                    continue
                listitem = QListWidgetItem()
                viewer = EntityViewer(entity)
                viewer.pb_pick.clicked.connect(
                    lambda _, e=entity: (self.player.pick(e), self.refresh())
                )
                listitem.setSizeHint(viewer.size())
                listwidget.addItem(listitem)
                listwidget.setItemWidget(listitem, viewer)

            groupbox.setLayout(QGridLayout())
            groupbox.layout().addWidget(listwidget)

            self.layout().addWidget(groupbox, i, j)
            j += 1
            if j == 3:
                i += 1
                j = 0
