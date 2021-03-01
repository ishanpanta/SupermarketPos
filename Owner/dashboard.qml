import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import "."


Item {
    id: rootWindow
    visible: true
    width: 1366
    height: 727
     signal setQML(string path)

        x: 0
        y: 0
        Connections {
            target: insideDashboard.item
            onSetQMLSources: {
                insideDashboard.source = ""
                insideDashboard.source = path
            }
        }
        Item {
            id: sidebarContainer
            Image {
                id: sidebar
                source: "UI/owner/sidebar.png"
                x: 0
                y: 0
                opacity: 1
            }
        }
        Image {
            id: monthly_rect
            source: nonhover
            x: -3
            y: 385
            opacity: 1

            MouseArea {
                id: monthly_button
                cursorShape: Qt.PointingHandCursor
                        anchors.fill: parent
                        onClicked: {
                            insideDashboard.source = "owner_monthly.qml"
                            monthly_rect.source = hover
                            //billing_rect.source = nonhover
                            inventory_rect.source = nonhover
                            staff_rect.source = nonhover
                        }
            }
        }
        Image {
            id: monthly_text
            source: "UI/owner/monthly_report_.png"
            x: 65
            y: 402
            opacity: 1
        }
        Image {
            id: monthly
            source: "UI/owner/monthly.png"
            x: 19
            y: 393
            opacity: 1
        }

        Image {
            id: staff_rect
            source: nonhover
            x: -3
            y: 440
            opacity: 1
            MouseArea {
                id: staff_button
                cursorShape: Qt.PointingHandCursor
                        anchors.fill: parent
                        onClicked: {
                            insideDashboard.source = "owner_staffinfo.qml"
                            monthly_rect.source = nonhover
                            //billing_rect.source = nonhover
                            inventory_rect.source = nonhover
                            staff_rect.source = hover
                        }
            }
        }
        Image {
            id: stafficon
            source: "UI/owner/staff.png"
            x: 19
            y: 448
            opacity: 1
        }

        Image {
            id: staff_text
            source: "UI/owner/staff_info.png"
            x: 63
            y: 453
            opacity: 1
        }
        Image {
            id: inventory_rect
            source: hover
            x: -3
            y: 327
            opacity: 1
            MouseArea{
                anchors.fill:parent
                cursorShape: Qt.PointingHandCursor
               onClicked: {
                    monthly_rect.source = nonhover
                    //billing_rect.source = nonhover
                    inventory_rect.source = hover
                    staff_rect.source = nonhover
                    insideDashboard.source = "owner_dash.qml"
                }
            }
        }
        Image {
            id: inventory_icon
            source: "UI/owner/inventory_icon.png"
            x: 15
            y: 337
            opacity: 1
        }
        Image {
            id: inventory
            source: "UI/owner/inventory.png"
            x: 66
            y: 344
            opacity: 1
        }
        Image {
            id: logorect
            source: "UI/owner/logorect.png"
            x: 0
            y: 0
            opacity: 1
        }
        Image {
            id: usericon
            source: "UI/owner/usericon.png"
            x: 10
            y: 123
            opacity: 1
        }
        Text {
            id: name

            x: 67
            y: 125
            opacity: 1
            font.bold: true
            text: Style.name
            font.pixelSize: 32


            color:"white"

        }
        Image {
            id: logo
            source: "UI/owner/logo.png"
            x: 35
            y: 20
            opacity: 1
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
                    mi = mate.toString();
                    h = hr.toString();

                    if(mi.length < 2)
                    {
                        mi = '0'+mi
                    }
                    if (h.length < 2)
                    {
                        h = '0'+h
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

        Loader {
            id: insideDashboard
            x: 250
            y: 0
            width: 1116
            height: 727
            source: "owner_dash.qml"
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
    }

