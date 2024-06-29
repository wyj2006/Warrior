from PyQt5.QtCore import QObject

from Map import Map


class World(QObject):
    def __init__(self, game):
        super().__init__(game)
        from Player import Player
        from Entity import Entity

        self.map = Map()
        self.entities: list[Entity] = []

        self.player = Player(self)

    @property
    def game(self):
        return self.parent()

    def entity_at(self, x, y, z):
        entities = []
        for entity in self.entities:
            if (entity.x, entity.y, entity.z) == (x, y, z):
                entities.append(entity)
        return entities
