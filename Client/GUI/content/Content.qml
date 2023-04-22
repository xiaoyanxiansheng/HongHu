import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

Item {
    id: rootitem
    width: 1920
    height: 1080
    visible: true

    Rectangle {
        id: rectangle
        width: Constants.width
        height: Constants.height
        color: "#adb0d7"

        Rectangle {
            id: rectangle1
            x: 0
            y: 0
            width: 239
            height: 1080
            color: "#a6a9de"

            Column {
                id: column
                anchors.fill: parent
                anchors.topMargin: 82
                spacing: 20

                Button {
                    id: button1
                    width: 239
                    height: 136
                    text: "短视频1"
                    font.pointSize: 36
                    icon.width: 24
                    checkable: true
                    autoExclusive: true
                    checked: true
                }

                Button {
                    id: button2
                    width: 239
                    height: 136
                    text: qsTr("AI")
                    font.pointSize: 36
                    checkable: true
                    autoExclusive: true
                    checked: false
                }

                Button {
                    id: button3
                    objectName: "testbutton"
                    width: 239
                    height: 136
                    text: qsTr("抖音(未开放)")
                    font.pointSize: 36
                    checkable: false
                    autoExclusive: false
                    checked: false
                    // onPressed: fileDialog.open();
                }
            }

            Rectangle {
                id: rectangle2
                x: 258
                y: 0
                width: 1662
                height: 1080
                color: "#a6a9de"

                Rectangle {
                    id: rectangle100
                    x: 0
                    y: 0
                    width: 1662
                    height: 217
                    visible: false
                    color: "#a6a9de"

                    Row {
                        id: row
                        anchors.fill: parent
                        spacing: 20

                        Button {
                            id: button
                            width: 251
                            height: 92
                            text: qsTr("混剪(一键)1")
                            anchors.verticalCenter: parent.verticalCenter
                            checked: true
                            autoExclusive: true
                            checkable: true
                            font.pointSize: 24
                        }

                        Button {
                            id: button4
                            width: 251
                            height: 92
                            visible: true
                            text: qsTr("混剪(自定义)")
                            anchors.verticalCenter: parent.verticalCenter
                            autoExclusive: true
                            checkable: true
                            font.pointSize: 24
                        }
                    }

                    Rectangle {
                        id: rectangle6
                        x: 0
                        y: 217
                        width: 1662
                        height: 861
                        visible: true
                        color: "#a6a9de"

                        FolderDialog {
                            id: shortvideo_keycut_vedio_dialog
                            title: "选择视频或者图片文件夹"
                            acceptLabel: "确定"
                            rejectLabel: "取消"
                        }
                        FileDialog {
                            id: shortvideo_keycut_mp3_dialog
                            title: "选择音频"
                            nameFilters: ["音频 (*.mp3)"]
                            acceptLabel: "确定"
                            rejectLabel: "取消"
                            fileMode: FileDialog.OpenFile
                        }
                        FileDialog {
                            id: shortvideo_keycut_txt_dialog
                            title: "选择文本"
                            nameFilters: ["文本 (*.txt)"]
                            acceptLabel: "确定"
                            rejectLabel: "取消"
                            fileMode: FileDialog.OpenFile
                        }
                        FileDialog {
                            id: shortvideo_keycut_front_dialog
                            title: "选择图片"
                            nameFilters: ["图片 (*.jpg *png)"]
                            acceptLabel: "确定"
                            rejectLabel: "取消"
                            fileMode: FileDialog.OpenFile
                        }

                        Column {
                            id: column1
                            x: 0
                            y: 0
                            width: 1662
                            height: 629
                            topPadding: 10

                            Item {
                                width: 1662
                                height: 93

                                Button {
                                    id: button8
                                    x: 1264
                                    y: 18
                                    width: 249
                                    height: 50
                                    text: qsTr("视频和图片")
                                    font.pointSize: 24
                                    icon.width: 36
                                    onPressed: shortvideo_keycut_vedio_dialog.open()
                                }

                                TextField {
                                    objectName: "shortvideo_keycut_vedio_text"
                                    x: 27
                                    y: 18
                                    width: 1145
                                    height: 54
                                    horizontalAlignment: Text.AlignLeft
                                    placeholderTextColor: "#80000000"
                                    font.pointSize: 24
                                    placeholderText: shortvideo_keycut_vedio_dialog.currentFolder
                                }
                            }

                            Item {
                                width: 1662
                                height: 93
                                Button {
                                    x: 1264
                                    y: 18
                                    width: 249
                                    height: 50
                                    text: qsTr("音频")
                                    icon.width: 36
                                    font.pointSize: 24
                                    onPressed: shortvideo_keycut_mp3_dialog.open()
                                }

                                TextField {
                                    objectName: "shortvideo_keycut_mp3_text"
                                    x: 27
                                    y: 18
                                    width: 1145
                                    height: 54
                                    horizontalAlignment: Text.AlignLeft
                                    placeholderTextColor: "#80000000"
                                    font.pointSize: 24
                                    placeholderText: shortvideo_keycut_mp3_dialog.currentFile
                                }
                            }

                            Item {
                                id: item3
                                width: 1662
                                height: 93
                                Button {
                                    x: 1264
                                    y: 18
                                    width: 249
                                    height: 50
                                    text: qsTr("字幕")
                                    icon.width: 36
                                    font.pointSize: 24
                                    onPressed: shortvideo_keycut_txt_dialog.open()
                                }

                                TextField {
                                    objectName: "shortvideo_keycut_txt_text"
                                    x: 27
                                    y: 18
                                    width: 1145
                                    height: 54
                                    horizontalAlignment: Text.AlignLeft
                                    placeholderTextColor: "#80000000"
                                    font.pointSize: 24
                                    placeholderText: shortvideo_keycut_txt_dialog.currentFile
                                }
                            }

                            Item {
                                id: item4
                                width: 1662
                                height: 93
                                Button {
                                    x: 1264
                                    y: 18
                                    width: 249
                                    height: 50
                                    text: qsTr("封面")
                                    icon.width: 36
                                    font.pointSize: 24
                                    onPressed: shortvideo_keycut_front_dialog.open()
                                }

                                TextField {
                                    objectName: "shortvideo_keycut_front_text"
                                    x: 27
                                    y: 18
                                    width: 1145
                                    height: 54
                                    horizontalAlignment: Text.AlignLeft
                                    placeholderTextColor: "#80000000"
                                    font.pointSize: 24
                                    placeholderText: shortvideo_keycut_front_dialog.currentFile
                                }
                            }
                        }

                        Button {
                            id: button9
                            objectName: "shortvideo_keycut"
                            x: 668
                            y: 715
                            width: 326
                            height: 76
                            text: qsTr("生 成")
                            font.pointSize: 32
                        }
                    }

                    Rectangle {
                        id: rectangle7
                        x: 0
                        y: 217
                        width: 1662
                        height: 861
                        visible: false
                        color: "#a6a9de"

                        Label {
                            id: label
                            x: 78
                            y: 101
                            text: qsTr("Label")
                        }
                    }
                }

                Rectangle {
                    id: rectangle4
                    x: 0
                    y: 0
                    width: 1662
                    height: 217
                    visible: true
                    color: "#a6a9de"
                    Row {
                        anchors.fill: parent
                        spacing: 15
                        Button {
                            id: button7
                            width: 251
                            height: 92
                            text: qsTr("AI文案")
                            anchors.verticalCenter: parent.verticalCenter
                            checked: true
                            autoExclusive: true
                            checkable: true
                        }

                        Button {
                            id: button6
                            width: 251
                            height: 92
                            text: qsTr("AI搜索")
                            anchors.verticalCenter: parent.verticalCenter
                            autoExclusive: true
                            checkable: true
                        }
                    }

                    Rectangle {
                        id: rectangle8
                        x: 0
                        y: 165
                        width: 1662
                        height: 913
                        visible: button7.checked
                        color: "#a6a9de"
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: -861
                        anchors.rightMargin: 0

                        Rectangle {
                            id: rectangle9
                            x: 8
                            y: 8
                            width: 1646
                            height: 539
                            color: "#a6a9de"
                            border.color: "#ffffff"
                            border.width: 2

                            ScrollView {
                                id: scrollView
                                x: 0
                                y: 0
                                width: 1646
                                height: 539

                                TextArea {
                                    id: textArea
                                    x: 0
                                    y: 0
                                    width: 1624
                                    height: 525
                                    visible: true
                                    text: ""
                                    verticalAlignment: Text.AlignTop
                                    wrapMode: Text.Wrap
                                    font.wordSpacing: 0
                                    font.styleName: "Light"
                                    transformOrigin: Item.Center
                                    focus: false
                                    antialiasing: false
                                    font.preferShaping: true
                                    font.kerning: true
                                    font.hintingPreference: Font.PreferDefaultHinting
                                    font.capitalization: Font.MixedCase
                                    font.pointSize: 12
                                    objectName: "textArea"
                                    placeholderText: qsTr("等待中...")
                                }
                            }
                        }

                        Rectangle {
                            id: rectangle10
                            x: 11
                            y: 573
                            width: 1293
                            height: 325
                            visible: true
                            color: "#a6a9de"
                            border.color: "#ffffff"
                            border.width: 2
                            TextArea {
                                id: textArea1
                                objectName: "textArea1"
                                visible: true
                                anchors.fill: parent
                                wrapMode: Text.Wrap
                                font.styleName: "Bold"
                                font.pointSize: 24
                                anchors.topMargin: 8
                                anchors.leftMargin: 8
                                placeholderText: qsTr("请输入文案")
                                anchors.bottomMargin: 8
                                anchors.rightMargin: 8
                            }
                        }

                        Button {
                            id: button5
                            objectName: "PushButton"
                            x: 1338
                            y: 652
                            width: 305
                            height: 168
                            text: qsTr("发送")
                            font.pointSize: 36
                        }

                    }

                    Rectangle {
                        id: rectangle11
                        x: -2
                        y: 163
                        width: 1662
                        height: 913
                        visible: button6.checked
                        color: "#a6a9de"
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: -861
                        Rectangle {
                            x: 8
                            y: 8
                            width: 1646
                            height: 539
                            color: "#a6a9de"
                            border.color: "#ffffff"
                            border.width: 2
                            TextArea {
                                id: textArea2
                                anchors.fill: parent
                                anchors.topMargin: 8
                                anchors.leftMargin: 8
                                placeholderText: qsTr("等待中...")
                                anchors.bottomMargin: 8
                                anchors.rightMargin: 14
                            }
                        }

                        Rectangle {
                            x: 11
                            y: 573
                            width: 1293
                            height: 325
                            color: "#a6a9de"
                            border.color: "#ffffff"
                            border.width: 2
                            TextArea {
                                id: textArea3
                                anchors.fill: parent
                                anchors.topMargin: 8
                                anchors.leftMargin: 8
                                placeholderText: qsTr("请输入搜索内容")
                                anchors.bottomMargin: 8
                                anchors.rightMargin: 14
                            }
                        }

                        Button {
                            x: 1338
                            y: 652
                            width: 305
                            height: 168
                            text: qsTr("发送")
                            font.pointSize: 36
                        }
                        anchors.rightMargin: 0
                    }
                }

                Rectangle {
                    id: rectangle5
                    x: 0
                    y: 0
                    width: 1662
                    height: 217
                    visible: false
                    color: "#a6a9de"
                    Row {
                        anchors.fill: parent
                        Button {
                            width: 251
                            height: 92
                            text: qsTr("Button")
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }
            }
        }

        Item {
            id: __materialLibrary__
        }

        states: [
            State {
                name: "clicked"
                when: button.checked
            }
        ]
    }

}
