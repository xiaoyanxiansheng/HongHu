import QtQuick
import QtQuick.Controls

Rectangle {
    id: chatMain_mode_content
    objectName: "chatMain_mode_content"

    // title
    function clearChatTitle(){
        listMode.clear()
    }
    function addChatTitle(title){
        listMode.append({"title":title})
    }
    function delChatTitle(index){
        listMode.remove(index)
    }

    // content
    function addChatItem(role,content){
        chatView.addChatItem(role,content)
    }
    function setChatItem(content){
        chatView.setChatItem(content)
    }
    function clearChatItem(){
        chatView.clearChatItem()
    }

    function setChatState(state){
        chatView.chatState = state
    }

    signal signal_test()

    signal signal_clickChatTitle(int index) // 选择model index
    signal signal_clickChatTitle_add() // 增加
    signal signal_clickChatTitle_del(int index) // 删除

    signal signal_userInput(string input) // 获取用户聊天输入

    width: 600
    height: 1000


    Rectangle {
        id: rectangle1
        x: 0
        y: 0
        width: 994
        height: 78
        color: "#aaacac"

        Row {
            id: row
            anchors.fill: parent
            spacing: 10
            layoutDirection: Qt.LeftToRight

            Button {
                id: button
                width: 150
                height: 50
                text: qsTr("Button")
                anchors.verticalCenter: parent.verticalCenter
                checked: true
                autoExclusive: true
                checkable: true
            }

            Button {
                id: button1
                width: 150
                height: 50
                text: qsTr("Button")
                anchors.verticalCenter: parent.verticalCenter
                autoExclusive: true
                checkable: true
            }

            Button {
                id: button2
                width: 150
                height: 50
                text: qsTr("Button")
                anchors.verticalCenter: parent.verticalCenter
                autoExclusive: true
                checkable: true
            }

            Button {
                id: button3
                width: 150
                height: 50
                text: qsTr("Button")
                anchors.verticalCenter: parent.verticalCenter
                autoExclusive: true
                checkable: true
            }
        }
    }


    Rectangle {
        id: rectangle3
        color: "#e3e3e3"
        border.color: "#ff0000"
        anchors.fill: parent
        anchors.leftMargin: 140
        anchors.topMargin: 84

        ChatVIew{
            id:chatView
            anchors.fill: parent;
        }
    }
    Rectangle {
        id: rectangle2
        color: "#8f8b8e"
        anchors.left: parent.left
        anchors.right: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        clip: true
        anchors.rightMargin: -134
        anchors.leftMargin: 0
        anchors.bottomMargin: 8
        anchors.topMargin: 84

        ListView {
            id: listView
            anchors.fill: parent
            anchors.bottomMargin: 67
            anchors.topMargin: 8
            model: DelegateModel
            {
                model: ListModel {
                    id : listMode
                    property int selectIndex: 0
                }
                delegate: Item {
                    id:itemdelegate
                    required property string title
                    property int visualIndex: DelegateModel.itemsIndex

                    x: 5
                    width: 125
                    height: 80
                    Row {
                        id: row1
                        spacing: 10

                        Rectangle {
                            id: rectangle4
                            width: 120
                            height: 75
                            color: listMode.selectIndex == itemdelegate.visualIndex ? "#ffffff" : "#000000"

                            Text {
                                id: text1
                                text: itemdelegate.title
                                anchors.fill: parent
                                font.pixelSize: 12
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                wrapMode: Text.Wrap
                                color: listMode.selectIndex == itemdelegate.visualIndex ? "#000000" : "#ffffff"
                            }

                            MouseArea{
                                width: 120
                                height: 75
                                onClicked: {
                                    listMode.selectIndex = itemdelegate.visualIndex
                                    chatMain_mode_content.signal_clickChatTitle(itemdelegate.visualIndex)
                                }
                            }
                        }
                    }
                }
            }
        }

        Button {
            id: button4
            text: qsTr("+")
            anchors.left: parent.left
            anchors.right: parent.left
            anchors.top: parent.bottom
            anchors.bottom: parent.bottom
            anchors.rightMargin: -61
            font.pointSize: 48
            highlighted: true
            anchors.topMargin: -55
            autoExclusive: false
            checkable: false
            onClicked: {
                chatMain_mode_content.signal_clickChatTitle_add()
            }
        }

        Button {
            id: button5
            x: 1
            y: 1
            text: qsTr("-")
            anchors.left: parent.right
            anchors.right: parent.right
            anchors.top: parent.bottom
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.leftMargin: -61
            anchors.topMargin: -55
            anchors.rightMargin: 0
            autoExclusive: false
            font.pointSize: 48
            highlighted: true
            checkable: false
            onClicked: {
                chatMain_mode_content.signal_clickChatTitle_del(listMode.selectIndex)
            }
        }
    }
}
