import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import "."
//delete works//
Item {
    width: 1116
    height: 718
    signal setQMLSources(string path)
    property var startoftext: 70
    property var startofheader: 50
    property var heightoftext:10
    property var separation: 100
    property string headercolor:"#ffffff"
    property string headerfont:"ariel"
    property var fontsize: 17

    Image {
        id: center_box
        source: "UI/owner/center_box.png"
        x: -5
        y: 0
        width: 1119
        height: 718
        opacity: 1



        Rectangle {
            id: table
            x: 15
            y: 150
            width: 1090
            height: 539
            color: "#f5f5f5"
            radius: 5

        }
        DropShadow {
                anchors.fill: table
                horizontalOffset: 3
                verticalOffset: 3
                radius: 8.0
                anchors.rightMargin: 0
                anchors.bottomMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0
                samples: 17
                color: "#80000000"
                source: table
        }
    }

    Rectangle {
        id: header
        x: 8
        y: 98
        width: 1092
        height: 42
        color: "#2D3142"
        opacity: 0.2

    }
    Item {
        id: doesitmatter
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill:header
        Text {
            x:startofheader
            y:heightoftext
            id: itemID_header
            text: "Item ID"
            color:"black"
            font.pixelSize: fontsize
        }
        Text {
            x:startofheader+1*separation
            y:heightoftext
            id: itemName_header
            text: "Item Name"
            color:"black"
            font.pixelSize: fontsize
        }
        Text {
            x:startofheader+4.2*separation
            y:heightoftext
            id: itemPrice_header
            text: "Price"
            color:"black"
            font.pixelSize: fontsize
        }
        Text {
            x:startofheader+5.1*separation
            y:heightoftext
            id: itemQuantity_quantity
            text: "Quantity"
            color:"black"
            font.pixelSize: fontsize
        }
        Text{
            x:startofheader+6.1*separation
            y:heightoftext
            id: itemNOIS_header
            text: "No Of Items Sold"
            color:"black"
            font.pixelSize: fontsize
        }
    }


    Item {
        id: searchrect
        x: 510
        y: 106
        opacity: 1

        TextField {
            x: -236
            y: -78

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
        source: "UI/owner/searchicon.png"
        x: 237
        y: 37
        opacity: 1
        MouseArea {
            anchors.rightMargin: -35
            anchors.bottomMargin: 56
            anchors.leftMargin: 35
            anchors.topMargin: -56
            anchors.fill: parent
            onClicked: setQMLSources("owner_product_info.qml")
        }
    }

ScrollView{
    x:8
    y:146
    ScrollBar.vertical: ScrollBar {
        policy: ScrollBar.AlwaysOff
    }
    clip: true
    width: 1092
    height: 548
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
                color: "#4F5D75"
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
                    color:headercolor
                    font.pixelSize: fontsize
                }
                Text {
                    x:startoftext+1*separation
                    y:10
                    id: itemName
                    text: model.NAME
                    color:headercolor
                    font.pixelSize: fontsize
                }
                Text {
                    x:startofheader+4.3*separation
                    y:10
                    id: itemPrice
                    text: model.PRICE
                    color:headercolor
                    font.pixelSize: fontsize
                }
                Text{
                    x:startoftext+5.5*separation
                    y:10
                    id:itemQuantity
                    text:model.QUANTITY
                    color:headercolor
                    font.pixelSize: fontsize
                }
                Text{
                    x:startoftext+6.5*separation
                    y:10
                    id:itemNOIS
                    text:model.NO_OF_ITEM_SOLD
                    color:headercolor
                    font.pixelSize: fontsize
                }

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
}


/*##^##
Designer {
    D{i:0;formeditorZoom:0.75}
}
##^##*/
