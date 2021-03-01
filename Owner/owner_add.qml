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
    property var startoflist: 144
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
                placeholderText: ("Enter Product Serial Number")
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
                placeholderText: ("Enter Name of Product")
            }
        }

        Rectangle {
            id: price
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
                    text: qsTr("Price:")
                    anchors.rightMargin: 0
                    anchors.bottomMargin: -8
                    anchors.leftMargin: -66
                    anchors.topMargin: 8
                }
            }
            TextField {
                id:price_enter
                anchors.fill: parent
                font.family: textfieldfont
                opacity: 1
                font.pixelSize: 16
                color: "black"
                layer.enabled: true
                placeholderText: ("Enter Price of Product")
            }
        }

        Rectangle {
            id: description
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
                    text: qsTr("Description:")
                    anchors.rightMargin: 0
                    anchors.bottomMargin: -8
                    anchors.leftMargin: -66
                    anchors.topMargin: 8
                }
            }
            TextField {
                id:product_enter
                anchors.fill: parent
                font.family: textfieldfont
                opacity: 1
                font.pixelSize: 16
                color: "black"
                layer.enabled: true
            }


            ComboBox {
                id: description_combo
                x: 550
                width:200
                model: ['Shipping Date', 'Warranty', 'Expiry-date']
                onCurrentIndexChanged:
                {
                    if(description_combo.currentIndex == 0)
                    {
                        product_enter.placeholderText = "Enter Shipping Date: eg: dd-mm-yyyy, 18-09-2020"
                    }
                    else if(description_combo.currentIndex == 1)
                    {
                        product_enter.placeholderText = "Enter Warranty: eg: x years, 4 years"
                    }
                    else if(description_combo.currentIndex == 2)
                    {
                        product_enter.placeholderText = "Enter Expiry-Date: eg: dd-mm-yyyy, 18-09-2020"
                    }
                }
            }
        }


        Rectangle {
            id: itemtype
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
                    text: qsTr("Item Type:")
                    anchors.rightMargin: 0
                    anchors.bottomMargin: -8
                    anchors.leftMargin: -66
                    anchors.topMargin: 8
                }
            }

            ComboBox {
                id: item_type
                anchors.fill:parent
                model: ['Groceries', 'Stationery', 'Electronics', 'Beverage', 'Clothing']
            }
        }

        Rectangle {
            //maybe combo box//
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
                    text: qsTr("Location:")
                    anchors.rightMargin: 0
                    anchors.bottomMargin: -8
                    anchors.leftMargin: -66
                    anchors.topMargin: 8
                }
            }
            TextField {
                id:location_enter
                anchors.fill: parent
                font.family: textfieldfont
                opacity: 1
                font.pixelSize: 16
                color: "black"
                layer.enabled: true
                placeholderText: ("Enter Location of Product")
            }
        }

        Rectangle {
            id: quantity
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
                    text: qsTr("Quantity:")
                    anchors.rightMargin: 0
                    anchors.bottomMargin: -8
                    anchors.leftMargin: -66
                    anchors.topMargin: 8
                }
            }

            TextField {
                id:quantity_enter
                anchors.fill: parent
                font.family: textfieldfont
                opacity: 1
                font.pixelSize: 16
                color: "black"
                layer.enabled: true
                placeholderText: ("Enter Quantity of Product")
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
                    pd.insertData(sno_enter.text, name_enter.text, price_enter.text,product_enter.text, description_combo.currentText,item_type.currentText, location_enter.text, quantity_enter.text)
                    setQMLSources("owner_dash.qml")
                }
            }
        }


    }
}
