import QtQuick 2.1
import Sailfish.Silica 1.0


Item {
    property alias text: label.text

    Text {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        id: label
        color: Theme.highlightColor
        font.pixelSize: parent.height * 0.75
        font.family: Theme.fontFamily

        opacity: applicationData.lettersOwned.indexOf(text) >= 0 ? 1.0 : 0.0
        visible: opacity > 0.0

        //anchors.horizontalCenterOffset: visible ? 0 : -topLevel.width / 2

        Behavior on anchors.horizontalCenterOffset {
            NumberAnimation {
                duration: 500
                easing.type: Easing.OutQuad
            }
        }
    }

    Rectangle {
        color: Theme.secondaryHighlightColor
        width: parent.width
        anchors.bottom: parent.bottom
        anchors.top: label.bottom
    }
}
