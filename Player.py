from BodyPart import Body
from Camera import Camera
from Collider import Collider
from GameObject import GameObject
from Hand import RightHand
from KeyController import KeyController
from Move import Move
from Store import Store
from Texture import Texture
from Transform import Transform
from Wear import Wear
from Wield import Wield


class Player(GameObject):
    def __init__(self, parent=None):
        super().__init__(parent)

        Texture("@", self)
        Transform(self)
        KeyController(self)
        Camera(self)
        Collider(self)
        RightHand(self)
        Body(self)

        Move(self)
        Wield(self)
        Store(self)
        Wear(self)
