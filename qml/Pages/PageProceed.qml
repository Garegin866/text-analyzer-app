import QtQuick
import QtQuick.Layouts

import QtQuick.Controls.Material

import "../Controls"
import "../Config"

Item {
    id: root
    objectName: "pageProceed"

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20

        ColumnLayout {
            spacing: SizeConfig.spacing

            Image {
                Layout.maximumWidth: implicitHeight * 0.6
                Layout.preferredHeight: 250
                Layout.maximumHeight: 250
                Layout.alignment: Qt.AlignHCenter

                source: "qrc:/analyze.svg"
            }

            Text {
                Layout.fillWidth: true
                text: qsTr("Ready to proceed ? This will start the analysis process.")
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                color: ColorConfig.secondaryTextColor

                font {
                    weight: 400
                    pixelSize: 18
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom

            BasicButton {
                text: qsTr("Select another")
                filled: false
                onClicked: root.parent.goToInitialPage()
            }

            BasicButton {
                text: qsTr("Analyze file")
                onClicked: root.parent.goToNextPage()
            }
        }
    }
}
