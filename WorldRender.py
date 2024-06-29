from PyQt5.QtCore import Qt, QTimer
from PyQt5.QtGui import QKeyEvent, QPainter, QPixmap
from PyQt5.QtWidgets import QWidget

from InventoryViewer import InventoryViewer
from Surroundings import Surroundings
from Tile import Tile
from World import World
from Camera import Camera


class WorldRender(QWidget):
    """渲染一个世界"""

    def __init__(self, world: World, camera: Camera = Camera()):
        super().__init__()
        self.resize(1000, 618)

        self.world = world
        self.camera = camera
        self.world.game.nextTurn.connect(self.doTurn)

        self.reserve = False

        self.update_timer = QTimer(self)
        self.update_timer.timeout.connect(self.update)
        self.update_timer.start(1)

        def lamda():
            self.reserve = not self.reserve

        self.reserve_timer = QTimer(self)
        self.reserve_timer.timeout.connect(lamda)
        self.reserve_timer.start(500)

    def paintEvent(self, _):
        painter = QPainter(self)

        # 中心坐标
        center_x = self.width() // 2
        center_y = self.height() // 2
        for (x, y, z), cell in self.world.map.cells.items():
            if z != self.camera.z:
                continue

            if cell.wall != None:
                tile = QPixmap.fromImage(cell.wall.tile)
            elif cell.floor != None:
                tile = QPixmap.fromImage(cell.floor.tile)
            else:
                continue

            dx = x - self.camera.x
            dy = self.camera.y - y

            painter.drawPixmap(
                center_x + dx * Tile.WIDTH, center_y + dy * Tile.HEIGHT, tile
            )

        entities = self.world.entities[:]

        if self.reserve:
            entities = entities[::-1]

        for entity in entities:
            x = entity.x
            y = entity.y
            z = entity.z

            if z != self.camera.z:
                continue

            dx = x - self.camera.x
            dy = self.camera.y - y

            tile = QPixmap.fromImage(entity.tile)

            painter.drawPixmap(
                center_x + dx * Tile.WIDTH, center_y + dy * Tile.HEIGHT, tile
            )

    def keyPressEvent(self, a0: QKeyEvent) -> None:
        if a0.key() == Qt.Key.Key_A:
            self.world.player.move((-1, 0))
        elif a0.key() == Qt.Key.Key_D:
            self.world.player.move((1, 0))
        elif a0.key() == Qt.Key.Key_W:
            self.world.player.move((0, 1))
        elif a0.key() == Qt.Key.Key_S:
            self.world.player.move((0, -1))
        elif a0.key() == Qt.Key.Key_I:
            self.inventoryviewer = InventoryViewer(self.world.player)
            self.inventoryviewer.show()
        elif a0.key() == Qt.Key.Key_L:
            self.surroudings = Surroundings(self.world.player)
            self.surroudings.show()
        return super().keyPressEvent(a0)

    def doTurn(self):
        getattr(getattr(self, "surroudings", None), "refresh", lambda: None)()
        getattr(getattr(self, "inventoryviewer", None), "refresh", lambda: None)()
