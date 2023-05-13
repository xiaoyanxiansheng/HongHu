import QtQuick
import QtQuick.Controls

Item {
    function addChatItem(role,content){
        listModel.insert(0,{"role":role,"content":content})
    }
    function setChatItem(content){
        listModel.setProperty(0,"content",content)
    }
    function clearChatItem(){
        listModel.clear()
    }

    property int chatState : 0

    id: item1
    width: 600
    height: 400
    visible: true

        ListView {
        id: listView
        anchors.fill: parent
        anchors.topMargin: 15
        anchors.rightMargin: 14
        anchors.leftMargin: 21
        anchors.bottomMargin: 113
        clip: true
        displayMarginBeginning: 40
        displayMarginEnd: 40
        verticalLayoutDirection: ListView.BottomToTop
        spacing: 12
        model: DelegateModel {
            model: ListModel {
                id: listModel
            }
            delegate: Row {
                id : root
                required property string role // "user" "system"
                required property string content
                ChatViewItem{
                    backcolor : role === "user" ? "#c8c5fd" : "white"
                    content : role === "user" ? "你: " + root.content : "AI: " + root.content
                }
            }
        }

        ScrollBar.vertical: ScrollBar {}
    }

    Frame {
        id: frame
        visible: true
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.bottom
        anchors.bottom: parent.bottom
        anchors.topMargin: -95
        rightPadding: 1
        bottomPadding: 1
        topPadding: 1

        TextArea {
            id: messageField
            anchors.left: parent.left
            anchors.right: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            placeholderText: qsTr("请输入...")
            wrapMode: TextArea.Wrap
            anchors.rightMargin: -676
            Keys.onReturnPressed: {
                if(chatState != 0){
                    chatMain_mode_content.signal_userInput(messageField.text)
                    messageField.text = ""
                }
            }
        }

        Button {
            id: sendButton
            objectName: "chatMain_mode_content_sendBtn"
            text: chatState != 0 ? qsTr("Send") : qsTr("Stop")
            anchors.left: parent.right
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: -156

            property string textContent : ""
            onClicked: {
                textContent = messageField.text
                if(chatState != 0){
                    messageField.text = ""
                }
                chatMain_mode_content.signal_userInput(textContent)
            }

            BusyIndicator {
                id: busyIndicator
                visible: chatState == 0
                anchors.fill: parent
            }
        }
    }
}
