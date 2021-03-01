import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import "."

Item {
    visible: true
    width: 1366
    height: 727
    signal setQML(string path)
    Image {
        id: background
        source: "UI/login/nathalia-rosa-rwmibqmoxry-unsplash.png"
        x: 0
        y: 0
        width: 1368
        height: 727
        opacity: 1
    }

    Image {
        id: bg
        source: "UI/login/bg.png"
        x: 0
        y: 0
        width: 1368
        height: 727
        opacity: 0.76862745098039
    }

    Rectangle {
        id: blackrect
        x: 271
        y: 120
        width: 829
        height: 519
        color: "#000000"
        opacity: 0.78823529411765

        Image {
            id: circlewithicon
            x: 307
            y: 33
            source: "UI/login/circlewithicon.png"

            Image {
                id: icon
                width: 152
                height: 152
                source: "UI/login/icon.png"
                anchors.centerIn: parent

            }
        }
    }

    Rectangle {
        id: password_section
        x: 431
        y: 492
        width: 506
        height: 50
        color: "#cfd3de"

        TextField {
            id: password_enter
            x: 8
            y: 0
            echoMode: "Password"
            width: 475
            height: 50
            font.pixelSize: 16
            //color:"#F8F4E3"
            placeholderText: ("Password")
        }
    }
    Rectangle {
        id: name_ente_rect
        x: 431
        y: 414
        width: 506
        height: 50
        color: "#cfd3de"

        TextField {
            id: name_enter
            x: 8
            y: 0
            width: 475
            height: 50
            font.pixelSize: 16
            placeholderText: ("Name")
            //color: "#F8F4E3"
        }


    }
    Text {
        id: incorrect_
        x: 596
        y: 377
        color:"red"
        font.pixelSize: 20
        text: qsTr("Incorrect, Try again")
        visible: false
    }
    Rectangle {
        id: login_but
        x: 583
        y: 566
        width: 200
        height: 50
        color: "#1DB954"
        radius: 16

        Text {
            id: submit_text
            anchors.centerIn: parent
            //width: 200
            // height: 78
            //x:63
            //y:8
            font.pixelSize: 20
            color: "#F8F4E3"
            text: qsTr("Login")
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                Style.name = name_enter.text
                Style.password = password_enter.text
                if (od.authentication(Style.name, Style.password) === 0) {
                    incorrect_.visible = true
                } else {

                    setQML("dashboard.qml")
                    incorrect_.visible = false
                }
            }
        }
    }
}
