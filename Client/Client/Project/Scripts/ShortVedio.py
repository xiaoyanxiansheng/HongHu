from Scripts.Define import *
from moviepy.editor import *
from moviepy.video.io.VideoFileClip import VideoFileClip
from moviepy.video.tools.subtitles import SubtitlesClip
import os
import codecs

class CombineItemType:
    IMAGE = 0 # 图片
    VEDIO = 1 # 视频

class CombineItem:
    def __init__(self, assetType, assetPath):
        self.assetType = assetType      # CombineItemType
        self.assetPath = assetPath      # 路径
        self.duration = 0               # 延时

    def GetCombinePath(self):
        return self.assetPath.replace("file:///","")

class ShortVedio:
    def __init__(self):
        self._combineItems = []
        self._assetFolderPath = ""
        self._savePath = ""

    def SetAssetFolderPath(self,folderPath):
        self._assetFolderPath = folderPath

    def SetSavePath(self, savePath):
        self._savePath = savePath

    def RefreshData(self):
        for file_name in os.listdir(self._assetFolderPath):
            file_path = os.path.join(self._assetFolderPath, file_name)
            if os.path.isfile(file_path):
                if file_path.endswith(".mp4"):
                    self._combineItems.append(CombineItem(CombineItemType.VEDIO,"file:///"+file_path))
                if file_path.endswith(".jpg") | file_path.endswith(".png"):
                    self._combineItems.append(CombineItem(CombineItemType.IMAGE,"file:///"+file_path))

    def FillAssetPath(self, assetType, assetPath):
        item = CombineItem(assetType, assetPath)
        self._combineItems.append(item)

    def GetCombineItems(self):
        return self._combineItems

    def CombineItems(self,finishCall):
        # 合成视频
        startTime = 0
        clips = []
        for item in self._combineItems:
            clip = None

            assetPath = item.GetCombinePath()
            if item.assetType == CombineItemType.VEDIO:
                clip = VideoFileClip(assetPath)
            else:
                clip = ImageClip(assetPath)
                clip = clip.set_duration(3)

            clip = clip.set_start(startTime)
            clips.append(clip)
            startTime += clip.duration

        # 加载字幕文件，设置字幕样式和位置
        generator = lambda txt: TextClip(txt, font='Arial', fontsize=24, color='white')
        subtitle = SubtitlesClip("downloads/subtitle.srt",generator)
        subtitle = subtitle.set_pos(('center', 'bottom'))
        clips.append(subtitle)

        finalClip = CompositeVideoClip(clips)

        audioClip = AudioFileClip("downloads/image_name.mp3")
        finalClip = finalClip.set_audio(CompositeAudioClip([audioClip]))

        finalClip.write_videofile(self._savePath,fps=24)

        finishCall()