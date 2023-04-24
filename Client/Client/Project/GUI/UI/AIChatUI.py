from PySide6.QtCore import QObject, Signal
from PySide6.QtQuick import QQuickItem

from Scripts.AIChat import CallRequestOpenAI


# 异步更新UI
class Worker(QObject):
    sigResult = Signal(str)

    def Response(self, response):
        self.sigResult.emit(response)

    def Run(self, requestMessage):
        CallRequestOpenAI(self.Response, requestMessage)

class AIChatUI:
    def __init__(self, uiRoot):
        self._responseMessege = ""
        self._requestMessage = ""
        self._preResponseMessege = ""
        self._uiRoot = uiRoot

        self._requestTextArea = self._uiRoot.findChild(QQuickItem, "textArea1")
        self._responseTextArea = self._uiRoot.findChild(QQuickItem, "textArea")
        self._pushButton = self._uiRoot.findChild(QQuickItem, "PushButton")
        self._pushButton.clicked.connect(lambda:self.AIChat_PushButton())
        self._worker = Worker()
        self._worker.sigResult.connect(self.AIChat_Response)

    def AIChat_PushButton(self):
        self._preResponseMessege = self._responseTextArea.property("text")
        self._requestMessage = self._requestTextArea.property("text")
        self._requestTextArea.setProperty("text", "")
        self._worker.Run(self._requestMessage)

    def AIChat_Response(self, responseMessege):
        self._responseMessege = responseMessege + "\r\n" + self._preResponseMessege
        self._responseTextArea.setProperty("text", self._responseMessege)
