from Chest import Chest
from GameObject import GameObject
from Generators import generate_room
from Load import Load
from Pig import Pig
from Player import Player
from Store import Store
from Sword import Sword


class World(GameObject):
    def __init__(self, parent=None):
        super().__init__(parent)
        Player(self)
        generate_room(self, 2)

        chest = Chest(9, 9, 0, self)
        sword = Sword(self)
        GameObject.getObject(sword, Store)[0](GameObject.getObject(chest, Load)[0])

        Pig(self, 5, 5, 0)
