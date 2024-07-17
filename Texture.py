from copy import deepcopy
from PIL import Image, ImageQt

from GameObject import GameObject
from Transform import Transform

TILE_PATH = "tiles.bmp"  # 瓦片图片路径
TILE_WIDTH = 8  # 单个瓦片宽度
TILE_HEIGHT = 12  # 单个瓦片高度

image = Image.open(TILE_PATH)
tiles: list[Image.Image] = []
for i in range(16):
    for j in range(16):
        tiles.append(
            image.crop(
                (
                    j * TILE_WIDTH,
                    i * TILE_HEIGHT,
                    (j + 1) * TILE_WIDTH,
                    (i + 1) * TILE_HEIGHT,
                )
            )
        )
image.close()


class Texture(GameObject):
    """指示空间物体的贴图"""

    def __init__(
        self, ch: str, parent=None, back_color=(0, 0, 0), fore_color=(255, 255, 255)
    ):
        assert len(ch) == 1
        super().__init__(parent)

        tile = deepcopy(tiles[ord(ch[0])])
        w, h = tile.size[0], tile.size[1]
        for x in range(w):
            for y in range(h):
                r, g, b = tile.getpixel((x, y))
                if (r, g, b) == (255, 0, 255):
                    tile.putpixel((x, y), back_color)
                elif (r, g, b) == (255, 255, 255):
                    tile.putpixel((x, y), fore_color)
        self.image = ImageQt.ImageQt(tile)

        self.width = TILE_WIDTH
        self.height = TILE_HEIGHT

        self.back_color = back_color
        self.fore_color = fore_color

        Transform(self)  # 贴图相对于父对象的坐标
