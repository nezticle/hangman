# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = Hangman

CONFIG += sailfishapp

SOURCES += \
    src/Hangman.cpp \
    src/data.cpp \
    src/data_default.cpp

HEADERS += \
    src/data.h

OTHER_FILES += qml/Hangman.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    qml/pages/SecondPage.qml \
    qml/hangman/BusyButton.qml \
    qml/hangman/Hangman.qml \
    qml/hangman/Key.qml \
    qml/hangman/Letter.qml \
    qml/hangman/LetterSelector.qml \
    qml/hangman/MainView.qml \
    qml/hangman/PurchaseDialog.qml \
    qml/hangman/SimpleButton.qml \
    qml/hangman/SpashScreen.qml \
    qml/hangman/Word.qml \
    qml/hangman/WordInputDialog.qml \
    rpm/Hangman.spec \
    rpm/Hangman.yaml \
    Hangman.desktop

RESOURCES += \
    src/resources.qrc

