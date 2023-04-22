# This Python file uses the following encoding: utf-8
from concurrent.futures.thread import _worker
import sys
from pathlib import Path
from PySide6.QtCore import QUrl, QObject, QThread ,Signal
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtQuick import QQuickItem
from Scripts.AI.AIChat import CallRequestOpenAI
import Client_rc

# AI
requestText = ""
preResponseMessege = ""
def handle_result(self, result):
    AIChat_Response(result)

class Worker(QObject):
    sig_result = Signal(str)
    
    def response(self,response):
        self.sig_result.emit(response)

    def run(self):
        global requestMessage
        CallRequestOpenAI(self.response,requestMessage)

requestTextArea = QQuickItem()
responseTextArea = QQuickItem()
def AIChat_Response(responseMessege):
    global preResponseMessege
    responseMessege = responseMessege + "\r\n" + preResponseMessege
    responseTextArea.setProperty("text",responseMessege)
    # print(responseMessege)

worker = Worker()
worker.sig_result.connect(AIChat_Response)
def AIChat_PushButton():
    global preResponseMessege
    global requestMessage
    preResponseMessege = responseTextArea.property("text")
    requestMessage = requestTextArea.property("text")
    requestTextArea.setProperty("text","")
    worker.run()

# 短视频
shortvideo_keycut_vedio_text = QObject()
shortvideo_keycut_mp3_text = QObject()
shortvideo_keycut_txt_text = QObject()
shortvideo_keycut_front_text = QObject()
def ShortVedioKeyCut():
    print(shortvideo_keycut_vedio_text.property("placeholderText"))
    print(shortvideo_keycut_mp3_text.property("placeholderText"))
    print(shortvideo_keycut_txt_text.property("placeholderText"))
    print(shortvideo_keycut_front_text.property("placeholderText"))

def handle_result(self,responseMessege):
    AIChat_Response(responseMessege)

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    qml_file = Path(__file__).resolve().parent / "content/App.qml"
    engine.load(u":/content/App.qml")
    objects = engine.rootObjects()
    if not objects:
        sys.exit(-1)

    rootObject = objects[0]

    # 测试
    testbutton = rootObject.findChild(QQuickItem,"testbutton")

    # AI
    requestTextArea = rootObject.findChild(QQuickItem,"textArea1")
    responseTextArea = rootObject.findChild(QQuickItem,"textArea")
    pushButton = rootObject.findChild(QQuickItem,"PushButton")
    pushButton.clicked.connect(AIChat_PushButton)

    # 短视频
    shortvideo_keycut_vedio_text = rootObject.findChild(QObject,"shortvideo_keycut_vedio_text")
    shortvideo_keycut_mp3_text = rootObject.findChild(QObject,"shortvideo_keycut_mp3_text")
    shortvideo_keycut_txt_text = rootObject.findChild(QObject,"shortvideo_keycut_txt_text")
    shortvideo_keycut_front_text = rootObject.findChild(QObject,"shortvideo_keycut_front_text")
    shortvideo_keycut = rootObject.findChild(QObject,"shortvideo_keycut")
    shortvideo_keycut.clicked.connect(ShortVedioKeyCut)

    sys.exit(app.exec())
