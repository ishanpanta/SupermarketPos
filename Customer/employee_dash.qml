import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import "."

Item {
    width: 1116
    height: 718
    signal setQMLSources(string path)

    Image {
        id: center_box
        source: "UI/employee/center_box.png"
        x: -3
        y: 0
        width: 1119
        height: 718
        opacity: 1
    }
    Item {
        id: searchrect
        x:510
        y:121
        width: 9
        height: 0
        opacity:1

        TextField
        {
            x: -228
            y: -22

            width: 610
            height: 45
            text: qsTr("")
            font.family: "Ubuntu"
            opacity: 1
            font.pixelSize: 16
            color: "black"
            layer.enabled: true
            focus: true
            placeholderText: ("Search")

            onAccepted: {
                Style.searchitem = text
                setQMLSources("employee_search.qml") //load table//
            }
        }
    }


    Image {
        id: searchicon
        source: "UI/employee/searchicon.png"
        x: 245
        y: 107
        opacity: 1
    }


    /*Rectangle {
        id: rectangle
        x: 930
        y: 107
        width: 165
        height: 36
        color: "#1db954"*/

    Image{
        id: additem
        x: 906
        y: 99
        source:"UI/employee/lmao.jpg"


        MouseArea
        {
            id: addProductButton
            cursorShape: Qt.PointingHandCursor
            anchors.fill: parent
            onClicked:
            {
                setQMLSources("employee_add.qml")
            }

        }

    }
    /*Text{
        id: additem_text
        color:"white"
        text: "Add Items"
        font.pointSize: 12
        x:41
        y:6
    }*/
    }
//}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.8999999761581421}
}
##^##*/
