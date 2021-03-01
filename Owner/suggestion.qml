import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import "."

Item {
    width: 1116
    height: 718
    signal setQMLSources(string path)
    property var startoftext: 70
    property var startofheader: 50
    property var heightoftext:10
    property var separation: 100
    property string headercolor:"#000000"
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
            x: 19
            y: 176
            width: 1081
            height: 513
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
        x: 14
        y: 119
        width: 1081
        height: 42
        color: "#2d3142"
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
            color:headercolor
            font.pixelSize: fontsize
        }
        Text {
            x:startofheader+1*separation
            y:heightoftext
            id: itemName_header
            text: "Suggestion Type"
            color:headercolor
            font.pixelSize: fontsize
        }
        Text {
            x:startofheader+3.5*separation
            y:heightoftext
            id: itemPrice_header
            text: "Suggestion"
            color:headercolor
            font.pixelSize: fontsize
        }
    }

    JSONListModel{
        id: itemDetails
        json: rands.retrieveDataSuggestion("suggestion")
    }


ScrollView{
    x:8
    y:174
    ScrollBar.vertical: ScrollBar {
        policy: ScrollBar.AlwaysOff
    }
    clip: true
    width: 1092
    height: 514
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

                Text {
                    x:startoftext+0.1*separation
                    y:10
                    id: itemID
                    text: model.S_NO
                    color:"white"
                    font.pixelSize: fontsize
                }
                Text {
                    x:startoftext+1*separation
                    y:10
                    id: itemName
                    text: model.SUGGESTION_TYPE
                    color:"white"
                    font.pixelSize: fontsize
                }
                Text {
                    x:startofheader+4.1*separation
                    y:10
                    id: itemPrice
                    text: model.SUGGESTION
                    color:"white"
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

