from PyQt5.QtCore import QObject, pyqtSignal

from World import World


class Game(QObject):
    nextTurn = pyqtSignal()

    def __init__(self):
        super().__init__()
        self.curworld = World(self)

    def do_turn(self):
        self.nextTurn.emit()
