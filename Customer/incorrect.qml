import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import "."

Window {
    id: rootWindow
    visible: true
    width: 1366
    height: 768
    signal setQMLSource(string path)
    //Material.accent: "#000000"
    property int previousX
    property int previousY
    property string wrap: "Text.WordWrap"
    flags: Qt.Window | Qt.FramelessWindowHint

    Rectangle {
        width: 1366
        height: 768
        x: 0
        y: 0

        Connections {
            target: insideDashboard.item
            onSetQMLSource: {
                insideDashboard.source = ""
                insideDashboard.source = path
            }
        }


Item {
    width: 1116
    height: 718


    Image {
        id: background
        source: "UI/login/nathalia-rosa-rwmibqmoxry-unsplash.png"
        x: 0
        y: 0
        opacity: 1
    }
    Image {
        id: bg
        source: "UI/login/bg.png"
        x: 0
        y: 0
        width: 1368
        height: 768
        opacity: 0.76862745098039

        Rectangle {
            id: login_but
            x: 1151
            y: 545
            width: 200
            height: 200
            color: "#ffffff"

            MouseArea
            {
                anchors.fill:parent
                onClicked:
                {
                    Style.name = name_enter.text

                    Style.password = password_enter.text
                    if (ed.authentication(Style.name, Style.password) === 0)
                    {
                        insideDashboard.source = "incorrect.qml"
                    }
                    else
                    {
                        insideDashboard.source = "main.qml"
                    }
                    rootWindow.hide();
                }
            }
        }
    }
    Image {
        id: blackrectangle
        source: "UI/login/blackrectangle.png"
        x: 273
        y: 118
        opacity: 0.78823529411765

        Rectangle {
            id: name_ente_rect
            x: 64
            y: 273
            width: 708
            height: 84
            color: "white"

            Rectangle {
                id: name_icon
                x: 0
                y: 0
                width: 94
                height: 84
                color: "#ffffff"
            }

            TextField {
                id: name_enter
                x: 100
                y: 8
                width: 600
                height: 68
                font.pixelSize: 32
                placeholderText: ("Name")
            }
        }

        Rectangle {
            id: password_section
            x: 64
            y: 363
            width: 708
            height: 82
            color: "white"

            TextField {
                id: password_enter
                x: 100
                y: 8
                width: 600
                height: 68
                font.pixelSize: 32
                placeholderText: ("Password")
            }
        }

        Rectangle {
            id: password_icon
            x: 64
            y: 363
            width: 95
            height: 82
            color: "white"
        }
    }
    Image {
        id: circlewithicon
        source: "UI/login/circlewithicon.png"
        x: 575
        y: 131
        opacity: 0.87843137254902
    }
    Image {
        id: icon
        source: "UI/login/icon.png"
        x: 611
        y: 171
        opacity: 1
    }
    Image {
        id: topbar
        source: "UI/login/topbar.png"
        x: 0
        y: 0
        opacity: 0.10980392156863

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
    Loader {
        id: insideDashboard
        x: 250
        y: 50
        width: 1116
        height: 718
        //source:"main.qml"
    }
}
