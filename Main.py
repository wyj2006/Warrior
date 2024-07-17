import sys
from PyQt5.QtWidgets import QApplication

from Backpack import Backpack
from Game import Game
from GameObject import GameObject
from GameWidget import GameWidget
from InventoryViewer import InventoryViewer
from Player import Player
from Surroundings import Surroundings
from Sword import Sword
from Transform import Transform


def main():
    app = QApplication(sys.argv)

    game = Game()

    backpack = Backpack(game.world)
    Transform(backpack)

    sword = Sword(game.world)
    Transform(sword, 1, 0, 0)

    gamewidget = GameWidget(game)
    gamewidget.show()

    app.exec()


if __name__ == "__main__":
    main()
