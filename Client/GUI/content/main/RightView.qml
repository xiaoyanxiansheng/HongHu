import QtQuick
import QtQuick.Controls
//import "shortvedio" as SV
import "chat" as Chat
import QtMultimedia

Item {
    width: 1000
    height: 600

//    SV.ShortVedio_Cut{ visible: false ;anchors.fill: parent}

    Chat.ChatMain{ visible: true; anchors.fill: parent}
}
