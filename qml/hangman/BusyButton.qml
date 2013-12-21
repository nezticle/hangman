import QtQuick 2.1
import Sailfish.Silica 1.0

SimpleButton {
    BusyIndicator {
        id: busyIndicator
        anchors.fill: parent
        visible: !parent.available
        running: visible
    }
}
