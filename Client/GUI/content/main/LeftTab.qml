import QtQuick
import QtQuick.Controls

Item {
    width: 200
    height: 1080

    Rectangle {
        id: rectangle
        visible: true
        color: "#adb0d7"
        anchors.fill: parent

        Column {
            id: column
            x: 0
            y: 82
            anchors.fill: parent
            Button {
                height: 136
                text: "短视频"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 0
                anchors.rightMargin: 0
                checkable: true
                font.pointSize: 36
                icon.width: 24
                checked: true
                autoExclusive: true
            }

            Button {
                height: 136
                text: qsTr("AI")
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                checkable: true
                font.pointSize: 36
                checked: false
                autoExclusive: true
            }

            Button {
                height: 136
                text: qsTr("抖音(未开放)")
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                objectName: "testbutton"
                checkable: false
                font.pointSize: 36
                checked: false
                autoExclusive: false
            }
            spacing: 20
            anchors.topMargin: 82
        }
        states: [
            State {
                name: "clicked"
            }]
    }
}
