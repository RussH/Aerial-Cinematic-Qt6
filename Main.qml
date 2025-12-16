import QtQuick
import QtQuick.Controls
import SddmComponents
import QtMultimedia

import "components"

Rectangle {
    id: container
    width: 1600
    height: 900
    color: "black"

    TextConstants { id: textConstants }

    // Virtual Keyboard Suppression
    Item { id: inputPanel; visible: false; enabled: false; property bool active: false }

    readonly property int targetSession: (typeof session !== 'undefined') ? session.index : 0
    FontLoader { id: textFont; source: config.displayFont.indexOf("/") !== -1 ? Qt.resolvedUrl(config.displayFont) : "" }
    readonly property string mainFontFamily: (config.displayFont.indexOf("/") !== -1) ? textFont.name : config.displayFont

    // --- INACTIVITY LOGIC ---
    Timer {
        id: uiDelayTimer
        interval: config.fadeDuration
        running: false; repeat: false
        onTriggered: {
            login_ui_content.opacity = 0
            power_buttons.opacity = 0
            session_row_container.opacity = 0
            background_overlay.opacity = 0
        }
    }

    function resetUI() {
        login_ui_content.opacity = 1
        power_buttons.opacity = 1
        session_row_container.opacity = 1
        background_overlay.opacity = 0.4
        uiDelayTimer.restart()
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onPositionChanged: resetUI()
        onPressed: resetUI()
        propagateComposedEvents: true
    }

    // --- 1. THE VIDEO ---
    MediaPlayer {
        id: mediaplayer1
        source: config.backgroundVideo.startsWith("/") ? "file://" + config.backgroundVideo : config.backgroundVideo
        videoOutput: video1
        loops: MediaPlayer.Infinite
    }

    VideoOutput {
        id: video1
        anchors.fill: parent
        fillMode: VideoOutput.PreserveAspectCrop
    }

    // --- 2. THE DIMMER ---
    Rectangle {
        id: background_overlay
        anchors.fill: parent
        color: "black"
        opacity: 0.4
        Behavior on opacity { NumberAnimation { duration: 1000 } }
    }

    // --- 3. THE UI ---

    // Clock
    Column {
        id: clock
        property date dateTime: new Date()
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height * 0.25
        Timer { interval: 1000; running: true; repeat: true; onTriggered: clock.dateTime = new Date() }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            color: config.clockFontColor
            text : Qt.formatTime(clock.dateTime, config.timeFormat)
            font.pointSize: config.clockFontSize
            font.family: container.mainFontFamily
            style: Text.Outline; styleColor: "#aa000000"
        }
    }

    // Login Fields
    Rectangle {
        id: login_ui_content
        anchors.top: clock.bottom; anchors.topMargin: 40
        anchors.horizontalCenter: parent.horizontalCenter
        width: 320; height: 140; color: "transparent"
        Behavior on opacity { NumberAnimation { duration: 1000 } }

        Column {
            spacing: 15; anchors.fill: parent
            TextField {
                id: username_input_box
                width: parent.width; height: 46; leftPadding: config.inputPadding
                text: (typeof userModel !== 'undefined') ? userModel.lastUser : ""
                placeholderText: "Username"
                color: "white"; font.pointSize: config.inputFontSize
                background: Rectangle { color: "black"; opacity: 0.5; radius: 23; border.color: parent.activeFocus ? config.accentColor : "white" }
            }
            TextField {
                id: password_input_box
                width: parent.width; height: 46; leftPadding: config.inputPadding
                echoMode: TextInput.Password; placeholderText: "Password"
                color: "white"; font.pointSize: config.inputFontSize
                background: Rectangle { color: "black"; opacity: 0.5; radius: 23; border.color: parent.activeFocus ? config.accentColor : "white" }
                onAccepted: sddm.login(username_input_box.text, password_input_box.text, session_repeater.currentIndex)
            }
        }
    }

    // --- SESSION SELECTION (Horizontal List Version) ---
    Row {
        id: session_row_container
        anchors.bottom: parent.bottom; anchors.left: parent.left; anchors.margins: 40
        spacing: 10
        visible: config.showSessionSelect === "true"
        Behavior on opacity { NumberAnimation { duration: 1000 } }

        Repeater {
            id: session_repeater
            model: sessionModel
            property int currentIndex: sessionModel.lastIndex

            Rectangle {
                width: session_label.implicitWidth + 20; height: 34
                color: "black"; opacity: index === session_repeater.currentIndex ? 0.8 : 0.4
                radius: 17; border.color: index === session_repeater.currentIndex ? config.accentColor : "white"

                Text {
                    id: session_label
                    anchors.centerIn: parent
                    text: model.name || "Session " + index // Fallback text
                    color: "white"; font.pointSize: 9; font.bold: index === session_repeater.currentIndex
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: session_repeater.currentIndex = index
                }
            }
        }
    }

    // Power Buttons
    Row {
        id: power_buttons
        anchors.bottom: parent.bottom; anchors.right: parent.right; anchors.margins: 40
        spacing: 20
        Behavior on opacity { NumberAnimation { duration: 1000 } }
        Rectangle {
            width: 55; height: 55; radius: 27.5; color: "black"; opacity: 0.4; border.color: "white"
            Text { anchors.centerIn: parent; text: "↻"; color: "white"; font.pointSize: 24 }
            MouseArea { anchors.fill: parent; onClicked: sddm.reboot() }
        }
        Rectangle {
            width: 55; height: 55; radius: 27.5; color: "black"; opacity: 0.4; border.color: "white"
            Text { anchors.centerIn: parent; text: "⏻"; color: "white"; font.pointSize: 20 }
            MouseArea { anchors.fill: parent; onClicked: sddm.powerOff() }
        }
    }

    Component.onCompleted: {
        mediaplayer1.play()
        if (username_input_box.text === "") username_input_box.focus = true; else password_input_box.focus = true;
        uiDelayTimer.start()
    }
}
