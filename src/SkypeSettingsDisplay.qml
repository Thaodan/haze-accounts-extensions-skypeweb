import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Accounts 1.0
import com.jolla.settings.accounts 1.0

Column {
    id: root

    property bool autoEnableAccount
    property Provider accountProvider
    property int accountId
    property alias acceptableInput: settings.acceptableInput

    property string _defaultServiceName: "skypweb"
    property bool _saving

    signal accountSaveCompleted(var success)

    function saveAccount(blockingSave) {
        account.enabled = mainAccountSettings.accountEnabled
        account.displayName = mainAccountSettings.accountDisplayName
        account.enableWithService(_defaultServiceName)
        _saveServiceSettings(blockingSave)
    }

    function _populateServiceSettings() {
        var serviceSettings = account.configurationValues(_defaultServiceName)
        settings.username = account.configurationValues("")["default_credentials_username"]
    }

    function _saveServiceSettings(blockingSave) {
        account.setConfigurationValue("", "default_credentials_username", settings.username)
        // param-account is required by Telepathy; it's generated from credentials on creation, but
        // needs to be updated manually
        account.setConfigurationValue(_defaultServiceName, "telepathy/param-account", settings.username)

        _saving = true
        if (blockingSave) {
            account.blockingSync()
        } else {
            account.sync()
        }
    }

    width: parent.width
    spacing: Theme.paddingLarge

    AccountMainSettingsDisplay {
        id: mainAccountSettings
        accountProvider: root.accountProvider
        accountUserName: account.defaultCredentialsUserName
        accountDisplayName: account.displayName
    }

    SkypeCommon {
        id: settings
        enabled: mainAccountSettings.accountEnabled
        opacity: enabled ? 1 : 0
        editMode: true

        Behavior on opacity { FadeAnimation { } }
    }

    Account {
        id: account

        identifier: root.accountId
        property bool needToUpdate

        onStatusChanged: {
            if (status === Account.Initialized) {
                mainAccountSettings.accountEnabled = root.autoEnableAccount || account.enabled
                if (root.autoEnableAccount) {
                    enableWithService(_defaultServiceName)
                }
                root._populateServiceSettings()
            } else if (status === Account.Error) {
                // display "error" dialog
            } else if (status === Account.Invalid) {
                // successfully deleted
            }
            if (root._saving && status != Account.SyncInProgress) {
                root._saving = false
                root.accountSaveCompleted(status == Account.Synced)
            }
        }
    }
}
