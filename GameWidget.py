from PyQt5.QtCore import QEvent, Qt
from PyQt5.QtWidgets import QWidget, QGridLayout, qApp

from Game import Game
from GameObject import GameObject
from InventoryViewer import InventoryViewer
from Player import Player
from Render import Render
from Surroundings import Surroundings


class GameWidget(QWidget):
    def __init__(self, game: Game):
        super().__init__()
        self.resize(1000, 618)

        self.game = game

        self.worldrender = Render(self.game.world)

        self.setLayout(QGridLayout())
        self.layout().addWidget(self.worldrender)

    def event(self, e: QEvent):
        if e.type() in (QEvent.Type.KeyPress,):
            if e.key() == Qt.Key.Key_I:
                self.inventoryviewer = InventoryViewer(
                    GameObject.getObject(self.game, "*", Player)[0]
                )
                self.inventoryviewer.show()
            elif e.key() == Qt.Key.Key_L:
                self.surroundings = Surroundings(
                    GameObject.getObject(self.game, "*", Player)[0]
                )
                self.surroundings.show()
            e.ignore()
            qApp.sendEvent(self.game, e)
        return super().event(e)
