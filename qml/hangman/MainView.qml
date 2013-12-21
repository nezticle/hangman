import QtQuick 2.1
import Sailfish.Silica 1.0


SilicaFlickable {
    id: topLevel

    state: "PLAYING"

    property bool isReady: gameScreen.visible

    height: 480
    width: 320

    function allContained(owned, word)
    {
        for (var i=0; i<word.length; ++i) {
            if (owned.indexOf(word.charAt(i)) < 0)
                return false
        }
        return true
    }

    property bool gameOver: applicationData.errorCount > 8
    property bool success: applicationData.word.length > 0 && !gameOver && allContained(applicationData.lettersOwned, applicationData.word)

    onSuccessChanged: {
        if (success) {
            topLevel.state = "GAMEOVER"
        }
    }

    onGameOverChanged: {
        topLevel.state = "GAMEOVER"
        if (gameOver)
            applicationData.gameOverReveal();
    }

    Item {
        id: gameScreen
        visible: applicationData.word.length > 0
        anchors.fill: parent

        Item {
            anchors.top: gameScreen.top
            anchors.bottom: word.top
            anchors.left: parent.left
            anchors.right: parent.right

            Hangman {
                anchors.centerIn: parent
                width: Math.min(parent.width, parent.height) * 0.75
                height: width
                gameOver: topLevel.gameOver
                success: topLevel.success
            }
        }

        Word {
            id: word
            text: applicationData.word
            anchors.bottom: letterSelector.top
            anchors.bottomMargin: parent.height * 0.05
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.8
            height: parent.height * 0.1
        }

        LetterSelector {
            id: letterSelector
            locked: gameOver || success
            anchors.margins: 8
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height * 0.05
            anchors.left: parent.left
            anchors.right: parent.right
            height: parent.height * 0.25
            onLetterSelected: {
                if (applicationData.isVowel(letter) && Qt.platform.os === "ios") {
                    showPurchaseDialog(letter);
                } else {
                    applicationData.requestLetter(letter.charAt(0));
                }
            }
        }
        Button {
            id: resetButton
            text: "Reset"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: Theme.paddingLarge
            anchors.horizontalCenter: parent.horizontalCenter
            visible: false
            onClicked: {
                letterSelector.reset();
                applicationData.reset();
                topLevel.state = "PLAYING"
            }
        }
    }

    function showPurchaseDialog(letter) {
        purchaseDialog.letter = letter;
        purchaseDialog.state = "INITIAL";
        purchaseDialog.visible = true;
    }

//    WordInputDialog {
//        id: wordInputDialog
//        visible: false
//        anchors.fill: parent

//        onVisibleChanged: {
//            if (visible)
//                topLevel.state = "GUESSING"
//            else
//                topLevel.state = "PLAYING"
//        }
//    }

    PurchaseDialog {
        id: purchaseDialog
        visible: false
        anchors.fill: parent
    }

    Connections {
        target: applicationData
        onVowelBought: {
            letterSelector.vowelPurchased(vowel);
        }
    }

    PullDownMenu {
        id: pullDownMenu
        MenuItem {
            id: revealMenuItem
            text: "Reveal"
            onClicked: {
                applicationData.reveal();
                topLevel.state = "GAMEOVER"
            }
        }
        MenuItem {
            id: guessMenuItem
            text: "Guess Word"
            onClicked: {
                applicationWindow.pageStack.push("WordInputDialog.qml")
                //wordInputDialog.visible = true;
                //topLevel.state = "GUESSING"
            }
        }
        MenuItem {
            id: resetMenuItem
            text: "Reset"
            onClicked: {
                letterSelector.reset();
                applicationData.reset();
                topLevel.state = "PLAYING"
            }
        }
    }

    states: [
        State {
            name: "PLAYING"
            PropertyChanges {
                target: pullDownMenu
                visible: true
            }
            PropertyChanges {
                target: revealMenuItem
                visible: true
            }
            PropertyChanges {
                target: guessMenuItem
                visible: true
            }
            PropertyChanges {
                target: resetMenuItem
                visible: true
            }
            PropertyChanges {
                target: letterSelector
                visible: true
            }
            PropertyChanges {
                target: word
                anchors.bottom: letterSelector.top
            }
            PropertyChanges {
                target: resetButton
                visible: false

            }
        },
        State {
            name: "GAMEOVER"
            PropertyChanges {
                target: revealMenuItem
                visible: false
            }
            PropertyChanges {
                target: guessMenuItem
                visible: false
            }
            PropertyChanges {
                target: resetMenuItem
                visible: true
            }
            PropertyChanges {
                target: pullDownMenu
                visible: true
            }
            PropertyChanges {
                target: resetButton
                visible: true

            }
        }/*,
        State {
            name: "GUESSING"
            PropertyChanges {
                target: revealMenuItem
                visible: false
            }
            PropertyChanges {
                target: pullDownMenu
                visible: false
            }
            PropertyChanges {
                target: word
                anchors.bottom: gameScreen.bottom
            }
        }*/
    ]
}
