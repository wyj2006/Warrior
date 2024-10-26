from BodyPart import BodyPart
from GameObject import GameObject


class Hand(GameObject):
    """
    手
    可以单独作为一个对象
    也可以作为一个对象的子对象
    """


class RightHand(GameObject):
    def __init__(self, parent=None):
        super().__init__(parent)

        Hand(self)
        BodyPart(self)
