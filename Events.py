from PyQt5.QtCore import QEvent


class NextTurnEvent(QEvent):
    Type = QEvent.registerEventType()

    def __init__(self) -> None:
        super().__init__(self.Type)
        self.ignore()
