from Action import Action
from GameObject import GameObject
from Hand import Hand
from Transform import Transform


class Wield(Action):
    """手持"""

    def __call__(self, target: GameObject, hand: Hand):
        target.setParent(hand)
        if target.get(Transform):
            Transform(target)
        super().__call__()


class Wieldable(GameObject):
    """可手持的"""

    @property
    def wielded(self):
        return isinstance(self.parent().parent(), Hand)
