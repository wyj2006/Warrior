from Tile import Tile


class Block:
    """方块"""

    passable = True  # 是否可以通过

    def __init__(self, tile: Tile = Tile(chr(0))):
        self.tile = tile


class Cell:
    """
    地图的一个单元
    参考矮人要塞的实现
    """

    def __init__(self, wall: Block = None, floor: Block = None):
        self.wall = wall
        self.floor = floor

    def can_pass(self):
        if self.wall == None:
            if self.floor == None:
                return False
            return True
        if self.floor == None:
            if self.wall == None:
                return False
            return self.wall.passable


class Map:
    """地图"""

    def __init__(self):
        self.cells: dict[tuple[int, int, int], Cell] = {}

    def __getitem__(self, key: tuple[int, int, int]) -> Cell:
        if key not in self.cells:
            self.cells[key] = Cell()
        return self.cells[key]

    def __setitem__(self, key: tuple[int, int, int], val: Cell):
        self.cells[key] = val

    def create_cell(self, x, y, z, cell: Cell = Cell()):
        self[x, y, z] = cell

    def create_wall(self, x, y, z, wall: Block = Block()):
        self[x, y, z].wall = wall

    def create_floor(self, x, y, z, floor: Block = Block()):
        self[x, y, z].floor = floor

    def can_pass(self, x, y, z):
        if (x, y, z) not in self.cells:
            return False
        return self[x, y, z].can_pass()
