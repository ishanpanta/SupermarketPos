import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import "."

Item {
    width: 1116
    height: 718
    signal setQMLSource(string path)
    property var startoftext: 70
    property var startofheader: 50
    property var heightoftext:10
    property var separation: 100
    property string headercolor:"#000000"
    property string headerfont:"ariel"
    property var fontsize: 17

    Image {
        id: center_box
        source: "UI/employee/center_box.png"
        x: -5
        y: 0
        width: 1119
        height: 718
        opacity: 1



        Rectangle {
            id: table
            x: 24
            y: 306
            width: 1081
            height: 270
            color: "#f5f5f5"
            radius: 5

        }
        DropShadow {
                anchors.fill: table
                horizontalOffset: 3
                verticalOffset: 3
                radius: 8.0
                samples: 17
                color: "#80000000"
                source: table
        }
    }

    Rectangle {
        id: header
        x: 19
        y: 258
        width: 1081
        height: 42
        color: "#57608c"
        opacity: 0.2

    }
    Item {
        id: doesitmatter
        anchors.fill:header
        Text {
            x:startofheader
            y:heightoftext
            id: itemID_header
            text: "Item ID"
            color:headercolor
            font.pixelSize: fontsize
        }
        Text {
            x:startofheader+0.8*separation
            y:heightoftext
            id: itemName_header
            text: "Item Name"
            color:headercolor
            font.pixelSize: fontsize
        }
        Text {
            x:startofheader+3.5*separation
            y:heightoftext
            id: itemPrice_header
            text: "Price"
            color:headercolor
            font.pixelSize: fontsize
        }
        Text {
            x:startofheader+4.5*separation
            y:heightoftext
            id: itemQuantity_quantity
            text: "Quantity"
            font.pixelSize: fontsize
        }
        Text {
            x:startofheader+5.5*separation
            y:heightoftext
            id: itemNOIS_header
            text: "No Of Items Sold"
            color:headercolor
            font.pixelSize: fontsize
        }
    }

    Image {
        id: back
        source: "UI/employee//back.png"
        x: 0
        y: 8
        opacity: 1
        MouseArea{
            anchors.rightMargin: -6
            anchors.bottomMargin: -6
            anchors.leftMargin: -5
            anchors.topMargin: -6
            anchors.fill:parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {setQMLSource("owner_monthly.qml")}

        }
    }

    Item {
        id: searchrect
        x: 510
        y: 106
        opacity: 1

        TextField {
            x: -243
            y: -22

            width: 610
            height: 45
            font.family: "Ubuntu"
            opacity: 1
            font.pixelSize: 20
            color: "black"
            text: Style.searchitem
            layer.enabled: true
            focus: true
            placeholderText: ("Search")
            onAccepted: {
                itemDetails.json = pd.retrieveData(text)
                Style.searchitem = text
            }
        }
    }


    JSONListModel{
        id: itemDetails
        json: pd.retrieveData(Style.searchitem)
    }
    Image {
        id: searchicon
        source: "UI/employee/searchicon.png"
        x: 202
        y: 92
        opacity: 1
        MouseArea {
            anchors.fill: parent
            onClicked: setQMLSource("employee_search.qml")
        }
    }

ScrollView{
    x:19
    y:306
    ScrollBar.vertical: ScrollBar {
        policy: ScrollBar.AlwaysOff
    }
    clip: true
    width: 1081
    height: 380
    ListView{
        spacing: 10
        id: itemDetailModel
        model: itemDetails.model
        delegate: ItemDelegate{
                Rectangle
                {
                id:itemrectangle
                x: -11
                y:15
                height: 50
                width: 1100
                color: "#EF767A"
                radius:5
                clip:true
                Rectangle
                {
                    x:0
                    y:50
                    height: 20
                    width:1105
                    color:"red"
                }

                Text {
                    x:startoftext+0.1*separation
                    y:10
                    id: itemID
                    text: model.S_NO
                    font.pixelSize: fontsize
                }
                Text {
                    x:startoftext+0.7*separation
                    y:10
                    id: itemName
                    text: model.NAME
                    font.pixelSize: fontsize
                }
                Text {
                    x:startofheader+3.7*separation
                    y:10
                    id: itemPrice
                    text: model.PRICE
                    font.pixelSize: fontsize
                }
                Text{
                    x:startoftext+4.7*separation
                    y:10
                    id:itemQuantity
                    text:model.QUANTITY
                    font.pixelSize: fontsize
                }
                Text{
                    x:startoftext+5.7*separation
                    y:10
                    id: itemNOIS
                    text: model.NO_OF_ITEM_SOLD
                    font.pixelSize: fontsize
                }

           DropShadow {
                    anchors.fill: itemrectangle
                    horizontalOffset: 3
                    verticalOffset: 3
                    radius: 8.0
                    anchors.rightMargin: -6
                    anchors.bottomMargin: 0
                    anchors.leftMargin: -5
                    anchors.topMargin: 0
                    samples: 17
                    color: "#80000000"
                    source: itemrectangle
            }


        }
    }

}
}}
