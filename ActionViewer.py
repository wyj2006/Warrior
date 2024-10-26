from PyQt5.QtWidgets import QWidget, QGridLayout, QPushButton, QDialog, QComboBox

from Action import Action
from BodyPart import BodyPart
from Container import Container
from GameObject import GameObject
from Hand import Hand
from Move import Move
from Player import Player
from Store import Storable, Store
from Wear import Wear, Wearable
from Wield import Wield, Wieldable


class ChooseDialog(QDialog):
    def __init__(self, items):
        super().__init__()
        self.items = items

        self.setLayout(QGridLayout())

        self.cb_items = QComboBox()
        self.cb_items.addItems(map(str, items))
        self.layout().addWidget(self.cb_items, 0, 0, 1, 2)

        self.pb_ok = QPushButton()
        self.pb_ok.setText(self.tr("确定"))
        self.pb_ok.clicked.connect(lambda: self.done(self.cb_items.currentIndex()))
        self.layout().addWidget(self.pb_ok, 1, 0)

        self.pb_cancel = QPushButton()
        self.pb_cancel.setText(self.tr("取消"))
        self.pb_cancel.clicked.connect(lambda: self.done(-1))
        self.layout().addWidget(self.pb_cancel, 1, 1)


class ActionViewer(QWidget):
    """查看行为(针对Player)"""

    def __init__(self, obj: GameObject):
        super().__init__()
        self.obj = obj

        self.setLayout(QGridLayout())

        self.refresh()

    @property
    def player(self) -> Player:
        return self.obj.get("/", "*", Player)[0]

    def refresh(self):
        while self.layout().count():
            item = self.layout().takeAt(0)
            if item.widget() != None:
                item.widget().deleteLater()

        for action in self.player.get(Action):
            if isinstance(action, Move):
                continue
            if isinstance(action, Wield):
                wieldable: list[Wieldable] = self.obj.get(Wieldable)
                if not wieldable or wieldable[0].wielded:
                    continue
            if isinstance(action, Store):
                storable: list[Storable] = self.obj.get(Storable)
                if not storable or storable[0].stored:
                    continue
            if isinstance(action, Wear):
                wearable: list[Wearable] = self.obj.get(Wearable)
                if not wearable:
                    continue
            button = QPushButton()
            button.setText(str(action))
            button.clicked.connect(lambda _, action=action: self.doAction(action))
            self.layout().addWidget(button)

    def doAction(self, action: Action):
        """执行操作"""
        if isinstance(action, Wield):
            action: Wield
            hands = self.player.get("*", Hand)
            i = ChooseDialog(hands).exec()
            if i != -1:
                action(self.obj, hands[i])
        elif isinstance(action, Store):
            action: Store
            containers = self.player.get("*", Container)
            i = ChooseDialog(containers).exec()
            if i != -1:
                action(self.obj, containers[i])
        elif isinstance(action, Wear):
            action: Wear
            bodyparts = self.player.get("*", BodyPart)
            i = ChooseDialog(bodyparts).exec()
            if i != -1:
                action(self.obj, bodyparts[i])
        self.refresh()
