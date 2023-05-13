import QtQuick
import QtQuick.Controls
import QtMultimedia

Rectangle {
    id: vedio

    property string assetPath

    width: 126
    height: 126
    color: "#bce6e7"
    anchors {
        horizontalCenter: parent.horizontalCenter
        verticalCenter: parent.verticalCenter
    }
    radius: 3

    MediaPlayer {
        id: mediaPlayer
        source: assetPath
        audioOutput: AudioOutput {}

        onPositionChanged: {
            //button.text = Math.ceil((duration - position)/1000)
        }
    }

    Button {
        id: button
        x: 0
        y: 97
        opacity: 0.8
        text: qsTr("P")
        anchors.left: parent.right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.top
        anchors.rightMargin: 0
        anchors.bottomMargin: -29
        anchors.leftMargin: -32
        anchors.topMargin: 0
        display: AbstractButton.TextUnderIcon
        highlighted: true
        font.styleName: "Light"
        font.pointSize: 8
        icon.width: 32
        icon.color: "#fffc9e"
        onClicked: {
            if(mediaPlayer.playbackState === MediaPlayer.PlayingState)
                mediaPlayer.stop()
            else
                mediaPlayer.play()
        }
    }
}
