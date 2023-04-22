from concurrent.futures.thread import _worker
from aiosignal import Signal
import openai
import threading

openai.api_key = "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"

allMessages = []
def RequestOpenAI(call,prompt):
    allMessages.append({"role": "user", "content": prompt})
    response = openai.ChatCompletion.create(
        model='gpt-3.5-turbo',
        messages=allMessages,
        temperature=0,
        stream=True  # again, we set stream=True
    )

    collected_messages = ""
    # iterate through the stream of events
    for chunk in response:
        chunk_message = chunk['choices'][0]['delta']  # extract the message
        if hasattr(chunk_message,"content"):
            collected_messages += chunk_message.content
            content = {"role": "system", "content": collected_messages}
            if allMessages[len(allMessages)-1]["role"] == "user":
                allMessages.append(content)
            else:
                allMessages[len(allMessages)-1] = content
            call(collected_messages)
                

#------------------ 多线程处理卡顿问题 -----------------
import threading
exitFlag = 0
class myThread (threading.Thread):   #继承父类threading.Thread
    def __init__(self, threadID, name, counter,call,prompt):
        threading.Thread.__init__(self)
        self.threadID = threadID
        self.name = name
        self.counter = counter
        self.call = call
        self.prompt = prompt
    def run(self):                   #把要执行的代码写到run函数里面 线程在创建后会直接运行run函数 
        RequestOpenAI(self.call, self.prompt)

def CallRequestOpenAI(call,prompt):
    # 创建新线程
    thread1 = myThread(1, "Thread-1", 1 ,call , prompt)
    # 开启线程
    thread1.start()


# ------------- test -------------
# def ResponseCall(collected_messages):
#     print(collected_messages)
# # RequestOpenAI(ResponseCall,"中国排名前2的城市是？")
# threading.Thread.run(RequestOpenAI,(ResponseCall,"中国排名前2的城市是？"))
# def printTest(reponseMessage):
#     print(reponseMessage)
# CallRequestOpenAI(printTest,"中国排名前十的城市是？")