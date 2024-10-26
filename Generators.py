import random
from Block import Floor, Wall


def generate_room(parent, num=1, width=10, height=10, x=0, y=0, z=0, generated=None):
    if num == 0:
        return
    if generated == None:
        generated = []
    generated.append((x, y, z))

    for i in range(width):
        for j in range(height):
            Floor(x + i, y + j, z - 1, parent)
    if num != 1:
        vec = ((0, 1), (0, -1), (-1, 0), (1, 0))[random.randint(0, 3)]
    else:
        vec = (0, 0)
    nx, ny, nz = (x + vec[0] * width + vec[0], y + vec[1] * height + vec[1], z)

    while (nx, ny, nz) in generated and num != 1:
        vec = ((0, 1), (0, -1), (-1, 0), (1, 0))[random.randint(0, 3)]
        nx, ny, nz = (x + vec[0] * width + vec[0], y + vec[1] * height + vec[1], z)

    for i in range(width):
        if vec != (0, -1) and i != width // 2:
            Wall(x + i, y - 1, z, parent)
        if vec != (0, 1) and i != width // 2:
            Wall(x + i, y + height, z, parent)
    for i in range(height):
        if vec != (-1, 0) and i != height // 2:
            Wall(x - 1, y + i, z, parent)
        if vec != (1, 0) and i != height // 2:
            Wall(x + width, y + i, z, parent)

    """if vec == (0, 1):
        Door(x + width // 2, y + height, z, parent)
    elif vec == (0, -1):
        Door(x + width // 2, y - 1, z, parent)
    elif vec == (-1, 0):
        Door(x - 1, y + height // 2, z, parent)
    elif vec == (0, -1):
        Door(x + width, y + height // 2, z, parent)"""

    generate_room(
        parent,
        num - 1,
        width,
        height,
        nx,
        ny,
        nz,
    )
