import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import "main" as Main

Item {
    id: rootitem
    width: 1200
    height: 800
    visible: true

    Main.LeftTab{
        anchors.left: parent.left
        anchors.right: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: -200
    }

    Main.RightView{
        anchors.fill: parent
        anchors.leftMargin: 206
    }
}
