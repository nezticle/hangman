import QtQuick 2.1
import Sailfish.Silica 1.0


SimpleButton {
    id: keyItem

    property bool purchasable: false

    signal keyActivated(string letter)

    onClicked: {
        if (available) {
            keyActivated(text);
        }
    }

}
