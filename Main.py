import sys
from PyQt5.QtWidgets import QApplication

from Backpack import Backpack
from Game import Game
from GameObject import GameObject
from GameWidget import GameWidget
from Player import Player
from Sword import Sword
from Transform import Transform


def main():
    app = QApplication(sys.argv)

    game = Game()

    sword = Sword(game.world)
    Transform(sword)

    backpack = Backpack(game.world)
    Transform(backpack, 1)

    gamewidget = GameWidget(game)
    gamewidget.show()

    app.exec()


if __name__ == "__main__":
    main()
