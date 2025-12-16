import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

Item {
    id: wallpaperFader
    property Item mainStack
    property Item footer
    property alias source: wallpaperBlur.source

    // Safety check for state
    state: "off"
    property real factor: 0

    // Smooth transition for the blur factor
    Behavior on factor {
        NumberAnimation {
            duration: 1000
            easing.type: Easing.InOutQuad
        }
    }

    // Standard Blur - This replaces the complex ShaderEffect
    FastBlur {
        id: wallpaperBlur
        anchors.fill: parent
        radius: 50 * wallpaperFader.factor

        // Dim the background slightly as it blurs
        Rectangle {
            anchors.fill: parent
            color: "black"
            opacity: 0.3 * wallpaperFader.factor
        }
    }

    states: [
        State {
            name: "on"
            PropertyChanges { target: mainStack; opacity: 1 }
            PropertyChanges { target: footer; opacity: 1 }
            PropertyChanges { target: wallpaperFader; factor: 1 }
        },
        State {
            name: "off"
            PropertyChanges { target: mainStack; opacity: 0 }
            PropertyChanges { target: footer; opacity: 0 }
            PropertyChanges { target: wallpaperFader; factor: 0 }
        }
    ]

    transitions: [
        Transition {
            from: "off"; to: "on"
            ParallelAnimation {
                NumberAnimation { target: mainStack; property: "opacity"; duration: 500; easing.type: Easing.InOutQuad }
                NumberAnimation { target: footer; property: "opacity"; duration: 500; easing.type: Easing.InOutQuad }
            }
        },
        Transition {
            from: "on"; to: "off"
            ParallelAnimation {
                NumberAnimation { target: mainStack; property: "opacity"; duration: 500; easing.type: Easing.InOutQuad }
                NumberAnimation { target: footer; property: "opacity"; duration: 500; easing.type: Easing.InOutQuad }
            }
        }
    ]
}
