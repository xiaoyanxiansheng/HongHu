import os

# 清空文件夹
def ClearFolder(folderPath):
    # 遍历文件夹中的文件并删除
    for filename in os.listdir(folderPath):
        file_path = os.path.join(folderPath, filename)
        try:
            if os.path.isfile(file_path) or os.path.islink(file_path):
                os.unlink(file_path)  # 删除文件或符号链接
            elif os.path.isdir(file_path):
                os.rmdir(file_path)  # 删除空文件夹
        except Exception as e:
            print(f"Failed to delete {file_path}. Reason: {e}")

# ------------------ 多线程处理卡顿问题 -----------------
import threading
class HandleThread(threading.Thread):  # 继承父类threading.Thread
    def __init__(self,requstCall,responseCall):
        threading.Thread.__init__(self)
        self.threadID = 1
        self.name = "HandleThread"
        self.counter = 1
        self.requstCall = requstCall
        self.responseCall = responseCall

    def run(self):
        self.requstCall(self.responseCall)

def AsyncCall(requstCall,responseCall):
    thread = HandleThread(requstCall,responseCall)
    thread.start()

def QmlFilePath(filePath):
    return "file:///" + filePath
def FilePath(filePath):
    return filePath.replace("file:///","")