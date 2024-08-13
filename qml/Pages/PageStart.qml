import QtQuick
import QtQuick.Layouts
import QtQuick.Dialogs

import "../Controls"
import "../Config"

Item {
    id: root
    objectName: "pageStart"

    readonly property string textColor: "white"
    readonly property string secondaryTextColor: "lightgray"

    ColumnLayout {
        anchors {
            fill: parent
            margins: 20
        }

        ColumnLayout {
            spacing: SizeConfig.spacing

            Image {
                Layout.maximumWidth: implicitHeight * 0.6
                Layout.preferredHeight: 250
                Layout.maximumHeight: 250
                Layout.alignment: Qt.AlignHCenter

                source: "qrc:/choose.svg"
            }

            Text {
                text: qsTr("Text Analyzer")
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                color: ColorConfig.textColor
                font {
                    pixelSize: 36
                    bold: true
                }
            }

            Text {
                Layout.fillWidth: true
                text: qsTr("Select a .txt file to analyze")
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                color: ColorConfig.secondaryTextColor

                font {
                    weight: 400
                    pixelSize: 18
                }
            }
        }

        BasicButton {
            id: buttonStart
            text: qsTr("Select file")
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            onClicked: fileDialog.open()
        }

    }

    FileDialog {
        id: fileDialog
        nameFilters: [ "Text files (*.txt)" ]
        onAccepted: {
            const selectedFile = fileDialog.selectedFile.toString().replace("file://", "")
            FileProcessor.filename = selectedFile

            root.parent.goToNextPage()
        }
    }
}
