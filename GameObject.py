from PyQt5.QtCore import QObject, Qt, QEvent
from PyQt5.QtWidgets import qApp


class GameObject(QObject):
    """游戏对象"""

    @staticmethod
    def root(self: QObject) -> QObject:
        """获取对象树的根"""
        p = self
        while p.parent() != None:
            p = p.parent()
        return p

    @staticmethod
    def getObject(self: QObject, *path, ignore_disabled=True) -> list[QObject]:
        """
        获取在对象树里的路径对应的对象
        ignore_disabled: 忽略被禁止的对象
        """
        from Disable import Disable

        p = self
        if not path:
            return [p]

        if path[0] == "/":
            p = GameObject.root(p)
            path = path[1:]

        if not path:
            return [p]
        if not path[0]:
            return [p]

        result = []

        type_name: tuple[QObject, str] = path[0]

        if type_name == "*":
            for child in p.children():
                if (
                    child.findChild(
                        Disable, "", Qt.FindChildOption.FindDirectChildrenOnly
                    )
                    != None
                    and ignore_disabled
                ):
                    continue
                result += GameObject.getObject(
                    child, *path, ignore_disabled=ignore_disabled
                )
            path = path[1:]
            type_name = path[0]

        if type_name == "+":
            for child in p.children():
                if (
                    child.findChild(
                        Disable, "", Qt.FindChildOption.FindDirectChildrenOnly
                    )
                    != None
                    and ignore_disabled
                ):
                    continue
                result += GameObject.getObject(
                    child, *(("*",) + path[1:]), ignore_disabled=ignore_disabled
                )
            return result

        if type_name == ".":
            p = p
            path = path[1:]
            type_name = path[0]

        if type_name == "..":
            p = p.parent()
            path = path[1:]
            type_name = path[0]
            return result + GameObject.getObject(
                p, *path, ignore_disabled=ignore_disabled
            )

        if not isinstance(type_name, tuple):
            type_name = (type_name, "")
        if len(type_name) == 1:
            type_name += ("",)

        for child in p.findChildren(
            type_name[0], type_name[1], Qt.FindChildOption.FindDirectChildrenOnly
        ):
            if (
                child.findChild(Disable, "", Qt.FindChildOption.FindDirectChildrenOnly)
                != None
                and ignore_disabled
            ):
                continue
            result += GameObject.getObject(
                child, *path[1:], ignore_disabled=ignore_disabled
            )

        return result

    def event(self, e: QEvent):
        # 将事件沿对象树向下传播
        if not e.isAccepted():
            for child in self.children():
                qApp.sendEvent(child, e)
        return super().event(e)
