import QtQuick
import QtQuick.Controls

Item {
    width: 512
    height: 300

    Image {
        id: image
        anchors.fill: parent
        source: "qrc:/qtquickplugin/images/template_image.png"
        fillMode: Image.PreserveAspectFit
    }
}
