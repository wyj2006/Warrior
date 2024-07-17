from Operate import Operate


class Attack(Operate):
    """攻击"""

    def __init__(self, parent=None):
        super().__init__("攻击", parent)
        self.name = self.tr("攻击")

    def __call__(self, target):
        getattr(self.parent(), "attack", lambda _: None)(target)

        super().__call__()


class Attacked(Operate):
    def __init__(self, parent=None):
        super().__init__("攻击", parent)
        self.name = self.tr("攻击")

    def __call__(self, attack: Attack):
        attack(self.parent())

        super().__call__()
