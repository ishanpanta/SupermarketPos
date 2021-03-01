import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import "."

Item {
    Connections {
        target: insideDashboard.item
        onSetQMLSources: {
            insideDashboard.source = ""
            insideDashboard.source = path
        }
    }

    id: rootWindow
    visible: true
    width: 1366
    height: 727
    signal setQMLSource(string path)
    Material.accent: "#000000"
    //flags: Qt.Window | Qt.FramelessWindowHint
    Rectangle {
        width: 1366
        height: 727
        x: 0
        y: 0
        Loader {
            id: insideDashboard
            x: 240
            y: 0
            width: 1126
            height: 727
            source: "employee_dash.qml"
        }
        Connections {
            target: insideDashboard.item
            onSetQMLSource: {
                insideDashboard.source = ""
                insideDashboard.source = path
            }
        }
        Item {
            id: sidebarContainer
            Image {
                id: sidebar
                source: "UI/employee/sidebar.png"
                x: 0
                y: 0
                width: 240
                height: 727
                opacity: 1
            }
        }
        Image {
            id: shift_rect
            source: nonhover
            x: -3
            y: 440
            opacity: 1

            MouseArea {
                id: shiftbutton
                cursorShape: Qt.PointingHandCursor
                anchors.fill: parent
                onClicked: {
                    insideDashboard.source = "employee_shift.qml"
                    shift_rect.source = hover
                    billing_rect.source = nonhover
                    inventory_rect.source = nonhover
                }
            }
        }
        Image {
            id: shift_data
            source: "UI/employee/shift_data.png"
            x: 63
            y: 453
            opacity: 1
        }
        Image {
            id: shifticon
            source: "UI/employee/shifticon.png"
            x: 16
            y: 448
            opacity: 1
        }
        Image {
            id: billing_rect
            source: nonhover
            x: -3
            y: 385
            opacity: 1
            MouseArea {
                id: billingbutton
                cursorShape: Qt.PointingHandCursor
                anchors.fill: parent
                onClicked: {
                    insideDashboard.source = "employee_billing.qml"
                    shift_rect.source = nonhover
                    billing_rect.source = hover
                    inventory_rect.source = nonhover
                }
            }
        }
        Image {
            id: billing
            source: "UI/employee/billing.png"
            x: 65
            y: 402
            opacity: 1
        }
        Image {
            id: billingicon
            source: "UI/employee/billing-icon.png"
            x: 19
            y: 393
            opacity: 1
        }
        Image {
            id: inventory_rect
            source: hover
            x: -3
            y: 327
            opacity: 1
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    shift_rect.source = nonhover
                    billing_rect.source = nonhover
                    inventory_rect.source = hover
                    insideDashboard.source = "employee_dash.qml"
                }
            }
        }
        Image {
            id: inventory_icon
            source: "UI/employee/inventory_icon.png"
            x: 15
            y: 337
            opacity: 1
        }
        Image {
            id: inventory
            source: "UI/employee/inventory.png"
            x: 66
            y: 344
            opacity: 1
        }
        Image {
            id: logorect
            source: "UI/employee/logorect.png"
            x: 0
            y: 1
            width: 239
            height: 100
            opacity: 1
        }
        Image {
            id: usericon
            source: "UI/employee/usericon.png"
            x: 24
            y: 125
            opacity: 1
        }
        Text {
            id: name
            x: 74
            y: 135
            width: 160
            height: 34
            opacity: 1
            font.bold: true
            text: Style.name
            font.pixelSize: 20

            color: "white"
        }
        Image {
            id: logo
            source: "UI/employee/logo.png"
            x: 35
            y: 20
            opacity: 1
        }
    }
    /*Time*/
    Item {
        x: 85
        y: 648
        Timer {
            interval: 1
            running: true
            repeat: true
            onTriggered: {
                //sec = new Date().getSeconds()
                mate = new Date().getMinutes()
                hr = new Date().getHours()
                mi = mate.toString()
                h = hr.toString()

                if (mi.length < 2) {
                    mi = '0' + mi
                }
                if (h.length < 2) {
                    h = '0' + h
                }

                time.text = h + ':' + mi // + ':' + sec.toString()
            }
        }

        Text {
            anchors.fill: parent
            id: time
            opacity: 1
            font.pixelSize: Style.dtfontsize
            font.bold: true
            color: "white"
        }
    }
    Image
    {
        x: 76
        y: 544
        source:"UI/login/logout.png"

        MouseArea
        {
            width: 26
            height: 35
            cursorShape: Qt.PointingHandCursor
            onClicked:
            {
                container.source = "login.qml"
            }
        }
    }

    /*Date*/
    Item {
        x: 55
        y: 694

        Timer {
            interval: 1
            running: true
            repeat: true
            onTriggered: {
                interval: 1
                running: true
                repeat: true

                day = new Date().getDate()
                month = new Date().getMonth() + 1
                year = new Date().getFullYear()
                d = day.toString()
                m = month.toString()
                yr = year.toString()
                if (d.length < 2) {
                    d = '0' + d
                }
                if (m.length < 2) {
                    m = '0' + m
                }

                date.text = d + '/' + m + '/' + yr
            }
        }

        Text {
            id: date
            anchors.fill: parent
            opacity: 1
            font.pixelSize: Style.dtfontsize
            font.bold: true
            color: "white"
        }
    }


}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.6600000262260437}
}
##^##*/
