import QtQuick
import QtQuick.Controls

import "Pages"

Window {
    id: appWindow

    // Hardcoded values for development on desktop
    width: 380
    height: 680

    visible: true
    visibility: Qt.platform.os === "android" ? Window.FullScreen : Window.Windowed
    title: qsTr("Text Analyzer")
    color: "#233239"

    StackView {
        id: rootStackView

        width: appWindow.width
        height: appWindow.height
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            bottom: parent.bottom
        }

        initialItem: pageStart

        function goToNextPage() {
            switch (rootStackView.currentItem.objectName) {
                case "pageStart":
                    rootStackView.push(pageProceed)
                    break
                case "pageProceed":
                    rootStackView.push(pageMain)
                    break
            }
        }

        function goToInitialPage() {
            rootStackView.clear()
            rootStackView.push(rootStackView.initialItem)
        }
    }

    Component {
        id: pageStart

        PageStart {}
    }

    Component {
        id: pageProceed

        PageProceed {}
    }

    Component {
        id: pageMain

        PageMain {}
    }

}
