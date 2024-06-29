from copy import deepcopy
from PIL import Image, ImageQt


class Tile(ImageQt.ImageQt):
    PATH = "tiles.bmp"  # 瓦片图片路径
    WIDTH = 8  # 单个瓦片宽度
    HEIGHT = 12  # 单个瓦片高度

    image = Image.open(PATH)
    tiles: list[Image.Image] = []
    for i in range(16):
        for j in range(16):
            tiles.append(
                image.crop((j * WIDTH, i * HEIGHT, (j + 1) * WIDTH, (i + 1) * HEIGHT))
            )
    image.close()

    def __init__(self, ch: str, back_color=(0, 0, 0), fore_color=(255, 255, 255)):
        assert len(ch) == 1

        image = deepcopy(Tile.tiles[ord(ch[0])])
        w, h = image.size[0], image.size[1]
        for x in range(w):
            for y in range(h):
                r, g, b = image.getpixel((x, y))
                if (r, g, b) == (255, 0, 255):
                    image.putpixel((x, y), back_color)
                elif (r, g, b) == (255, 255, 255):
                    image.putpixel((x, y), fore_color)

        super().__init__(image)

        self.back_color = back_color
        self.fore_color = fore_color
