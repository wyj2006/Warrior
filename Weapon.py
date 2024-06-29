from Item import Item
from Material import Material, WoodMaterial
from Tile import Tile


class Weapon(Item):
    """武器"""

    damage: int  # 伤害


class Sword(Weapon):
    id = "sword"
    name = "剑"
    damage = 10
    tile = Tile("/")

    def _init(self):
        if isinstance(self.material, WoodMaterial):
            self.tile = Tile("/", fore_color=(255, 255, 0))
