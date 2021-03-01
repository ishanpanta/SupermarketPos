
import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import "."

Item {
    width: 1116
    height: 718
    signal setQMLSources(string path)
    property string fontform: "Roboto"
    property string textfieldfont: "Ubuntu"
    property var fontsizes: 20
    property var startoflist: 100
    property var rectwidth: 500
    property var rectheight: 50
    property var positionx: 250
    property var separation: 60
    property var textx: -125
    property var texty: 15

    Image {
        id: center_box
        source: "UI/owner/center_box.png"
        x: -3
        y: 0
        width: 1119
        height: 718
        opacity: 1

        Rectangle {
            id: id
            x: positionx
            y: startoflist
            color: "transparent"
            width: rectwidth
            height: rectheight
            Rectangle
            {
                id:test
                x: textx
                y: texty
                color:"transparent"
                width: 110
                height:25

                Text {
                    anchors.right: test.right
                    font.family: fontform
                    font.pixelSize: fontsizes
                    font.bold: true
                    id: id_text
                    x: 60
                    y: 1
                    text: qsTr("ID:")
                    anchors.rightMargin: 0
                    anchors.bottomMargin: -8
                    anchors.leftMargin: -66
                    anchors.topMargin: 8
                }
            }


            TextField {
                id:sno_enter
                anchors.fill: parent
                x: 50
                y: 20
                font.family: textfieldfont
                opacity: 1
                font.pixelSize: 16
                color: "black"
                anchors.rightMargin: 0
                anchors.bottomMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0
                layer.enabled: true
                text:Style.sno
            }
        }
        Rectangle {
            id: name
            x: positionx
            y: startoflist + 1 * separation
            color: "transparent"
            width: rectwidth
            height: rectheight

            Rectangle
            {
                id:test2
                x: textx
                y: texty
                color:"transparent"
                width: 110
                height:25

                Text {
                    anchors.right: test2.right
                    font.family: fontform
                    font.pixelSize: fontsizes
                    font.bold: true
                    id: name_text
                    x: 60
                    y: 1
                    text: qsTr("Name:")
                    anchors.rightMargin: 0
                    anchors.bottomMargin: -8
                    anchors.leftMargin: -66
                    anchors.topMargin: 8
                }
            }
            TextField {
                id:name_enter
                anchors.fill: parent
                font.family: textfieldfont
                opacity: 1
                font.pixelSize: 16
                color: "black"
                layer.enabled: true
                text: Style.name
            }
        }

        Rectangle {
            id: email
            x: positionx
            y: startoflist + 2 * separation
            width: rectwidth
            height: rectheight
            color: "transparent"

            Rectangle
            {
                id:test3
                x: textx
                y: texty
                color:"transparent"
                width: 110
                height:25

                Text {
                    anchors.right: test3.right
                    font.family: fontform
                    font.pixelSize: fontsizes
                    font.bold: true
                    id: price_text
                    x: 60
                    y: 1
                    text: qsTr("Email:")
                    anchors.rightMargin: 0
                    anchors.bottomMargin: -8
                    anchors.leftMargin: -66
                    anchors.topMargin: 8
                }
            }
            TextField {
                id:email_enter
                anchors.fill: parent
                font.family: textfieldfont
                opacity: 1
                font.pixelSize: 16
                color: "black"
                layer.enabled: true
                text: Style.email
            }
        }

        Rectangle {
            id: password
            x: positionx
            y: startoflist + 3 * separation
            width: rectwidth
            height: rectheight
            color: "transparent"

            Rectangle
            {
                id:test4
                x: textx
                y: texty
                color:"transparent"
                width: 110
                height:25

                Text {
                    anchors.right: test4.right
                    font.family: fontform
                    font.pixelSize: fontsizes
                    font.bold: true
                    id: description_text
                    x: 60
                    y: 1
                    text: qsTr("Password:")
                    anchors.rightMargin: 0
                    anchors.bottomMargin: -8
                    anchors.leftMargin: -66
                    anchors.topMargin: 8
                }
            }
            TextField {
                id:password_enter
                anchors.fill: parent
                font.family: textfieldfont
                opacity: 1
                font.pixelSize: 16
                color: "black"
                layer.enabled: true
                text: Style.password
            }
        }


        Rectangle {
            id: gender
            x: positionx
            y: startoflist + 4 * separation
            width: 500
            height: 54
            color: "transparent"

            Rectangle
            {
                id:test5
                x: textx
                y: texty
                color:"transparent"
                width: 110
                height:25

                Text {
                    anchors.right: test5.right
                    font.family: fontform
                    font.pixelSize: fontsizes
                    font.bold: true
                    id: itemtype_text
                    x: 60
                    y: 1
                    text: qsTr("Gender:")
                    anchors.rightMargin: 0
                    anchors.bottomMargin: -8
                    anchors.leftMargin: -66
                    anchors.topMargin: 8
                }
            }

            ComboBox {
                id: gender_enter
                anchors.fill:parent
                model: ['M', 'F', 'O']
            }
        }

        Rectangle {
            id: location
            x: positionx
            y: startoflist + 5 * separation
            width: 500
            height: 54

            Rectangle
            {
                id:test6
                x: textx
                y: texty
                color:"transparent"
                width: 110
                height:25

                Text {
                    anchors.right: test6.right
                    font.family: fontform
                    font.pixelSize: fontsizes
                    font.bold: true
                    id: location_text
                    x: 60
                    y: 1
                    text: qsTr("Contact_number:")
                    anchors.rightMargin: 0
                    anchors.bottomMargin: -8
                    anchors.leftMargin: -66
                    anchors.topMargin: 8
                }
            }
            TextField {
                id:contact_number_enter
                anchors.fill: parent
                font.family: textfieldfont
                opacity: 1
                font.pixelSize: 16
                color: "black"
                layer.enabled: true
                text: Style.contact_number
            }
        }

        Rectangle {
            id: address
            x: positionx
            y: startoflist + 6 * separation
            width: 500
            height: 60

            Rectangle
            {
                id:test7
                x: textx
                y: texty
                color:"transparent"
                width: 110
                height:25

                Text {
                    anchors.right: test7.right
                    font.family: fontform
                    font.pixelSize: fontsizes
                    font.bold: true
                    id: quantity_text
                    x: 60
                    y: 1
                    text: qsTr("Address:")
                    anchors.rightMargin: 0
                    anchors.bottomMargin: -8
                    anchors.leftMargin: -66
                    anchors.topMargin: 8
                }
            }

            TextField {
                id:address_enter
                anchors.fill: parent
                font.family: textfieldfont
                opacity: 1
                font.pixelSize: 16
                color: "black"
                layer.enabled: true
                text: Style.address
            }
        }

        Rectangle {
            id: date_of_birth
            x: positionx
            y: startoflist + 7 * separation
            width: 500
            height: 60

            Rectangle
            {
                id:test8
                x: textx
                y: texty
                color:"transparent"
                width: 110
                height:25

                Text {
                    anchors.right: test8.right
                    font.family: fontform
                    font.pixelSize: fontsizes
                    font.bold: true
                    id: date_of_birth_text
                    x: 60
                    y: 1
                    text: qsTr("Date Of Birth:")
                    anchors.rightMargin: 0
                    anchors.bottomMargin: -8
                    anchors.leftMargin: -66
                    anchors.topMargin: 8
                }
            }

            TextField {
                id:date_of_birth_enter
                anchors.fill: parent
                font.family: textfieldfont
                opacity: 1
                font.pixelSize: 16
                color: "black"
                layer.enabled: true
                text: Style.date_of_birth
            }
        }
        Rectangle {
            id: working_since
            x: positionx
            y: startoflist + 8 * separation
            width: 500
            height: 60

            Rectangle
            {
                id:test9
                x: textx
                y: texty
                color:"transparent"
                width: 110
                height:25

                Text {
                    anchors.right: test9.right
                    font.family: fontform
                    font.pixelSize: fontsizes
                    font.bold: true
                    id: working_since_text
                    x: 60
                    y: 1
                    text: qsTr("Working Since:")
                    anchors.rightMargin: 0
                    anchors.bottomMargin: -8
                    anchors.leftMargin: -66
                    anchors.topMargin: 8
                }
            }

            TextField {
                id:working_since_enter
                anchors.fill: parent
                font.family: textfieldfont
                opacity: 1
                font.pixelSize: 16
                color: "black"
                layer.enabled: true
                text: Style.working_since
            }
        }

        Rectangle {
            id: submit
            x: 866
            y: 624
            width: 200
            height: 61
            color: "green"
            radius: 15

            Text {
                anchors.centerIn: parent
                id: sumbitbut
                text: qsTr("Submit")
                font.pixelSize: 25
            }
            MouseArea{
                anchors.rightMargin: 0
                anchors.bottomMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked:
                {
                    ed.updateData(sno_enter.text, name_enter.text, email_enter.text,password_enter.text, gender_enter.currentText,contact_number_enter.text, address_enter.text, date_of_birth_enter.text, working_since_enter.text)
                    setQMLSources("owner_staffinfo.qml")
                }
            }
        }

    }
}

