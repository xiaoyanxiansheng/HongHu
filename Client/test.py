import os
# ================================================== OPONAI ==================================================
import openai
import time

# Load your API key from an environment variable or secret management service
openai.api_key = "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"

# response = openai.Completion.create(model="text-davinci-003", prompt="Say this is a test", temperature=0, max_tokens=7)

# print(response)

# response = openai.Image.create(
#   prompt="一只名叫星星的小橘猫",
#   n=1,
#   size="256x256"
# )
# image_url = response['data'][0]['url']
# print(image_url)

# -------------------流式打印-------------------------
# Example of an OpenAI ChatCompletion request with stream=True
# https://platform.openai.com/docs/guides/chat

# # record the time before the request is sent
# start_time = time.time()
# # send a ChatCompletion request to count to 100
# response = openai.ChatCompletion.create(
#     model='gpt-3.5-turbo',
#     messages=[
#         {'role': 'user', 'content': 'Count to 100, with a comma between each number and no newlines. E.g., 1, 2, 3, ...'}
#     ],
#     temperature=0,
#     stream=True  # again, we set stream=True
# )

# # create variables to collect the stream of chunks
# collected_chunks = []
# collected_messages = []
# # iterate through the stream of events
# for chunk in response:
#     chunk_time = time.time() - start_time  # calculate the time delay of the chunk
#     collected_chunks.append(chunk)  # save the event response
#     chunk_message = chunk['choices'][0]['delta']  # extract the message
#     collected_messages.append(chunk_message)  # save the message
#     print(f"Message received {chunk_time:.2f} seconds after request: {chunk_message}")  # print the delay and text

# # print the time delay and text received
# print(f"Full response received {chunk_time:.2f} seconds after request")
# full_reply_content = ''.join([m.get('content', '') for m in collected_messages])
# print(f"Full conversation received: {full_reply_content}")
# -------------------流式打印-------------------------

# ================================================== DEEPAI ==================================================
# 
# import requests
# r = requests.post(
#     "https://api.deepai.org/api/text2img",
#     data={
#         'text': 'American Daisy cat',
#     },
#     headers={'api-key': '201675a0-81c2-43ca-a83f-da867322ab54'}
# )
# print(r.json())

# ================================================== GOOGLE ==================================================
# import requests
# import json
# # 获取图片
# def search_images(keyword):
#     api_key = "AIzaSyCexDrABnuT8DkuEcAz8UxDHd5LyhFT_fM"
#     search_engine_id = "65ca06fbb72184cd0"
#     url = f"https://www.googleapis.com/customsearch/v1?key={api_key}&cx={search_engine_id}&searchType=image&q={keyword}"
#     response = requests.get(url)
#     data = json.loads(response.text)
#     i = 0
#     for item in data["items"]:
#         i = i + 1
#         img_url = item["link"]
#         img_data = requests.get(img_url).content
#         with open(str(i)+'image_name.jpg', 'wb') as f:
#             f.write(img_data)

# # 获取视频
# def search_videos(keyword):
#     api_key = "AIzaSyCexDrABnuT8DkuEcAz8UxDHd5LyhFT_fM"
#     search_engine_id = "65ca06fbb72184cd0"
#     url = f"https://www.googleapis.com/customsearch/v1?key={api_key}&cx={search_engine_id}&searchType=video&q={keyword}"
#     response = requests.get(url)
#     data = json.loads(response.text)
#     for item in data["items"]:
#         video_url = item["link"]
#         video_data = requests.get(video_url).content
#         with open('video_name.mp4', 'wb') as f:
#             f.write(video_data)

# # 调用函数搜索图片和视频
# # search_images("cat") # 搜索关键字为"cat"的图片
# search_videos("dog") # 搜索关键字为"dog"的视频
# print("完成")


# ================================================== youtube ==================================================
# from googleapiclient.discovery import build
# import pytube

# # 指定API的开发者key和服务名称
# api_key = 'AIzaSyCexDrABnuT8DkuEcAz8UxDHd5LyhFT_fM'
# youtube_service_name = 'youtube'
# youtube_service_version = 'v3'

# # 指定搜索关键字和搜索类型
# keyword = '猫|狗|鸟'
# search_type = 'video'

# # 构造API请求
# youtube = build(youtube_service_name, youtube_service_version, developerKey=api_key)
# search_response = youtube.search().list(q=keyword, part='id,snippet', type=search_type).execute()

# # 处理搜索结果
# index = 0
# videos = []
# for search_result in search_response.get('items', []):
#     if search_result['id']['kind'] == 'youtube#video':
#         videos.append('%s (%s)' % (search_result['snippet']['title'], search_result['id']['videoId']))
#         video_url = "https://www.youtube.com/watch?v=" + search_result['id']['videoId']
#         video = pytube.YouTube(video_url)
#         stream = video.streams.get_highest_resolution()
#         stream.download('video_path/',filename_prefix='video')

