import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

// import QtQuick.Controls.impl
// import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl

Button {
    id: control

    property bool filled: true

    Material.background: filled ? "#75e6a4" : "transparent"
    Material.foreground: filled ? "#233239" : "#75e6a4"

    background: Rectangle {
        implicitWidth: 64
        implicitHeight: control.Material.buttonHeight

        border.width: filled ? 0 : 2
        border.color:  !control.enabled ? control.Material.hintTextColor :
                                          (control.flat && control.highlighted) || (control.checked && !control.highlighted) ? control.Material.accentColor :
                                          control.highlighted ? control.Material.primaryHighlightedTextColor : control.Material.foreground

        radius: control.Material.roundedScale === Material.FullScale ? height / 2 : control.Material.roundedScale
        color: control.Material.buttonColor(control.Material.theme, control.Material.background,
            control.Material.accent, control.enabled, control.flat, control.highlighted, control.checked)


        layer.enabled: control.enabled && color.a > 0 && !control.flat
        layer.effect: RoundedElevationEffect {
            elevation: control.Material.elevation
            roundedScale: control.background.radius
        }

        Ripple {
            clip: true
            clipRadius: parent.radius
            width: parent.width
            height: parent.height
            pressed: control.pressed
            anchor: control
            active: enabled && (control.down || control.visualFocus || control.hovered)
            color: control.flat && control.highlighted ? control.Material.highlightedRippleColor : control.Material.rippleColor
        }
    }

}
