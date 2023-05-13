import QtQuick
import QtQuick.Controls
import QtMultimedia

Rectangle {
    id: vedio

    required property Item dragParent
    property string assetPath

    property int visualIndex: 0
    width: 126
    height: 126
    color: "#333333"
    anchors {
        horizontalCenter: parent.horizontalCenter
        verticalCenter: parent.verticalCenter
    }
    radius: 3

    DragHandler {
        id: dragHandler
    }



    Drag.active: dragHandler.active
    Drag.source: dragParent
    Drag.hotSpot.x: 36
    Drag.hotSpot.y: 36

    states: [
        State {
            when: dragHandler.active
            ParentChange {
                target: vedio
                parent: vedio.dragParent
            }

            AnchorChanges {
                target: vedio
                anchors {
                    horizontalCenter: undefined
                    verticalCenter: undefined
                }
            }
        }
    ]

    Video {
        property int playFlag : 0
        property int playTime : 0
        id: video
        width: 126
        height: 126
        anchors.right: parent.right
        anchors.fill: parent
        source: assetPath

        MouseArea {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
        }

        onPlaying:
        {
            playFlag = 1
        }

        onStopped:
        {
            playFlag = 0
        }

        onPositionChanged: {
            button.text = Math.ceil((duration - position)/1000)
        }

//        focus: true
//        Keys.onSpacePressed: video.playbackState === MediaPlayer.PlayingState ? video.pause() : video.play()
//        Keys.onLeftPressed: video.position = video.position - 5000
//        Keys.onRightPressed: video.position = video.position + 5000
    }
    Button {
        id: button
        opacity: 0.8
        text: qsTr("P")
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.topMargin: 0
        anchors.bottomMargin: 115
        anchors.leftMargin: 115
        display: AbstractButton.TextUnderIcon
        highlighted: true
        font.styleName: "Light"
        font.pointSize: 8
        icon.width: 32
        icon.color: "#fffc9e"
        onClicked: {
            if(video.playFlag === 0)
                video.play()
            else
                video.stop()
        }
    }

}
