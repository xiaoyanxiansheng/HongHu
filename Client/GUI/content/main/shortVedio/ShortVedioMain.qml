import QtQuick
import QtQuick.Controls

Item {
    width: 1280
    height: 1080

    Rectangle {
        id: rectangle1
        visible: true
        color: "#a6a9de"
        anchors.fill: parent



        Rectangle {
            id: rectangle2
            visible: true
            color: "#e3e3e3"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.top
            anchors.bottomMargin: -100

            Row {
                anchors.fill: parent
                Button {
                    width: 251
                    height: 92
                    text: qsTr("混剪(一键)1")
                    anchors.verticalCenter: parent.verticalCenter
                    checkable: true
                    font.pointSize: 24
                    checked: true
                    autoExclusive: true
                }

                Button {
                    width: 251
                    height: 92
                    visible: true
                    text: qsTr("混剪(自定义)")
                    anchors.verticalCenter: parent.verticalCenter
                    checkable: true
                    font.pointSize: 24
                    autoExclusive: true
                }
                spacing: 20
            }
        }
        Rectangle {
            visible: true
            color: "#a6a9de"
            anchors.fill: parent
            anchors.bottomMargin: 0
            anchors.topMargin: 106

            ShortVedio_Cut {
                visible: true
                anchors.fill: parent
                objectName: "shortVedio_keycut_vedioContent"
                Component.onCompleted: {
//                        addItem(0,"file:///D:/DD/HongHu/Client/Client/Project/GUI/Assets/download.png")
//                        addItem(0,"file:///D:/DD/HongHu/Client/Client/Project/GUI/Assets/download.png")
//                        addItem(1,"file:///D:/DD/HongHu/Client/Client/Project/GUI/Assets/b.mp4")
//                        addItem(1,"file:///D:/DD/HongHu/Client/Client/Project/GUI/Assets/b.mp4")
                }
            }
        }
        Rectangle {
            visible: false
            color: "#a6a9de"
            anchors.fill: parent
            anchors.topMargin: 100
            Label {
                x: 78
                y: 101
                text: qsTr("Label")
            }
        }
    }
}
