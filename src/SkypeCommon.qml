import QtQuick 2.0
import Sailfish.Silica 1.0
import com.jolla.settings.accounts 1.0

Column {
    property bool editMode
    property bool usernameEdited
    property bool passwordEdited
    property bool acceptAttempted
    property alias username: usernameField.text
    property alias password: passwordField.text
    property bool acceptableInput: username != "" && password != ""

    spacing: Theme.paddingLarge
    width: parent.width

    TextField {
        id: usernameField
        width: parent.width
        inputMethodHints: Qt.ImhDigitsOnly
        errorHighlight: !text && acceptAttempted

        //: Placeholder text for XMPP username
        //% "Enter username"
        placeholderText: qsTrId("components_accounts-ph-jabber_username_placeholder")
        //: XMPP username
        //% "Username"
        label: qsTrId("components_accounts-la-jabber_username")
        onTextChanged: {
            if (focus) {
                usernameEdited = true
                // Updating username also updates password; clear it if it's default value
                if (!passwordEdited)
                    passwordField.text = ""
            }
        }
        EnterKey.iconSource: "image://theme/icon-m-enter-next"
        EnterKey.onClicked: passwordField.focus = true
    }

    TextField {
        id: passwordField
        width: parent.width
        inputMethodHints: Qt.ImhNoPredictiveText | Qt.ImhNoAutoUppercase
        echoMode: TextInput.Password
        errorHighlight: !text && acceptAttempted

        //: Placeholder text for password
        //% "Enter password"
        placeholderText: qsTrId("components_accounts-ph-jabber_password_placeholder")
        //: XMPP password
        //% "Password"
        label: qsTrId("components_accounts-la-jabber_password")
        onTextChanged: {
            if (focus && !passwordEdited) {
                passwordEdited = true
            }
        }
        EnterKey.iconSource: "image://theme/icon-m-enter-next"
        EnterKey.onClicked: focus = false
    }
}
