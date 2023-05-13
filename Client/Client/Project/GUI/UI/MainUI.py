from GUI.UI.AIChatUI import AIChatUI
from GUI.UI.ShortVedioUI import ShortVedioUI


class MainUI:
    def __init__(self,uiRoot):
        self._uiRoot = uiRoot

        # 测试
        #testbutton = self._uiRoot.findChild(QQuickItem,"testbutton")

        # AI
        AIChatUI(self._uiRoot)

        # 短视频
        # ShortVedioUI(self._uiRoot)

