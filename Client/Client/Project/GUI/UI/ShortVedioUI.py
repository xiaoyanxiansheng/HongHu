from PySide6.QtCore import QObject


class ShortVedioUI:
    def __init__(self, uiRoot):
        self._uiRoot = uiRoot

        self._shortvideo_keycut_vedio_text = self._uiRoot.findChild(QObject, "shortvideo_keycut_vedio_text")
        self._shortvideo_keycut_mp3_text = self._uiRoot.findChild(QObject, "shortvideo_keycut_mp3_text")
        self._shortvideo_keycut_txt_text = self._uiRoot.findChild(QObject, "shortvideo_keycut_txt_text")
        self._shortvideo_keycut_front_text = self._uiRoot.findChild(QObject, "shortvideo_keycut_front_text")
        self._shortvideo_keycut = self._uiRoot.findChild(QObject, "shortvideo_keycut")
        self._shortvideo_keycut.clicked.connect(self.ShortVedioKeyCut)

    def ShortVedioKeyCut(self):
        print(self._shortvideo_keycut_vedio_text.property("placeholderText"))
        print(self._shortvideo_keycut_mp3_text.property("placeholderText"))
        print(self._shortvideo_keycut_txt_text.property("placeholderText"))
        print(self._shortvideo_keycut_front_text.property("placeholderText"))
