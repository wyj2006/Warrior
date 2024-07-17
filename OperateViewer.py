from PyQt5.QtWidgets import QWidget, QGridLayout, QPushButton, QDialog, QComboBox

from Attack import Attack, Attacked
from Disable import Disable
from GameObject import GameObject
from Load import Load
from Operate import Operate
from Player import Player
from Store import Store
from Wear import Wear
from Worn import Worn


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


class OperateViewer(QWidget):
    """查看操作"""

    def __init__(self, obj: GameObject):
        super().__init__()
        self.obj = obj

        self.setLayout(QGridLayout())

        self.refresh()

    def refresh(self):
        while self.layout().count():
            item = self.layout().takeAt(0)
            if item.widget() != None:
                item.widget().deleteLater()

        for op in GameObject.getObject(self.obj, Operate, ignore_disabled=False):
            button = QPushButton()
            button.setText(op.name)
            if GameObject.getObject(op, Disable, ignore_disabled=False):
                button.setEnabled(False)
            button.clicked.connect(lambda _, op=op: self.doOperate(op))
            self.layout().addWidget(button)

    def doOperate(self, op: Operate):
        """执行操作"""
        if isinstance(op, Worn):
            items = GameObject.getObject(self.obj, "/", "*", Player, "*", Wear)
            if len(items) == 1:
                i = 0
            else:
                i = ChooseDialog(items).exec()
                if i == -1:
                    return
            op(items[i])
        elif isinstance(op, Store):
            loads = GameObject.getObject(self.obj, "/", "*", Player, "*", Load)
            if len(loads) == 1:
                i = 0
            else:
                i = ChooseDialog(loads).exec()
                if i == -1:
                    return
            op(loads[i])
        elif isinstance(op, Attacked):
            items = GameObject.getObject(self.obj, "/", "*", Player, "*", Attack)
            if len(items) == 1:
                i = 0
            else:
                i = ChooseDialog(items).exec()
                if i == -1:
                    return
            op(items[i])
        else:
            op()
        self.refresh()
