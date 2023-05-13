import openai
import os
#from Scripts.Define import *

openai.api_key = "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"

os.environ["http_proxy"]="127.0.0.1:7890"
os.environ["https_proxy"]="127.0.0.1:7890"

def RequestOpenAIBlock(keyword):
    response = openai.Completion.create(model="gpt-3.5-turbo", prompt=keyword, temperature=0, max_tokens=100)
    return response

chatModeldatas = [
            # {"title":"title1","content":[{"role":"user","content":"你好啊1"},{"role":"system","content":"你好请问有什么可以帮你？2"}]},
            # {"title":"title2","content":[{"role":"user","content":"你好啊1"},{"role":"system","content":"你好请问有什么可以帮你？2"}]}
        ]

class AIChat:
    def __init__(self):
        self._modelDataIndex = 0
        self.response = None

    def InitChatModelData(self,index):
        self._modelDataIndex = index
    
    def AddChatModelData(self,data):
        chatModeldatas[self._modelDataIndex]["content"].append(data)

    def SetChatModelData(self,data):
        chatModeldatas[self._modelDataIndex]["content"] = data

    def GetChatModelData(self):
        return chatModeldatas[self._modelDataIndex]

    # 请求
    def RequestOpenAI(self, call, prompt):
        self.close = 0

        #chatModeldatas[self._modelDataIndex]["content"].append({"role": "user", "content": prompt})
        self.response = openai.ChatCompletion.create(
            model='gpt-3.5-turbo',
            messages=chatModeldatas[self._modelDataIndex]["content"],
            temperature=0,
            stream=True  # again, we set stream=True
        )
        
        collected_messages = ""
        # iterate through the stream of events
        for chunk in self.response:
            if self.close == 0:
                chunk_message = chunk['choices'][0]['delta']  # extract the message
                if hasattr(chunk_message, "content"):
                    collected_messages += chunk_message.content
                    content = {"role": "system", "content": collected_messages}
                    if chatModeldatas[self._modelDataIndex]["content"][len(chatModeldatas[self._modelDataIndex]["content"]) - 1]["role"] == "user":
                        chatModeldatas[self._modelDataIndex]["content"].append(content)
                    else:
                        chatModeldatas[self._modelDataIndex]["content"][len(chatModeldatas[self._modelDataIndex]["content"]) - 1] = content
                    
                    call(collected_messages,0)

                finish_reason = chunk['choices'][0]["finish_reason"]
                if finish_reason == "stop":
                    call(collected_messages,1)
                if finish_reason == "max_tokens":
                    call(collected_messages,2)
            else:
                call(collected_messages,1)
                break
    
    def StopRequest(self):
        self.close = 1


# ------------------ 多线程处理卡顿问题 -----------------
import threading

AIChatObj = AIChat()
class AIChatThread(threading.Thread):  # 继承父类threading.Thread
    def __init__(self, threadID, name, counter, call, prompt):
        threading.Thread.__init__(self)
        self.threadID = threadID
        self.name = name
        self.counter = counter
        self.call = call
        self.prompt = prompt

    def run(self):
        AIChatObj.RequestOpenAI(self.call, self.prompt)

def CallRequestOpenAI(call, prompt):
    thread = AIChatThread(1, "AIChatThread", 1, call, prompt)
    thread.start()

def StopRequestOpenAI():
    AIChatObj.StopRequest()

def AddChatModelDataTitle(title):
    chatModeldatas.append({"title":title,"content":[{"role":"system","content":"请问有什么可以帮助你的？"}]})
    
def DelChatModeDataTitle(index):
    del chatModeldatas[index]

def GetChatModelDataTitles():
    titles = []
    for item in chatModeldatas:
        titles.append(item["title"])
    return titles

def InitChatModelData(index):
    if len(chatModeldatas) == 0:
        AddChatModelDataTitle("new title")

    AIChatObj.InitChatModelData(index)

def AddChatModelData(data):
    AIChatObj.AddChatModelData(data)

def SetChatModelData(data):
    AIChatObj.SetChatModelData(data)

def GetChatModelData():
    return AIChatObj.GetChatModelData()
# ------------- test -------------
# def TestCall(res):
#     print(res)

# CallRequestOpenAI(TestCall,"nihao")
