import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import "."

//make the thing so that it gives the value of the employee name and only that//
Item {
    width: 1116
    height: 718
    property var startofheader: 50
    property var heightoftext: 10
    property string headercolor: "white"
    signal setQMLSources(string path)
    property var separation: 100
    property var fontsize: 22
    property var startoftext:50
    property var t_separation:150


    Image {
        id: center_box
        source: "UI/employee/center_box.png"
        x: -3
        y: 0
        width: 1119
        height: 718
        opacity: 1



        Rectangle {
            id: name
            x: 303
            y: 38
            width: 605
            height: 46
            color: "#BEBEBE"
            Text {
                anchors.fill: parent
                id: name_text
                text: qsTr("Name:")
                anchors.rightMargin: 135
                anchors.bottomMargin: 0
                anchors.leftMargin: 8
                anchors.topMargin: 0
                font.pointSize: 14
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
            }
        }

        Rectangle {
            id: age
            x: 303
            y: 104
            width: 605
            height: 46
            color: "#BEBEBE"
            Text {
                anchors.fill: parent
                id: age_text
                width: 597
                text: qsTr("Age:")
                anchors.rightMargin: 132
                anchors.bottomMargin: 0
                anchors.leftMargin: 8
                anchors.topMargin: 0
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 14
            }
        }

        Rectangle {
            id: start_date
            x: 303
            y: 178
            width: 605
            height: 46
            color: "#BEBEBE"
            Text {
                anchors.fill: parent
                id: start_text
                text: qsTr("Date Joined:")
                anchors.rightMargin: 275
                anchors.bottomMargin: 0
                anchors.leftMargin: 8
                anchors.topMargin: 0
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 14
            }
        }


        Rectangle {
            id: header
            x: 0
            y: 307
            width: 1119
            height: 42
            color: "#2d3142"
            opacity: 1
        }

        Item {
            id: doesitmatter
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
            anchors.fill: header
            Text {
                x: startofheader
                y: heightoftext
                id: monday
                text: "MONDAY"
                font.pointSize: 11
                color: headercolor
            }
            Text {
                x: startofheader + 1.5 * separation
                y: heightoftext
                id: tuesday
                text: "TUESDAY"
                color: headercolor
                font.pointSize: 11
            }
            Text {
                x: startofheader + 2.8 * separation
                y: heightoftext
                id: wednesday
                text: "WEDNESDAY"
                color: headercolor
                font.pointSize: 11
            }
            Text {
                x: startofheader + 4.5 * separation
                y: heightoftext
                id: thurday
                text: "THURSDAY"
                color: headercolor
                font.pointSize: 11
            }
            Text {
                x: startofheader + 6.2 * separation
                y: heightoftext
                id: friday
                text: "FRIDAY"
                color: headercolor
                font.pointSize: 11
            }
            Text {
                x: startofheader + 7.5 * separation
                y: heightoftext
                id: saturday
                text: "SATURDAY"
                color: headercolor
                font.pointSize: 11
            }

            Text {
                x: startofheader + 9 * separation
                y: heightoftext
                id: sunday
                text: "SUNDAY"
                color: headercolor
                font.pointSize: 11
            }
        }


        Rectangle {
            id: table
            x: 0
            y: 350
            width: 1119
            height: 368
            color: "#ebecf0"


        }

        JSONListModel {
            id: itemDetails
            json: sd.retrieveData(Style.name)
        }
        ListView {
            x:33
            y:38
            width: 875
            height: 246
            spacing: 10
            id: names
            model: itemDetails.model
            delegate: ItemDelegate {
                Text {
                    x:350
                    y:8
                    id: nameos
                    text: model.NAME
                    font.pixelSize: 24
                }
                Text{
                    x:410
                    y:150
                    id:date
                    text:model.DATEJOINED
                    font.pixelSize:24
                }
                Text{
                    x:330
                    y:75
                    id:ager
                    text:model.AGE
                    font.pixelSize:24


                }
            }
        }

        ScrollView {
            x: 0
            y: 350
            ScrollBar.vertical: ScrollBar {
                policy: ScrollBar.AlwaysOff
            }
            clip: true
            width: 1119
            height: 368
            ListView {
                spacing: 10
                id: itemDetailModel
                x: 35
                y: 39
                width: 870
                height: 248
                model: itemDetails.model
                delegate: ItemDelegate {

                    Rectangle {
                        id: itemrectangle
                        x: -11
                        y: 50
                        height: 60
                        width: 1125
                        color: "transparent"
                        radius: 5
                        clip: true

                        Text {
                            x: startoftext
                            y: 25
                            id: monday_text
                            text: model.MONDAY
                            horizontalAlignment:Text.AlignLeft
                            font.pixelSize: fontsize
                            visible: true
                        }
                        Text {
                            x: startoftext+t_separation
                            y: 25
                            id: tuesday_text
                            text: model.TUESDAY
                            horizontalAlignment:Text.AlignHCenter
                            font.pixelSize: fontsize
                        }
                        Text {
                            x: startoftext+2*t_separation
                            y: 25
                            id: wednesday_text
                            text: model.WEDNESDAY
                            horizontalAlignment:Text.AlignHCenter
                            font.pixelSize: fontsize
                        }
                        Text {
                            x: startoftext+3*t_separation
                            y: 25
                            id: thursday_text
                            text: model.THURSDAY
                            horizontalAlignment:Text.AlignHCenter
                            font.pixelSize: fontsize
                        }
                        Text {
                            x: startoftext+4*t_separation
                            y: 25
                            id: friday_text
                            text: model.FRIDAY
                            horizontalAlignment:Text.AlignHCenter
                            font.pixelSize: fontsize
                        }
                        Text {
                            x: startoftext+5*t_separation
                            y: 25
                            id: saturday_text
                            text: model.SATURDAY
                            horizontalAlignment:Text.AlignHCenter
                            font.pixelSize: fontsize
                        }
                        Text {
                            x: startoftext+6*t_separation
                            y: 25
                            id: sunday_text
                            text: model.SUNDAY
                            horizontalAlignment:Text.AlignHCenter
                            font.pixelSize: fontsize
                        }
                    }
                }
            }
        }
    }

    Image {
        id: image
        x: 46
        y: 39
        width: 218
        height: 186
        source: "UI/login/icon.png"
        fillMode: Image.PreserveAspectFit
    }
}
