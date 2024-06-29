import sys
from PyQt5.QtWidgets import QApplication

from Camera import Camera
from Game import Game
from InventoryViewer import InventoryViewer
from Map import Block
from Material import WoodMaterial
from Surroundings import Surroundings
from Tile import Tile
from Weapon import Sword
from WorldRender import WorldRender

app = QApplication(sys.argv)

game = Game()
for i in range(10):
    for j in range(10):
        game.curworld.map.create_floor(i, j, 0, Block(Tile(chr(0), (100, 100, 100))))
worldrender = WorldRender(game.curworld, Camera(game.curworld.player))
worldrender.show()

game.curworld.player.equip("righthand", Sword(WoodMaterial(), game.curworld.player))

sys.exit(app.exec())
