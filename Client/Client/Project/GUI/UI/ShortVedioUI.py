from PySide6.QtCore import QObject
from PySide6.QtWidgets import QLabel
from PySide6.QtGui import QImage, QPixmap
from Scripts.ShortVedio import *
from Scripts.Download import *
from Scripts.Common import *
from Scripts.Define import *
from Scripts.AIChat import *
import os

class ShortVedioUI:
    def __init__(self, uiRoot):
        self.descTxt = ""
        self.descKey = ""

        self._uiRoot = uiRoot

        self._shortvideo_keycut_btn_txt = self._uiRoot.findChild(QObject, "shortvideo_keycut_btn_txt")
        self._shortvideo_keycut_btn_background = self._uiRoot.findChild(QObject, "shortvideo_keycut_btn_background")
        self._shortvideo_keycut_btn_mouth = self._uiRoot.findChild(QObject, "shortvideo_keycut_btn_mouth")
        self._shortvideo_keycut_btn_vedio = self._uiRoot.findChild(QObject, "shortvideo_keycut_btn_vedio")
        self._shortvideo_keycut_btn = self._uiRoot.findChild(QObject, "shortvideo_keycut_btn")
        self._shortvideo_keycut_btn_txt.clicked.connect(lambda:self.ShortVedioKeyCutTxt())
        self._shortvideo_keycut_btn_background.clicked.connect(lambda:self.ShortVedioKeyCutBackGround())
        self._shortvideo_keycut_btn_mouth.clicked.connect(lambda:self.ShortVedioKeyCutMouth())
        self._shortvideo_keycut_btn_vedio.clicked.connect(lambda:self.ShortVedioKeyCutVedio())
        self._shortvideo_keycut_btn.clicked.connect(lambda:self.ShortVedioKeyCut())
        self._shortVedio_keycut_Content = self._uiRoot.findChild(QObject, "shortVedio_keycut_Content")
        
        self._shortVedio = ShortVedio()

        self.ShowVedios()

    def ShowVedios(self):
        self._shortVedio.SetAssetFolderPath(PATH_DOWNLOAD)
        self._shortVedio.RefreshData()
    
        items = self._shortVedio.GetCombineItems()
        for item in items :
            self._shortVedio_keycut_Content.addItem(item.assetType, item.assetPath)

    def ShortVedioKeyCutTxt(self):
        print("ShortVedioKeyCutTxt")

    def ShortVedioKeyCutBackGround(self):
        print("ShortVedioKeyCutBackGround")
    
    def ShortVedioKeyCutMouth(self):
        print("ShortVedioKeyCutMouth")

    def ShortVedioKeyCutVedio(self):
        print("ShortVedioKeyCutVedio")

    def ShortVedioKeyCut(self):
        print("ShortVedioKeyCut 1")
        self._shortVedio.SetSavePath(PATH_COMBINE_MP4)
        # self.DownloadAssets()
        AsyncCall(self._shortVedio.CombineItems,self.CombineItems_FinishCall)

    def CombineItems_FinishCall(self):
        print("ShortVedioKeyCut 2")
        self._shortVedio_keycut_Content.addCombineItem(QmlFilePath(PATH_COMBINE_MP4))

    # 下载所需要的资源
    def DownloadAssets(self):
        #删除之前的缓存
        #ClearFolder(PATH_DOWNLOAD)
        # search_images("猫",2)
        # search_videos("猫",1)
        # search_music("猫",1)
        content = "你好啊，这是一个测试的文件，在这个文件中我将处理字幕和口播，具体效果不清楚，测试aaaa，测试不不不，就这样先。"
        CombineVoice(content)

        #CombineText(content)
