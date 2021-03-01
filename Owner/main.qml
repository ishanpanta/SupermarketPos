import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import "."

Window {
    id: rootWindow
    visible: true
    width: 1366
    height: 768
    Material.accent: "#adb5bd"
    property int previousX
    property int previousY
    property string wrap: "Text.WordWrap"
    flags: Qt.Window | Qt.FramelessWindowHint
    property var locale: Qt.locale()
    property date today: new Date()
    property var hr
    property var mate
    property var sec
    property var day
    property var month
    property var year
    property string d
    property string m
    property string yr
    property string h
    property string mi
    property string s
    property string hover: "UI/employee/hover_rect.png"
    property string nonhover: "UI/employee/non_hover.png"
    property string fontcolor_billing:"white"

    Rectangle {
        width: 1366
        height: 768
        x: 0
        y: 0

        Loader {
            x: 0
            y: 41
            width: 1366
            height: 727
            id: container
            source: "login.qml"
        }
        Connections{
            target: container.item
            onSetQML: {
                container.source = ""
                container.source = path
            }
        }

        Item {
            width: 1366
            height: 768

            Rectangle {
                id: topbar
                //source: "UI/login/topbar.png"
                x: 0
                y: 0
                height:41
                width: 1366
                color:"#282931"

                MouseArea {
                    id: drag_mArea
                    anchors.fill: parent
                    onPressed: {
                        previousX = mouseX
                        previousY = mouseY
                    }

                    onMouseXChanged: {
                        var dx = mouseX - previousX
                        rootWindow.setX(rootWindow.x + dx)
                    }

                    onMouseYChanged: {
                        var dy = mouseY - previousY
                        rootWindow.setY(rootWindow.y + dy)
                    }
                }
            }
            Image {
                id: close
                source: "UI/login/close.png"
                x: 1322
                y: 0
                opacity: 1

                MouseArea {
                    id: closeMArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onEntered: {
                        parent.source = "UI/login/close_hover.png"
                    }
                    onExited: {
                        parent.source = "UI/login/close.png"
                    }
                    onClicked: {
                        Qt.quit()
                    }
                }
            }



            Image {
                id: minimize
                source: "UI/login/minimize.png"
                x: 1276
                y: 0
                opacity: 1

                MouseArea {
                    id: minMArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onEntered: {
                        parent.source = "UI/login/minimize_hover.png"
                    }
                    onExited: {
                        parent.source = "UI/login/minimize.png"
                    }
                    onClicked: {
                        showMinimized()
                    }
                }
            }
        }
    }


    /*##^##
Designer {
    D{i:0;formeditorZoom:0.6600000262260437}
}
##^##*/
}
