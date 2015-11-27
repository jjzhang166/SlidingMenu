import QtQuick 2.4
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Window {
    visible: true
    width: 320
    height: 480
    property bool menu_shown: false

     /* this rectangle contains the "menu" */
    Rectangle {
        id: menu_view
        anchors.fill: parent
        color: "#F0F1F6";
        opacity: menu_shown ? 1 : 0

        Behavior on opacity { NumberAnimation { duration: 300 } }
    }

    /* this rectangle contains the "normal" view in your app */
    Rectangle {
        id: normal_view
        anchors.fill: parent
        color: "#50709B"

        /* quick and dirty menu "button" for this demo (TODO: replace with your own) */
        ToolBar {
            id: toolBar
            property var inline: ToolBar {
                id: i
                visible: false
            }
            style: ToolBarStyle {
                background: Rectangle {
                    color: "#FAFAFA"
                    implicitWidth: i.width * 0.9
                    implicitHeight: i.height * 0.9
                }
            }

            Button {
                width: parent.height
                height: parent.height
                text: "Menu"

                onClicked: onMenu();
            }
        }

        /* this is what moves the normal view aside */
        transform: Translate {
            id: menu_translate
            x: 0
            Behavior on x { NumberAnimation { duration: 400; easing.type: Easing.OutQuad } }
        }

        /* put this last to "steal" touch on the normal window when menu is shown */
        MouseArea {
            anchors.fill: parent
            enabled: menu_shown

            onClicked: onMenu();
        }

        /* this is the menu shadow */
        BorderImage {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.margins: -4
            z: -1 /* this will place it below normal_view */
            visible: menu_shown
            source: "qrc:///res/shadow.png"
            border { left: 4; top: 4; right: 4; bottom: 4 }
        }
    }

    /* this functions toggles the menu and starts the animation */
    function onMenu()
    {
        menu_translate.x = menu_shown ? 0 : width * 0.9
        menu_shown = !menu_shown;
    }
}
