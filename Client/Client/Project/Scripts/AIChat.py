import openai

from Scripts.Define import *

openai.api_key = KEY_OPENAI

class AIChat:
    def __init__(self):
        self._allMessages = []

    # 请求
    def RequestOpenAI(self, call, prompt):
        self._allMessages.append({"role": "user", "content": prompt})
        response = openai.ChatCompletion.create(
            model='gpt-3.5-turbo',
            messages=self._allMessages,
            temperature=0,
            stream=True  # again, we set stream=True
        )

        collected_messages = ""
        # iterate through the stream of events
        for chunk in response:
            chunk_message = chunk['choices'][0]['delta']  # extract the message
            if hasattr(chunk_message, "content"):
                collected_messages += chunk_message.content
                content = {"role": "system", "content": collected_messages}
                if self._allMessages[len(self._allMessages) - 1]["role"] == "user":
                    self._allMessages.append(content)
                else:
                    self._allMessages[len(self._allMessages) - 1] = content
                call(collected_messages)


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

# ------------- test -------------
# def TestCall(res):
#     print(res)
# testAIChat = AIChat()
# testAIChat.RequestOpenAI(TestCall,"nihao")
# CallRequestOpenAI(TestCall,"nihao")
