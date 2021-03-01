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
    property var startoflist: 20
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
                    text: qsTr("SNO:")
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
                text:Style.name
            }
        }
        Rectangle {
            id: age
            x: positionx
            y: startoflist + 2 * separation
            color: "transparent"
            width: rectwidth
            height: rectheight

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
                    id: age_text
                    x: 60
                    y: 1
                    text: qsTr("Age:")
                    anchors.rightMargin: 0
                    anchors.bottomMargin: -8
                    anchors.leftMargin: -66
                    anchors.topMargin: 8
                }
            }
            TextField {
                id:age_enter
                anchors.fill: parent
                font.family: textfieldfont
                opacity: 1
                font.pixelSize: 16
                color: "black"
                layer.enabled: true
                text:Style.age
            }
        }
        Rectangle {
            id: dateJoined
            x: positionx
            y: startoflist + 3 * separation
            color: "transparent"
            width: rectwidth
            height: rectheight

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
                    id: dateJoined_text
                    x: 60
                    y: 1
                    text: qsTr("Date Joined:")
                    anchors.rightMargin: 0
                    anchors.bottomMargin: -8
                    anchors.leftMargin: -66
                    anchors.topMargin: 8
                }
            }
            TextField {
                id:date_joined_enter
                anchors.fill: parent
                font.family: textfieldfont
                opacity: 1
                font.pixelSize: 16
                color: "black"
                layer.enabled: true
                text:Style.dateJoined
            }
        }

        Rectangle {
            id: price
            x: positionx
            y: startoflist + 4 * separation
            width: rectwidth
            height: rectheight
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
                    id: price_text
                    x: 60
                    y: 1
                    text: qsTr("Monday:")
                    anchors.rightMargin: 0
                    anchors.bottomMargin: -8
                    anchors.leftMargin: -66
                    anchors.topMargin: 8
                }
            }
            TextField {
                id:monday_enter
                anchors.fill: parent
                font.family: textfieldfont
                opacity: 1
                font.pixelSize: 16
                color: "black"
                layer.enabled: true
                text:Style.monday
            }
        }

        Rectangle {
            id: description
            x: positionx
            y: startoflist + 5 * separation
            width: rectwidth
            height: rectheight
            color: "transparent"

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
                    id: description_text
                    x: 60
                    y: 1
                    text: qsTr("Tuesday:")
                    anchors.rightMargin: 0
                    anchors.bottomMargin: -8
                    anchors.leftMargin: -66
                    anchors.topMargin: 8
                }
            }
            TextField {
                id:tuesday_enter
                anchors.fill: parent
                font.family: textfieldfont
                opacity: 1
                font.pixelSize: 16
                color: "black"
                layer.enabled: true
                text:Style.tuesday
            }}

        Rectangle {
            //maybe combo box//
            id: location
            x: positionx
            y: startoflist + 6 * separation
            width: 500
            height: 54

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
                    id: location_text
                    x: 60
                    y: 1
                    text: qsTr("Wednesday:")
                    anchors.rightMargin: 0
                    anchors.bottomMargin: -8
                    anchors.leftMargin: -66
                    anchors.topMargin: 8
                }
            }
            TextField {
                id:wednesday_enter
                anchors.fill: parent
                font.family: textfieldfont
                opacity: 1
                font.pixelSize: 16
                color: "black"
                layer.enabled: true
                text:Style.wednesday
            }
        }

        Rectangle {
            id: quantity
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
                    id: quantity_text
                    x: 60
                    y: 1
                    text: qsTr("Thursday:")
                    anchors.rightMargin: 0
                    anchors.bottomMargin: -8
                    anchors.leftMargin: -66
                    anchors.topMargin: 8
                }
            }

            TextField {
                id:thursday_enter
                anchors.fill: parent
                font.family: textfieldfont
                opacity: 1
                font.pixelSize: 16
                color: "black"
                layer.enabled: true
                text:Style.thursday
            }
        }

        Rectangle {
            id: date_of_birth_rec
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
                id: date_of_birth
                x: 60
                y: 1
                text: qsTr("Friday:")
                anchors.rightMargin: 0
                anchors.bottomMargin: -8
                anchors.leftMargin: -66
                anchors.topMargin: 8
            }}


        TextField {
            id: friday_enter
            anchors.fill: parent
            font.family: textfieldfont
            opacity: 1
            font.pixelSize: 16
            color: "black"
            layer.enabled: true
            text:Style.friday
        }
    }
        Rectangle {
            id: working_since_rec
            x: positionx
            y: startoflist + 9* separation
            width: 500
            height: 60
        Rectangle
        {
            id:test10
            x: textx
            y: texty
            color:"transparent"
            width: 110
            height:25

            Text {
                anchors.right: test10.right
                font.family: fontform
                font.pixelSize: fontsizes
                font.bold: true
                id: working_since
                x: 60
                y: 1
                text: qsTr("Saturday:")
                anchors.rightMargin: 0
                anchors.bottomMargin: -8
                anchors.leftMargin: -66
                anchors.topMargin: 8
            }
        }

        TextField {
            id: saturday_enter
            anchors.fill: parent
            font.family: textfieldfont
            opacity: 1
            font.pixelSize: 16
            color: "black"
            layer.enabled: true
            text:Style.saturday
        }
    }
        Rectangle {
            id: sundayrec
            x: positionx
            y: startoflist + 10* separation
            width: 500
            height: 60
        Rectangle
        {
            id:test11
            x: textx
            y: texty
            color:"transparent"
            width: 110
            height:25

            Text {
                anchors.right: test11.right
                font.family: fontform
                font.pixelSize: fontsizes
                font.bold: true
                id: sunday
                x: 60
                y: 1
                text: qsTr("Sunday:")
                anchors.rightMargin: 0
                anchors.bottomMargin: -8
                anchors.leftMargin: -66
                anchors.topMargin: 8
            }
        }

        TextField {
            id: sunday_enter
            anchors.fill: parent
            font.family: textfieldfont
            opacity: 1
            font.pixelSize: 16
            color: "black"
            layer.enabled: true
            text:Style.sunday
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
                font.pointSize: 19

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
                    sd.updateData(sno_enter.text, name_enter.text, age_enter.text, date_joined_enter.text, monday_enter.text, tuesday_enter.text, wednesday_enter.text, thursday_enter.text, friday_enter.text, saturday_enter.text, sunday_enter.text)
                    console.log(name_enter.text);
                    console.log(tuesday_enter.text);
                    setQMLSources("owner_staffinfo.qml")
                }
            }
        }


    }

}
