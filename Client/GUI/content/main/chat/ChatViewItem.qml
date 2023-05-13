import QtQuick
import QtQuick.Controls

Rectangle {
    required property color backcolor
    required property string content

    width: 800
    height: text1.implicitHeight

    Rectangle {
        id: rectangle
        color: backcolor
        border.color: "#000000"
        anchors.fill: parent
    }

    Text {
        id: text1
        text: content
        anchors.fill: parent
        font.pixelSize: 24
        horizontalAlignment: Text.AlignLeft
        wrapMode: Text.Wrap
        minimumPixelSize: 24
    }
}
