from Action import Action
from BodyPart import BodyPart
from GameObject import GameObject
from Transform import Transform


class Wear(Action):
    def __call__(self, target: GameObject, bodypart: BodyPart):
        target.setParent(bodypart)
        if target.get(Transform):
            Transform(target)
        super().__call__()


class Wearable(GameObject):
    @property
    def weared(self):
        return isinstance(self.parent().parent(), BodyPart)
