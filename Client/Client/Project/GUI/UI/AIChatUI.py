from PySide6.QtCore import QObject, Signal
from PySide6.QtQuick import QQuickItem
from Scripts.AIChat import *


# 异步更新UI
class Worker(QObject):
    sigResult = Signal(str,int)

    def Response(self, response, finishCode):
        self.sigResult.emit(response, finishCode)

    def Run(self, requestMessage):
        CallRequestOpenAI(self.Response, requestMessage)
    
    def Stop(self):
        StopRequestOpenAI()

class AIChatUI(QObject):
    def __init__(self,uiRoot):
        super().__init__()

        self.finishCode = 1

        self._responseMessege = ""
        self._requestMessage = ""
        self._preResponseMessege = ""
        self._uiRoot = uiRoot

        self._content = self._uiRoot.findChild(QObject,"chatMain_mode_content")
        self._content.signal_test.connect(lambda:self.signal_test())
        self._content.signal_clickChatTitle.connect(self.AIChat_ClickTitle)
        self._content.signal_clickChatTitle_add.connect(self.AIChat_ClickTitleAdd)
        self._content.signal_clickChatTitle_del.connect(self.AIChat_ClickTitleDel)
        self._content.signal_userInput.connect(self.AIChat_PushButton)

        self._worker = Worker()
        self._worker.sigResult.connect(self.AIChat_Response)

        InitChatModelData(0)

        self.AIChat_RefreshUI_Title()
        self.AIChat_Refresh_Content(0)

    def AIChat_RefreshUI_Title(self):
        titles = GetChatModelDataTitles()
        self._content.clearChatTitle()
        for t in titles:
            self._content.addChatTitle(t)

    def AIChat_Refresh_Content(self,index):
        # 初始化数据
        InitChatModelData(index)
        # UI显示
        itemData = GetChatModelData()
        
        self._content.clearChatItem()
        for m in itemData["content"]:
            self._content.addChatItem(m["role"],m["content"])

        self._content.setChatState(self.finishCode)

    def AIChat_ClickTitle(self,index):
        StopRequestOpenAI()
        self.AIChat_Refresh_Content(index)

    def AIChat_ClickTitleAdd(self):
        AddChatModelDataTitle("new title")
        self.AIChat_RefreshUI_Title()
        
    def AIChat_ClickTitleDel(self,index):
        DelChatModeDataTitle(index)
        InitChatModelData(0)
        self._content.delChatTitle(index)
        self.AIChat_RefreshUI_Title()
        self.AIChat_Refresh_Content(0)

    def AIChat_PushButton(self,useInput):
        if self.finishCode == 0:
            StopRequestOpenAI()
        else:
            self._content.setChatState(0)
            AddChatModelData({"role":"user","content":useInput})
            self._content.addChatItem("user",useInput)
            self._content.addChatItem("system","......")
            self._worker.Run(useInput)

    def AIChat_Response(self, responseMessege,finishCode):
        self.finishCode = finishCode
        self._content.setChatState(self.finishCode)
        self._content.setChatItem(responseMessege)

    def signal_test(self):
        print("目前qml有bug必须这样写之后才能回调instance的函数")