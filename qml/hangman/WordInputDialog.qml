import QtQuick 2.1
import Sailfish.Silica 1.0


Page {
    id: dialog
    height: 480
    width: 320

    function guess() {
        applicationData.guessWord(input.text)
        input.text = ""
        Qt.inputMethod.hide();
        applicationWindow.pageStack.pop();
    }

    Column {
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        id: column

        Label {
            id: label
            text: "What's the word?"
            font.pixelSize: Theme.fontSizeLarge
            font.family: Theme.fontFamily
            anchors.horizontalCenter: parent.horizontalCenter
        }

        TextField {
            id: input
            font.pixelSize: Theme.fontSizeLarge
            font.capitalization: Font.AllUppercase
            font.family: Theme.fontFamily
            inputMethodHints: Qt.ImhLatinOnly | Qt.ImhUppercaseOnly | Qt.ImhNoPredictiveText
            horizontalAlignment: Text.AlignHCenter
            focus: true

            EnterKey.text: "Guess"
            EnterKey.onClicked: {
                dialog.guess();
            }
            EnterKey.enabled: text.length === applicationData.word.length
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            height: column.subComponentHeight
            spacing: 8
            Button {
                id: okButton
                text: "Guess"

                onClicked: {
                    dialog.guess();
                }
            }
            Button {
                id: cancelButton
                text: "Cancel"

                onClicked: {
                    input.text = ""
                    Qt.inputMethod.hide();
                    applicationWindow.pageStack.pop();
                }
            }
        }
    }
    Word {
        id: word
        text: applicationData.word
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height * 0.05
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.8
        height: parent.height * 0.1
    }

}
