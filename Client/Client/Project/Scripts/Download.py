import requests
import json
from googleapiclient.discovery import build
import pytube
import yt_dlp as youtube_dl
from Scripts.Define import *
import re
import datetime

# 获取图片
def search_images(finishCall,keyword,downloadCount):
    url = f"https://www.googleapis.com/customsearch/v1?key={KEY_GOOGLE}&cx={KEY_GOOGLE_ENGINE_ID}&searchType=image&q={keyword}"
    response = requests.get(url)
    data = json.loads(response.text)
    index = 0
    realCount = len(data["items"])
    if downloadCount > realCount:
        downloadCount = realCount
    for item in data["items"]:
        if index < downloadCount:
            index = index + 1
        img_url = item["link"]
        img_data = requests.get(img_url).content
        with open("downloads/"+str(index)+'image_name.jpg', 'wb') as f:
            f.write(img_data)

    finishCall()

# 搜索视频
def search_videos(finishCall,keyword,downloadCount):

    # 指定API的开发者key和服务名称
    youtube_service_name = 'youtube'
    youtube_service_version = 'v3'

    # 指定搜索关键字和搜索类型
    search_type = 'video'

    # 构造API请求
    youtube = build(youtube_service_name, youtube_service_version, developerKey=KEY_GOOGLE)
    search_response = youtube.search().list(q=keyword, part='id,snippet', type=search_type).execute()

    # 处理搜索结果
    index = 0
    realCount = len(search_response.get('items', []))
    if downloadCount > realCount:
        downloadCount = realCount
    videos = []
    for search_result in search_response.get('items', []):
        if search_result['id']['kind'] == 'youtube#video':
            if index < downloadCount:
                index = index + 1
                videos.append('%s (%s)' % (search_result['snippet']['title'], search_result['id']['videoId']))
                video_url = "https://www.youtube.com/watch?v=" + search_result['id']['videoId']
                video = pytube.YouTube(video_url, use_oauth=True, allow_oauth_cache=True)
                stream = video.streams.get_highest_resolution()
                stream.download('downloads/',filename_prefix='video')

    finishCall()

# 搜索音乐
def search_music(finishCall,keyword,downloadCount):
    # 设置youtube-dl的配置
    ydl_opts = {
        'format': 'bestaudio/best',
        'outtmpl': 'downloads/%(title)s.%(ext)s',
        'postprocessors': [{
            'key': 'FFmpegExtractAudio',
            'preferredcodec': 'mp3',
            'preferredquality': '192',
        }],
    }

    # 搜索并获取结果
    with youtube_dl.YoutubeDL(ydl_opts) as ydl:
        search_results = ydl.extract_info(f"ytsearch:{keyword}", download=False)

    # 下载音乐
    realCount = len(search_results['entries'])
    if downloadCount > realCount:
        downloadCount = realCount
    index = 0
    for result in search_results['entries']:
        if index < downloadCount:
            index = index + 1
            url = result['webpage_url']
            with youtube_dl.YoutubeDL(ydl_opts) as ydl:
                ydl.download([url])

    finishCall()

# 合成语音
def CombineVoice(finishCall,content):
    API_KEY = "rbgFttY8GVuqiQgGGLZ10O97"
    SECRET_KEY = "S5IZgmxvEw8IShWWuUZuH0wkjWZBqBiL"

    # 获取access_token
    url = "https://aip.baidubce.com/oauth/2.0/token"
    params = {"grant_type": "client_credentials", "client_id": API_KEY, "client_secret": SECRET_KEY}
    access_token = str(requests.post(url, params=params).json().get("access_token"))

    # 创建合成请求
    # url = "https://aip.baidubce.com/rpc/2.0/tts/v1/create?access_token=" + access_token
    # payload = json.dumps({
    #     "text": content,
    #     "format": "mp3-16k",
    #     "lang": "zh"
    # })
    # headers = {
    #     'Content-Type': 'application/json',
    #     'Accept': 'application/json'
    # }
    # response = requests.request("POST", url, headers=headers, data=payload)

    # print(response.json()["task_id"])

    #下载已合成是音频 TODO 需要异步查询是否完成
    task_id_list = [      
        "645847291eb6020001bb5a0b"#response.json()["task_id"], #64575e8e3064530001d312a4
    ]

    url = 'https://aip.baidubce.com/rpc/2.0/tts/v1/query'  #查询长文本语音合成任务结果请求地址

    body = {
        "task_ids": task_id_list
    }
    token = {"access_token":access_token}
    headers = {'content-type': "application/json"}
    response = requests.post(url,params=token,data = json.dumps(body), headers = headers)
    img_data = requests.get(response.json()["tasks_info"][0]["task_result"]["speech_url"]).content
    with open("downloads/"+'image_name.mp3', 'wb') as f:
        f.write(img_data)
    
    finishCall()

# CombineVoice("""当我走在大街上时，我感到孤独和悲伤，仿佛整个世界都与我无关。街道两旁的人来人往，他们匆匆赶路，好像都在追赶着什么。但是我，我只是在这里漫步，默默地沉浸在自己的思绪中。
# 我想起了过去的一些事情，那些美好的回忆仿佛就在昨天，但却再也无法重现。我想起了曾经的朋友和亲人，他们现在都不在我身边，让我感到更加孤独。我试图让自己忙碌起来，但是在这个拥挤的城市里，我还是感觉无处可去。
# 大街上的人们都忙着追求自己的梦想，而我似乎迷失了方向。我不知道自己要去哪里，也不知道该怎样走下去。或许，这就是生活的真谛吧，我们都是在不停地寻找，寻找属于自己的方向，寻找属于自己的意义。
# 我沉思了许久，终于意识到，生命中最重要的是如何面对这些痛苦和挑战。我们必须学会接受生活中的困难，去面对它们，去克服它们。当我们学会从挫折中坚强地站起来，我们就能够更加勇敢地面对未来。
# 走在大街上，我看到许多人都在忙碌地奔波着，但是我现在明白了，人生不是一场竞赛，我们并不需要赢得所有的奖项或者被所有人认可。重要的是我们如何享受人生，如何在日复一日的平凡中找到自己的价值和意义。
# 或许我还会在未来遇到更多的挫折和困难，但是我相信，只要我坚持走下去，我终将能够克服它们，找到自己的方向和意义。走在大街上的孤独和悲伤，终将被自己的坚强和勇气所替代""")

def CombineText(finishCall,content):
    # 每行字幕最大字符数
    MAX_CHARS_PER_LINE = 32

    # 分割文案，生成字幕列表
    subtitle_lines = []
    line = ""
    words = re.split('[，。]', content)
    for word in words:
        if len(line + " " + word) > MAX_CHARS_PER_LINE:
            subtitle_lines.append(line.strip())
            line = word
        else:
            line += " " + word
    if line:
        subtitle_lines.append(line.strip())

    # 生成 srt 文件内容
    srt_content = ""
    for i in range(len(subtitle_lines)):
        start_time = datetime.timedelta(seconds=i * 3)  # 字幕出现时间
        end_time = datetime.timedelta(seconds=(i + 1) * 3)  # 字幕消失时间
        srt_content += f"{i + 1}\n{start_time} --> {end_time}\n{subtitle_lines[i]}\n\n"

    # 将 srt 文件内容写入文件
    with open("downloads/subtitle.srt", "w", encoding="utf-8") as f:
        f.write(srt_content)
    
    finishCall()