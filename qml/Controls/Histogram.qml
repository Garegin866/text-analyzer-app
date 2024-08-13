import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

import "../Config"

Rectangle {
    id: control

    color: ColorConfig.backgroundColor
    radius: SizeConfig.radius

    required property int wordsCount

    property alias model: listView.model

    Item {
        anchors {
            fill: parent
            leftMargin: listView.spacing
            topMargin: listView.spacing
            bottomMargin: listView.spacing
        }

        ListView {
            id: listView
            width: parent.width
            height: parent.height
            spacing: SizeConfig.spacing
            orientation: ListView.Horizontal
            boundsBehavior: Flickable.StopAtBounds
            clip: true
            delegate: Item {
                width: listView.width / Constants.kMAX_WORDS - listView.spacing
                height: listView.height

                Rectangle {
                    width: parent.width
                    height: control.wordsCount > 0 ? (modelData.count / control.wordsCount) * parent.height : 0
                    color: ColorConfig.accentColor
                    radius: SizeConfig.radius
                    anchors {
                        bottom: parent.bottom
                    }

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        onHoveredChanged: {
                            if (containsMouse) {
                                tooltip.text = modelData.word
                                tooltip.x = mapToItem(control, 0, 0).x - (tooltip.width - width) / 2
                                tooltip.y = mapToItem(control, 0, 0).y - tooltip.height - SizeConfig.spacing
                                tooltip.visible = true
                            } else {
                                tooltip.visible = false
                            }
                        }
                    }
                }
            }
        }
    }

    Popup {
        id: tooltip

        property alias text: label.text

        background: Rectangle {
            color: ColorConfig.secondaryBackgroundColor
            radius: SizeConfig.radius

            border.color: ColorConfig.accentColor
            border.width: 1
        }

        width: Math.min(label.width, SizeConfig.tooltipMaxWidth) + (2 * padding)
        height: label.height + (2 * padding)
        padding: SizeConfig.spacing
        clip: true

        Text {
            id: label
            color: ColorConfig.accentColor
            font.bold: true
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.NoWrap
            elide: Text.ElideRight
        }
    }
}

