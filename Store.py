from Action import Action
from Container import Container
from GameObject import GameObject
from Transform import Transform


class Store(Action):
    def __call__(self, target: GameObject, container: Container):
        target.setParent(container)
        if target.get(Transform):
            Transform(target)
        super().__call__()


class Storable(GameObject):
    @property
    def stored(self):
        return isinstance(self.parent().parent(), Container)
