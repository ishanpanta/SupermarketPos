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
    property string headercolor:"white"
    property string headerfont:"ariel"
    property var fontsize: 17
    property string product:""
    property string description:""

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
            y: 142
            width: 1081
            height: 539
            color: "#f5f5f5"
            radius: 5

        }
        DropShadow {
                anchors.fill: table
                horizontalOffset: 3
                verticalOffset: 3
                radius: 8.0
                anchors.rightMargin: 26
                samples: 17
                color: "#80000000"
                source: table
        }
    }

    Rectangle {
        id: header
        x: 19
        y: 92
        width: 1081
        height: 42
        color: "#2d3142"
        opacity: 1

    }
    Item {
        id: doesitmatter
        anchors.rightMargin: 19
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
            x:startofheader+3.45*separation
            y:heightoftext
            id: itemPrice_header
            text: "Price"
            color:headercolor
            font.pixelSize: fontsize
        }
        Text {
            x:startofheader+4.4*separation
            y:heightoftext
            id: itemDescription_header
            text: "Description"
            color:headercolor
            font.pixelSize: fontsize
        }
        Text{
            x:startofheader+6.55*separation
            y:heightoftext
            id: itemItemType_header
            text: "Type of Item"
            color:headercolor
            font.pixelSize: fontsize
        }
        Text{
            x:startofheader+7.55*separation
            y:heightoftext
            id: itemLocation_header
            text: "Location"
            color:headercolor
            font.pixelSize: fontsize
        }
        Text {
            x:startofheader+8.4*separation
            y:heightoftext
            id: itemQuantity_quantity
            text: "Quantity"
            font.pixelSize: fontsize
            color:headercolor
        }
    }

    Image {
        id: back
        source: "UI/employee//back.png"
        x: 0
        y: 8
        width: 36
        height: 38
        opacity: 1
        MouseArea{
            anchors.fill:parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {setQMLSources("employee_dash.qml")}

        }
    }

    Item {
        id: searchrect
        x: 510
        y: 106
        opacity: 1

        TextField {
            x: -246
            y: -85

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
        x: 229
        y: 30
        opacity: 1
        MouseArea {

            anchors.fill: parent
            onClicked: setQMLSources("employee_search.qml")
        }
    }
    Popup
    {
        id:deleteconfirm
        anchors.centerIn: parent
        width:400
        height:300
        closePolicy:deleteconfirm.CloseOnPressOutsideParent
        Text {

            id:areyousure
            font.family:"Ubuntu"
            font.pixelSize: 32
            text: qsTr("Deletion confirmation")
        }
        Button
        {
            id:yes
            text:"Yes"
            x: 100
            y:100

            onClicked:
            {
                deleteconfirm.close()
                pd.deleteData(Style.deleteitem)
                setQMLSources("employee_search.qml")

            }
        }
        Button{
            id:no
            text: "No"
            x: 200
            y: 100

            onClicked:
            {
                deleteconfirm.close()
            }

        }
    }
ScrollView{
    x:19
    y:140
    ScrollBar.vertical: ScrollBar {
        policy: ScrollBar.AlwaysOff
    }
    clip: true
    width: 1081
    height: 540
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
                width: 1081
                color: "#8ecae6"
                radius:5
                clip:true
                Rectangle
                {
                    x:0
                    y:50
                    height: 20
                    width:1105
                    color:Style.itemcolor
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
                    x:startofheader+3.45*separation
                    y:10
                    id: itemPrice
                    text: model.PRICE
                    font.pixelSize: fontsize
                }
                Text {
                    x:startoftext+4.2*separation
                    y:10
                    id: itemDescription
                    text: model.DESCRIPTION
                    font.pixelSize: fontsize
                }
                Text{
                    x:startoftext+6.55*separation
                    y:10
                    id: itemItemType
                    text: model.ITEM_TYPE
                    font.pixelSize: fontsize
                }
                Text{
                    x:startoftext+7.55*separation
                    y:10
                    id: itemLocation
                    text: model.LOCATION
                    font.pixelSize: fontsize
                }
                Text{
                    x:startoftext+8.6*separation
                    y:10
                    id:itemQuantity
                    text:model.QUANTITY
                    font.pixelSize: fontsize
                }


                Image
                {
                    source:"UI/employee/edit-regular.png"
                    x:startoftext+9.2*separation
                    y:7
                    width: 38
                    height: 35

                    MouseArea
                    {
                        cursorShape: Qt.PointingHandCursor
                        anchors.fill:parent
                        onClicked:
                        {
                            Style.sno = model.S_NO
                            Style.item_name = model.NAME
                            Style.price = model.PRICE
                            Style.description = model.DESCRIPTION
                            Style.item_type = model.ITEM_TYPE
                            Style.location = model.LOCATION
                            Style.quantity = model.QUANTITY
                            setQMLSources("employee_edit.qml")
                        }
                    }


                }
                Image{
                    source:"UI/employee/trash-solid.png"
                    x:startoftext+9.75*separation
                    y:7
                    width: 30
                    height: 35

                    MouseArea
                    {
                        cursorShape: Qt.PointingHandCursor
                        anchors.fill:parent
                        onClicked:
                        {
                            Style.deleteitem = model.S_NO
                            deleteconfirm.open()
                        }
                    }
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
    D{i:0;formeditorZoom:0.8999999761581421}
}
##^##*/
