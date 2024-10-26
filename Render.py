from PyQt5.QtCore import QTimer
from PyQt5.QtGui import QPainter, QPixmap
from PyQt5.QtWidgets import QWidget

from Camera import Camera
from GameObject import GameObject
from Texture import Texture
from Transform import Transform


class Render(QWidget):
    def __init__(self, obj: GameObject):
        super().__init__()
        self.resize(1000, 618)

        self.obj = obj

        self.reserve = 1

        self.update_timer = QTimer(self)
        self.update_timer.timeout.connect(self.update)
        self.update_timer.start(1)

        def lamda():
            self.reserve = -self.reserve

        self.reserve_timer = QTimer(self)
        self.reserve_timer.timeout.connect(lamda)
        self.reserve_timer.start(500)

    def paintEvent(self, _):
        painter = QPainter(self)

        # 中心坐标
        center_x = self.width() // 2
        center_y = self.height() // 2

        # 选择第一个没有禁用的摄像机
        # 如果都被禁用, 就选最后一个
        camera: Camera = self.obj.get("*", Camera)[0]

        texture: Texture
        for texture in self.obj.get("*", Texture)[:: self.reserve]:
            x, y, z = Transform.globalPos(texture)

            if z - camera.z not in (0, -1):
                continue

            dx = x - camera.x
            dy = camera.y - y

            painter.drawPixmap(
                center_x + dx * texture.width,
                center_y + dy * texture.height,
                QPixmap.fromImage(texture.image),
            )
