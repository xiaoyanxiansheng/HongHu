import QtQuick
import QtQuick.Controls

Item {
    id: shortVedio_keycut_Content
    width: 1500
    height: 1000

    function addItem(displayMode,path) {
        colorModel.append({"displayMode":displayMode,"assetPath":path})
    }

    function addCombineItem(path) {
        combineVedio.assetPath = path
    }


    Rectangle {
        id: rectangle1
        color: "#b9d2d7"
        anchors.fill: parent
        anchors.rightMargin: 8
        anchors.topMargin: 81
        anchors.bottomMargin: 416

        TextArea {
            id: textArea
            anchors.fill: parent
            anchors.topMargin: -79
            anchors.bottomMargin: 8
            anchors.rightMargin: 602
            placeholderText: qsTr("输入文案")
        }

        TextArea {
            id: textArea1
            anchors.left: parent.right
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.rightMargin: -9
            anchors.topMargin: -79
            anchors.bottomMargin: 49
            anchors.leftMargin: -596
            placeholderText: qsTr("...")
        }

        Button {
            id: button2
            text: qsTr("生成文案")
            objectName: "shortvideo_keycut_btn_txt"
            anchors.left: parent.right
            anchors.right: parent.right
            anchors.top: parent.bottom
            anchors.bottom: parent.bottom
            font.pointSize: 12
            anchors.topMargin: -45
            anchors.bottomMargin: 8
            anchors.leftMargin: -596
            anchors.rightMargin: 0
        }
    }




    Rectangle {
        id: rectangle
        width: 588
        height: 100
        visible: true
        color: "#c8f7fe"
        anchors.fill: parent
        anchors.topMargin: 284
        anchors.rightMargin: 546

        ScrollView {
            id: scrollView
            visible: true
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.bottom
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: -410
            anchors.rightMargin: 175
            bottomPadding: 1
            focusPolicy: Qt.NoFocus
            clip: true

            GridView {
                id: root
                anchors.fill: parent
                anchors.bottomMargin: -32
                anchors.topMargin: 248
                anchors.rightMargin: 738
                highlightMoveDuration: 100
                contentHeight: 160
                contentWidth: 160
                cellWidth: 160
                cellHeight: 160

                displaced: Transition {
                    NumberAnimation {
                        properties: "x,y"
                        easing.type: Easing.OutQuad
                    }
                }

                model: DelegateModel {
                    id: visualModel
                    model: ListModel {
                        id: colorModel
                    }
                    delegate: DropArea {
                        id: delegateRoot
                        required property int displayMode
                        required property string assetPath

                        width: 160
                        height: 160

                        onEntered: function(drag) {
                            visualModel.items.move((drag.source as Icon).visualIndex, icon.visualIndex)
                        }

                        property int visualIndex: DelegateModel.itemsIndex

                        Icon {
                            id: icon
                            width: 150
                            height: 150
                            dragParent: root
                            visualIndex: delegateRoot.visualIndex
                            assetPath: delegateRoot.displayMode === 0 ? delegateRoot.assetPath : ""
                            visible: delegateRoot.displayMode === 0
                        }

                        Vedio
                        {
                            width: 150
                            height: 150
                            dragParent: root
                            visualIndex: delegateRoot.visualIndex
                            assetPath: delegateRoot.displayMode === 1 ? delegateRoot.assetPath : ""
                            visible: delegateRoot.displayMode === 1
                        }
                    }
                }
            }
        }

        Vedio{
            id: combineVedio
            width: 176
            height: 176
            anchors.verticalCenterOffset: -14
            anchors.horizontalCenterOffset: 136
            dragParent: null
            visualIndex: 0
        }

        Button {
            id: button
            x: 24
            y: 548
            objectName: "shortvideo_keycut_btn_vedio"
            text: "刷 新"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.bottom
            anchors.bottom: parent.bottom
            anchors.topMargin: -89
            anchors.leftMargin: 279
            font.pointSize: 16
            anchors.rightMargin: 8
            anchors.bottomMargin: 8
        }
    }
    Rectangle {
        id: rectangle5
        visible: true
        color: "#d6eff7"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: rectangle1.bottom
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 235
        anchors.leftMargin: 459
        anchors.topMargin: 6

        Rectangle {
            id: rectangle3
            visible: true
            color: "#ffffff"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.top
            anchors.rightMargin: 0
            anchors.bottomMargin: -97

            //            Button {
            //                id: button1
            //                text: qsTr("刷 新")
            //                anchors.left: parent.left
            //                anchors.right: parent.right
            //                anchors.top: parent.bottom
            //                anchors.bottom: parent.bottom
            //                anchors.topMargin: -27
            //                font.pointSize: 12
            //            }

            Audio{
                x: 50
                y: 150
                width: 100
                height: 73
                anchors.horizontalCenterOffset: -104
                assetPath: "file:///D:/DD/HongHu/Client/downloads/image_name.mp3"

            }

            Audio {
                x: 50
                y: 150
                width: 100
                height: 73
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 11
                anchors.horizontalCenterOffset: -209
                assetPath: "file:///D:/DD/HongHu/Client/downloads/image_name.mp3"
            }

            Audio {
                x: 54
                y: 154
                width: 100
                height: 73
                anchors.horizontalCenterOffset: 2
                anchors.verticalCenterOffset: 0
                assetPath: "file:///D:/DD/HongHu/Client/downloads/image_name.mp3"
            }

            Audio {
                x: 52
                y: 152
                width: 100
                height: 73
                anchors.horizontalCenterOffset: 106
                anchors.verticalCenterOffset: 0
                assetPath: "file:///D:/DD/HongHu/Client/downloads/image_name.mp3"
            }

            Audio {
                x: 57
                y: 157
                width: 100
                height: 73
                anchors.horizontalCenterOffset: 214
                anchors.verticalCenterOffset: 0
                assetPath: "file:///D:/DD/HongHu/Client/downloads/image_name.mp3"
            }

            Button {
                x: 0
                y: 54
                objectName: "shortvideo_keycut_btn_background"
                height: 43
                text: qsTr("背景刷新")
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                font.pointSize: 12
                anchors.leftMargin: 0
                anchors.bottomMargin: 0
                anchors.rightMargin: 0
            }
        }

        Rectangle {
            id: rectangle4
            x: 8
            y: 98
            height: 80
            visible: true
            color: "#8ee3ff"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 0
            anchors.rightMargin: 0


            Audio {
                x: 9
                y: -86
                width: 100
                height: 73
                anchors.bottom: parent.bottom
                anchors.verticalCenterOffset: -11
                anchors.horizontalCenterOffset: -210
                anchors.bottomMargin: 22
                assetPath: "file:///D:/DD/HongHu/Client/downloads/image_name.mp3"
            }

            ComboBox {
                id: comboBox
                y: 0
                height: 45
                anchors.left: parent.right
                anchors.right: parent.right
                anchors.leftMargin: -90
                anchors.rightMargin: 0
                textRole: ""
                model: ["First", "Second", "Third"]
            }
            Button {
                objectName: "shortvideo_keycut_btn_mouth"
                y: 36
                height: 44
                text: qsTr("口播刷新")
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                font.pointSize: 12
                anchors.rightMargin: 0
                anchors.bottomMargin: 0
                anchors.leftMargin: 0
            }
        }
    }

    Button {
        id: button1
        objectName: "shortvideo_keycut_btn"
        text: qsTr("Button")
        anchors.left: parent.right
        anchors.right: parent.right
        anchors.top: parent.bottom
        anchors.bottom: parent.bottom
        anchors.topMargin: -116
        anchors.bottomMargin: 48
        anchors.leftMargin: -382
        anchors.rightMargin: 153
    }
}
