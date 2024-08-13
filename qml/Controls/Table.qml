import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import "../Config"

Rectangle {
    id: control

    color: ColorConfig.backgroundColor
    radius: SizeConfig.radius

    property alias model: listView.model

    Item {
        id: header
        height: SizeConfig.rowHeight
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        Rectangle {
            id: headerRect
            color: ColorConfig.accentColor
            radius: SizeConfig.radius
            anchors {
                fill: parent
                margins: SizeConfig.spacing
            }

            Row {
                anchors.fill: parent
                spacing: SizeConfig.spacing

                Text {
                    width: (parent.width / 2) - (SizeConfig.spacing / 2)
                    text: qsTr("Word")
                    clip: true
                    color: ColorConfig.secondaryBackgroundColor
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text {
                    width: (parent.width / 2) - (SizeConfig.spacing / 2)
                    text: qsTr("Count")
                    clip: true
                    color: ColorConfig.secondaryBackgroundColor
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }

    ListView {
        id: listView
        clip: true
        spacing: SizeConfig.spacing
        anchors {
            top: header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            bottomMargin: SizeConfig.spacing
        }

        delegate: Item {
            width: listView.width
            height: SizeConfig.rowHeight
            clip: true

            Rectangle {
                clip: true
                color: ColorConfig.secondaryBackgroundColor
                radius: SizeConfig.radius

                anchors {
                    fill: parent
                    leftMargin: SizeConfig.spacing
                    rightMargin: SizeConfig.spacing
                }

                Row {
                    anchors.fill: parent
                    spacing: SizeConfig.spacing

                    Text {
                        width: (parent.width / 2) - (SizeConfig.spacing / 2)
                        text: modelData.word
                        color: ColorConfig.accentColor
                        clip: true
                        horizontalAlignment: Text.AlignHCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Text {
                        width: (parent.width / 2) - (SizeConfig.spacing / 2)
                        text: modelData.count
                        color: ColorConfig.accentColor
                        clip: true
                        horizontalAlignment: Text.AlignHCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }

        }
    }
}
