// Copyright (C) 2019 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Controls

Rectangle {
    id: icon

    required property Item dragParent
    property string assetPath

    property int visualIndex: 0
    width: 126
    height: 126
    color: "#4b4b4b"
    anchors {
        horizontalCenter: parent.horizontalCenter
        verticalCenter: parent.verticalCenter
    }
    radius: 3

    DragHandler {
        id: dragHandler
    }

    Image {
        id: image
        objectName: "image"
        anchors.fill: parent
        source: assetPath
        fillMode: Image.PreserveAspectFit
    }

    Button {
        id: button
        x: 100
        y: 0
        visible: false
        text: qsTr("Button")
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 100
        anchors.topMargin: 0
        anchors.leftMargin: 100
        anchors.rightMargin: 0
    }

    //    Label {
    //        id: label
    //        objectName: "shortvideo_keycut_vedio_icon"
    //        text: qsTr("Label")
    //        anchors.fill: parent
    //    }

    Drag.active: dragHandler.active
    Drag.source: icon
    Drag.hotSpot.x: 36
    Drag.hotSpot.y: 36

    states: [
        State {
            when: dragHandler.active
            ParentChange {
                target: icon
                parent: icon.dragParent
            }

            AnchorChanges {
                target: icon
                anchors {
                    horizontalCenter: undefined
                    verticalCenter: undefined
                }
            }
        }
    ]
}
