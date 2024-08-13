import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

import QtQuick.Layouts

import "../Controls"
import "../Config"

Item {
    id: root
    objectName: "pageMain"

    property int wordsCount: 0

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20

        TabBar {
            id: bar
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop

            Material.accent: ColorConfig.accentColor
            Material.foreground: ColorConfig.textColor

            background: Rectangle {
                color: ColorConfig.backgroundColor
                radius: SizeConfig.radius
            }

            TabButton {
                text: qsTr("Histogram")
            }
            TabButton {
                text: qsTr("Table")
            }
        }

        StackLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: Constants.kMAIN_CONTENT_HEIGHT
            Layout.maximumHeight: Constants.kMAIN_CONTENT_HEIGHT
            currentIndex: bar.currentIndex
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop

            Histogram {
                id: histogram
                width: parent.width * 0.9
                wordsCount: root.wordsCount
            }

            Table {
                id: table
                width: parent.width * 0.9
            }
        }

        ProgressBar {
            id: progressBar

            Material.accent: ColorConfig.accentColor
            Layout.alignment: Qt.AlignHCenter
            visible: FileProcessor.isProcessing


            Connections {
                target: FileProcessor

                function onProgressChanged(bytesRead, totalBytes) {
                    progressBar.value = bytesRead
                    progressBar.to = totalBytes
                }
            }
        }


        RowLayout {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom

            BasicButton {
                visible: FileProcessor.isProcessing
                text: qsTr("Stop")
                onClicked: FileProcessor.stopProcessing()
            }

            BasicButton {
                visible: !FileProcessor.isProcessing
                filled: false
                text: qsTr("Select another file")
                onClicked: root.parent.goToInitialPage()
            }
        }
    }

    Component.onCompleted: {
        FileProcessor.startProcessing()
    }


    Timer {
        interval: Constants.kUPDATE_INTERVAL
        running: FileProcessor.isProcessing
        repeat: true
        onTriggered: { updateWordCount() }
    }

    function updateWordCount() {
        const wordsObject = WordCountModel.getTopWords(Constants.kMAX_WORDS)
        const words = wordsObject["words"]
        root.wordsCount = wordsObject["totalWords"]

        histogram.model = words
        table.model = words
    }

    Connections {
        target: FileProcessor
        function onIsProcessingChanged() {
            updateWordCount()
        }
    }

}
