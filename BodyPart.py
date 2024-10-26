from GameObject import GameObject


class BodyPart(GameObject):
    """身体部位"""


class Body(GameObject):
    def __init__(self, parent) -> None:
        super().__init__(parent)

        BodyPart(self)
