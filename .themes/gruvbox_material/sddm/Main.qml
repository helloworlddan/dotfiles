import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15

Rectangle {
    id: root
    width: 1920
    height: 1080
    color: config.background_color

    // --- Background Image with fallback to solid color ---
    Image {
        id: backgroundImage
        anchors.fill: parent
        source: config.background_image ? config.background_image : ""
        fillMode: Image.PreserveAspectCrop
        visible: source != ""
        asynchronous: true
        smooth: true
        
        // Dark subtle overlay to increase readability of UI elements
        Rectangle {
            anchors.fill: parent
            color: "#000000"
            opacity: 0.25
        }
    }

    // --- Dynamic Clock & Date ---
    Timer {
        id: clockTimer
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            var date = new Date()
            timeLabel.text = Qt.formatTime(date, "HH:mm")
            dateLabel.text = Qt.formatDate(date, "dddd, d MMMM yyyy")
        }
    }

    // --- Connections to SDDM Greeter Events ---
    Connections {
        target: sddm
        
        function onLoginFailed() {
            errorMessage.text = config.login_failed_text
            errorMessage.visible = true
            passwordField.text = ""
            passwordField.forceActiveFocus()
            errorTimer.restart()
        }
        
        function onLoginSucceeded() {
            errorMessage.text = "Success"
            errorMessage.color = config.accent_color
            errorMessage.visible = true
        }
    }

    Timer {
        id: errorTimer
        interval: 5000
        repeat: false
        onTriggered: {
            errorMessage.visible = false
        }
    }

    // --- Core Login Card Panel ---
    ColumnLayout {
        anchors.centerIn: parent
        spacing: 28
        width: 350

        // Time and Date Display
        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 2

            Text {
                id: timeLabel
                Layout.alignment: Qt.AlignHCenter
                color: config.foreground_color
                font.pixelSize: 64
                font.bold: true
                font.family: config.font_family
                smooth: true
            }

            Text {
                id: dateLabel
                Layout.alignment: Qt.AlignHCenter
                color: config.muted_color
                font.pixelSize: 15
                font.family: config.font_family
                smooth: true
            }
        }

        // Card Container
        Rectangle {
            id: card
            Layout.fillWidth: true
            implicitHeight: cardColumn.implicitHeight + 48
            color: config.card_background
            border.color: config.border_color
            border.width: 1
            radius: 8

            ColumnLayout {
                id: cardColumn
                anchors.fill: parent
                anchors.margins: 24
                spacing: 20

                // Rounded Square Avatar with Fallback Letter
                Rectangle {
                    id: avatarContainer
                    Layout.alignment: Qt.AlignHCenter
                    width: 76
                    height: 76
                    radius: 12
                    color: config.input_background
                    border.color: config.border_color
                    border.width: 1
                    clip: true

                    Image {
                        id: avatarImage
                        anchors.fill: parent
                        source: (userModel && userModel.count > 0 && userSelector.currentIndex >= 0) ? userModel.get(userSelector.currentIndex).icon : ""
                        fillMode: Image.PreserveAspectCrop
                        smooth: true
                        visible: source != ""
                    }

                    Text {
                        anchors.centerIn: parent
                        text: (userModel && userModel.count > 0 && userSelector.currentIndex >= 0) ? userModel.get(userSelector.currentIndex).name.substring(0, 1).toUpperCase() : "?"
                        color: config.accent_color
                        font.pixelSize: 34
                        font.bold: true
                        font.family: config.font_family
                        visible: avatarImage.source == ""
                    }
                }

                // Adaptive User Input
                Item {
                    id: userInputWrapper
                    Layout.fillWidth: true
                    implicitHeight: 40

                    // ComboBox for listing multiple users
                    ComboBox {
                        id: userSelector
                        anchors.fill: parent
                        model: userModel
                        textRole: "name"
                        currentIndex: userModel && userModel.lastIndex >= 0 ? userModel.lastIndex : 0
                        font.family: config.font_family
                        font.pixelSize: 14
                        visible: userModel && userModel.count > 0
                        activeFocusOnTab: visible

                        background: Rectangle {
                            color: config.input_background
                            border.color: userSelector.activeFocus ? config.accent_color : config.border_color
                            border.width: 1
                            radius: 4
                        }

                        contentItem: Text {
                            leftPadding: 12
                            rightPadding: userSelector.indicator.width + userSelector.spacing
                            text: userSelector.displayText
                            font: userSelector.font
                            color: config.foreground_color
                            verticalAlignment: Text.AlignVCenter
                            elide: Text.ElideRight
                        }

                        indicator: Text {
                            x: userSelector.width - width - 12
                            y: (userSelector.height - height) / 2
                            text: "▼"
                            font.pixelSize: 9
                            color: userSelector.hovered ? config.accent_color : config.muted_color
                            verticalAlignment: Text.AlignVCenter
                        }

                        popup: Popup {
                            y: userSelector.height + 4
                            width: userSelector.width
                            implicitHeight: Math.min(180, contentItem.implicitHeight)
                            padding: 4

                            contentItem: ListView {
                                clip: true
                                implicitHeight: contentHeight
                                model: userSelector.popup.visible ? userSelector.delegateModel : null
                                currentIndex: userSelector.highlightedIndex
                                ScrollIndicator.vertical: ScrollIndicator { }
                            }

                            background: Rectangle {
                                color: config.card_background
                                border.color: config.border_color
                                border.width: 1
                                radius: 4
                            }
                        }

                        delegate: ItemDelegate {
                            width: userSelector.width
                            height: 36
                            
                            contentItem: Text {
                                text: model.realName !== "" ? model.realName : model.name
                                color: highlighted ? config.foreground_color : config.highlight_color
                                font: userSelector.font
                                elide: Text.ElideRight
                                verticalAlignment: Text.AlignVCenter
                            }
                            
                            background: Rectangle {
                                color: highlighted ? config.border_color : "transparent"
                                radius: 2
                            }
                            
                            highlighted: userSelector.highlightedIndex === index
                        }
                    }

                    // Fallback TextField if userModel is empty
                    TextField {
                        id: usernameField
                        anchors.fill: parent
                        color: config.foreground_color
                        placeholderText: config.username_placeholder
                        placeholderTextColor: config.muted_color
                        font.family: config.font_family
                        font.pixelSize: 14
                        selectByMouse: true
                        visible: !userSelector.visible
                        activeFocusOnTab: visible

                        background: Rectangle {
                            color: config.input_background
                            border.color: usernameField.activeFocus ? config.accent_color : config.border_color
                            border.width: 1
                            radius: 4
                        }
                    }
                }

                // Password Field with Toggle Show/Hide Password
                TextField {
                    id: passwordField
                    Layout.fillWidth: true
                    implicitHeight: 40
                    color: config.foreground_color
                    echoMode: TextInput.Password
                    placeholderText: config.password_placeholder
                    placeholderTextColor: config.muted_color
                    font.family: config.font_family
                    font.pixelSize: 14
                    selectByMouse: true
                    activeFocusOnTab: true
                    rightPadding: revealButton.width + 16

                    background: Rectangle {
                        color: config.input_background
                        border.color: passwordField.activeFocus ? config.accent_color : config.border_color
                        border.width: 1
                        radius: 4
                    }

                    Button {
                        id: revealButton
                        anchors.right: parent.right
                        anchors.rightMargin: 8
                        anchors.verticalCenter: parent.verticalCenter
                        width: 24
                        height: 24
                        flat: true
                        background: Rectangle { color: "transparent" }
                        
                        contentItem: Text {
                            text: passwordField.echoMode === TextInput.Password ? "👁" : "👁‍🗨"
                            font.pixelSize: 15
                            color: revealButton.hovered ? config.accent_color : config.muted_color
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        
                        onClicked: {
                            passwordField.echoMode = (passwordField.echoMode === TextInput.Password) ? TextInput.Normal : TextInput.Password
                        }
                    }

                    onAccepted: {
                        attemptLogin()
                    }
                }

                // Error Message Area
                Text {
                    id: errorMessage
                    Layout.fillWidth: true
                    color: config.error_color
                    font.pixelSize: 12
                    font.family: config.font_family
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                    visible: false
                }

                // Login Button
                Button {
                    id: loginButton
                    Layout.fillWidth: true
                    implicitHeight: 40
                    text: config.login_button_text
                    activeFocusOnTab: true

                    contentItem: Text {
                        text: loginButton.text
                        font.pixelSize: 14
                        font.bold: true
                        font.family: config.font_family
                        color: loginButton.hovered ? config.background_color : config.foreground_color
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    background: Rectangle {
                        color: loginButton.down ? config.info_color : (loginButton.hovered ? config.accent_color : "transparent")
                        border.color: config.accent_color
                        border.width: 1
                        radius: 4

                        Behavior on color {
                            ColorAnimation { duration: 150 }
                        }
                    }

                    onClicked: {
                        attemptLogin()
                    }
                }
            }
        }
    }

    // --- Bottom Bar with Session Selector and Power Options ---
    RowLayout {
        id: bottomBar
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: 40
        anchors.rightMargin: 40
        anchors.bottomMargin: 30

        // Session Selector ComboBox
        RowLayout {
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            spacing: 8

            Text {
                text: config.session_label
                color: config.muted_color
                font.pixelSize: 13
                font.family: config.font_family
            }

            ComboBox {
                id: sessionSelector
                model: sessionModel
                textRole: "name"
                currentIndex: sessionModel && sessionModel.lastIndex >= 0 ? sessionModel.lastIndex : 0
                font.family: config.font_family
                font.pixelSize: 13
                activeFocusOnTab: true

                background: Rectangle {
                    implicitWidth: 150
                    implicitHeight: 32
                    color: "transparent"
                    border.color: sessionSelector.activeFocus ? config.accent_color : config.border_color
                    border.width: 1
                    radius: 4
                }

                contentItem: Text {
                    leftPadding: 10
                    rightPadding: sessionSelector.indicator.width + sessionSelector.spacing
                    text: sessionSelector.displayText
                    font: sessionSelector.font
                    color: config.highlight_color
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }

                indicator: Text {
                    x: sessionSelector.width - width - 10
                    y: (sessionSelector.height - height) / 2
                    text: "▼"
                    font.pixelSize: 9
                    color: sessionSelector.hovered ? config.accent_color : config.muted_color
                    verticalAlignment: Text.AlignVCenter
                }

                popup: Popup {
                    y: -height - 4
                    width: sessionSelector.width
                    implicitHeight: Math.min(180, contentItem.implicitHeight)
                    padding: 4

                    contentItem: ListView {
                        clip: true
                        implicitHeight: contentHeight
                        model: sessionSelector.popup.visible ? sessionSelector.delegateModel : null
                        currentIndex: sessionSelector.highlightedIndex
                        ScrollIndicator.vertical: ScrollIndicator { }
                    }

                    background: Rectangle {
                        color: config.card_background
                        border.color: config.border_color
                        border.width: 1
                        radius: 4
                    }
                }

                delegate: ItemDelegate {
                    width: sessionSelector.width
                    height: 32

                    contentItem: Text {
                        text: model.name
                        color: highlighted ? config.foreground_color : config.highlight_color
                        font: sessionSelector.font
                        elide: Text.ElideRight
                        verticalAlignment: Text.AlignVCenter
                    }

                    background: Rectangle {
                        color: highlighted ? config.border_color : "transparent"
                        radius: 2
                    }

                    highlighted: sessionSelector.highlightedIndex === index
                }
            }
        }

        // Spacer to push items to the left and right corners
        Item {
            Layout.fillWidth: true
        }

        // Power Operations (Suspend, Reboot, Power Off)
        RowLayout {
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            spacing: 16

            Button {
                id: suspendButton
                text: "Suspend"
                visible: sddm && sddm.canSuspend
                activeFocusOnTab: visible

                contentItem: Text {
                    text: suspendButton.text
                    font.pixelSize: 13
                    font.family: config.font_family
                    color: suspendButton.hovered ? config.warning_color : config.muted_color
                    verticalAlignment: Text.AlignVCenter
                }
                background: Rectangle { color: "transparent" }
                onClicked: sddm.suspend()
            }

            Button {
                id: rebootButton
                text: "Reboot"
                visible: sddm && sddm.canReboot
                activeFocusOnTab: visible

                contentItem: Text {
                    text: rebootButton.text
                    font.pixelSize: 13
                    font.family: config.font_family
                    color: rebootButton.hovered ? config.error_color : config.muted_color
                    verticalAlignment: Text.AlignVCenter
                }
                background: Rectangle { color: "transparent" }
                onClicked: sddm.reboot()
            }

            Button {
                id: powerButton
                text: "Power Off"
                visible: sddm && sddm.canPowerOff
                activeFocusOnTab: visible

                contentItem: Text {
                    text: powerButton.text
                    font.pixelSize: 13
                    font.family: config.font_family
                    color: powerButton.hovered ? config.error_color : config.muted_color
                    verticalAlignment: Text.AlignVCenter
                }
                background: Rectangle { color: "transparent" }
                onClicked: sddm.powerOff()
            }
        }
    }

    // --- Initialization & Setup ---
    Component.onCompleted: {
        var date = new Date()
        timeLabel.text = Qt.formatTime(date, "HH:mm")
        dateLabel.text = Qt.formatDate(date, "dddd, d MMMM yyyy")
        passwordField.forceActiveFocus()
    }

    // --- Authentication Attempt Helper ---
    function attemptLogin() {
        var username = ""
        if (userModel && userModel.count > 0 && userSelector.visible) {
            username = userModel.get(userSelector.currentIndex).name
        } else {
            username = usernameField.text
        }

        if (username === "" || passwordField.text === "") {
            errorMessage.text = "Username and password cannot be empty"
            errorMessage.visible = true
            errorTimer.restart()
            return
        }

        sddm.login(username, passwordField.text, sessionSelector.currentIndex)
    }
}
