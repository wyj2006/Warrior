from PyQt5.QtCore import QObject, Qt, QEvent
from PyQt5.QtWidgets import qApp


class GameObject(QObject):
    def root(self):
        """对象树的根"""
        p = self
        while p.parent() != None:
            p = p.parent()
        return p

    def get(self, *path) -> list:
        """根据对象树的路径获取对象"""

        def type_name(a) -> tuple[type, str]:
            """获取路径某一项中的对象和名称信息"""
            if isinstance(a, tuple) and len(a) < 2:
                return a + ("",)
            elif not isinstance(a, tuple):
                return (a, "")

        p = self
        if not path:
            return [p]
        if path[0] == ".":
            return p.get(*path[1:])
        if path[0] == "..":
            return p.parent().get(*path[1:])
        if path[0] == "/":
            return p.root().get(*path[1:])
        if path[0] == "*":
            t = []
            for child in p.findChildren(*type_name(path[1])):
                t += child.get(*path[2:])
            return t
        t = []
        for child in p.findChildren(
            *type_name(path[0]), Qt.FindChildOption.FindDirectChildrenOnly
        ):
            t += child.get(*path[1:])
        return t

    def event(self, e: QEvent):
        if not e.isAccepted():
            for child in self.children():
                qApp.sendEvent(child, e)
        return super().event(e)
