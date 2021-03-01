import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import "."

Rectangle {
    signal setQMLSource(string path)
    property var orderList: ListModel {} //array
    property var totalPrice: 0
    function makeOrder(sno, name, price, mode) {
        var i = 0
        var flag = 0
        var pos = 0
        if (orderList.count === 0) {
            orderList.clear()
            flag = 0
        } else {
            for (i = 0; i < orderList.count; i++) {
                if (orderList.get(i).sno === sno) {
                    flag = 1
                    pos = i
                    break
                } else {
                    flag = 0
                }
            }
        }
        if (mode === 0) {
            if (orderList.get(pos).count === 1) {
                orderList.remove(pos)
                return 1
            }
            var tempcount1 = orderList.get(pos).count - 1
            orderList.set(pos, {
                              "name": name,
                              "sno": sno,
                              "count": tempcount1,
                              "price": price
                          })
            return 1
        }
        if (flag === 0) {
            var temp = {
                "name": name,
                "sno": sno,
                "count": 1,
                "price": price
            }
            orderList.append(temp)
        } else {
            var tempcount = orderList.get(pos).count + 1
            orderList.set(pos, {
                              "name": name,
                              "sno": sno,
                              "count": tempcount,
                              "price": price
                          })
        }
    }
    function getTotal() {
        var total = 0
        if (orderList.count === 0) {
        } else {
            for (var i = 0; i < orderList.count; i++) {
                total +=(parseInt(orderList.get(i).price)*parseInt(orderList.get(i).count))
            }
        }
        totalPrice = total
    }

    Image {
        id: center_box
        source: "UI/employee/center_box.png"
        x: -5
        y: 0
        width: 1119
        height: 718
        opacity: 1

        Rectangle {
            id: billingRectangle
            x: 651
            y: 0
            width: 468
            height: 718
            color: "#ffffff"

            Rectangle {
                id: billing_header
                x: 8
                y: 90
                width: 452
                height: 55
                color: "#2d3142"

                TextInput {
                    id: textInput
                    x: 8
                    y: 8
                    width: 208
                    height: 37
                    color: "#ffffff"
                    text: qsTr("ITEM NAME")
                    verticalAlignment: Text.AlignVCenter
                    font.family: "ubuntu"
                    font.pixelSize: 19

                    TextInput {
                        id: textInput1
                        x: 213
                        y: 0
                        width: 78
                        height: 37
                        color: "#ffffff"
                        text: qsTr("PRICE")
                        verticalAlignment: Text.AlignVCenter
                        font.family: "ubuntu"
                        font.pixelSize: 19
                    }
                }

                Text {
                    id: element1
                    x: 329
                    y: 8
                    width: 102
                    height: 37
                    color: "#ffffff"
                    text: qsTr("QUANITY")
                    verticalAlignment: Text.AlignVCenter
                    font.family: "ubuntu"
                    font.pixelSize: 19
                }
            }

            Text {
                id: element
                x: 55
                y: 0
                width: 359
                height: 99
                color: "#000000"
                text: qsTr("BILLING")
                font.family: "ubuntu"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 45
            }

            Rectangle {
                id: orderListView
                x: 9
                y: 160
                width: 452
                height: 328
                color: "#f5f5f5"

                ListView {
                    x: 1
                    y: 0
                    width: 452
                    height: 326
                    model: orderList
                    delegate: ItemDelegate {
                        Rectangle {
                            x: 0
                            y: 0
                            width: 452
                            height: 35
                            Text {
                                text: model.name
                                width:200
                                elide: Text.ElideRight
                                x: 5
                                y: 0
                                font.pointSize: 11
                            }
                            Text {
                                text: model.price
                                x: 213
                                y: 0
                                font.pointSize: 11
                                horizontalAlignment: Text.AlignRight
                            }
                            Text {
                                text: model.count
                                x: 350
                                y: 0
                                font.pointSize: 11
                            }
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    makeOrder(model.sno, model.name,
                                              model.price, 0)
                                    getTotal()
                                    grandTotal.text = totalPrice

                                }
                            }
                        }
                    }
                }
            }
            Rectangle {
                id: bottom_thing_for_billing
                x: 9
                y: 518
                width: 452
                height: 66
                color: "#e4e4e4"

                Text {
                    id: element3
                    x: 8
                    y: 8
                    width: 132
                    height: 50
                    text: qsTr("TOTAL PRICE")
                    verticalAlignment: Text.AlignVCenter
                    font.family: "Tahoma"
                    font.pixelSize: 19
                }
                Text {
                    id: grandTotal
                    x: 249
                    y: 8
                    width: 49
                    height: 50
                    text: "0"
                    verticalAlignment: Text.AlignVCenter
                    font.family: "Tahoma"
                    font.pixelSize: 19
                }
            }

            Rectangle {
                id: bill
                x: 289
                y: 629
                radius:100
                color: "#1DB954"
                width: 149
                height: 48
                Text{
                    width: 149
                    height: 48
                    text: qsTr("BILL")
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    anchors.verticalCenterOffset: 0
                    anchors.horizontalCenterOffset: 0
                    color:"white"
                    font.pixelSize: 20
                    anchors.centerIn: parent
                }
                MouseArea
                {
                    anchors.fill:parent
                     cursorShape: Qt.PointingHandCursor
                     onClicked: {
                         var items = ""
                         var itemQuantity = ""
                         for(var i = 0; i < orderList.count; i++) {

                             items = items + String(orderList.get(i).sno) + ","
                             itemQuantity = itemQuantity + String(orderList.get(i).count) + ","
                         }
                         items = items.substr(0, items.length-1)
                         itemQuantity = itemQuantity.substr(0, itemQuantity.length-1)
                         pd.makeBill(items, itemQuantity)
                         setQMLSource("employee_billing.qml")
                     }
                }


            }
        }

        Item {
            id: searchrect
            x: 400
            y: 50
            opacity: 1

            TextField {
                x: -343
                y: -25

                width: 587
                height: 50
                text: qsTr("")
                font.family: "Ubuntu"
                opacity: 1
                font.pixelSize: 18
                color: "black"
                layer.enabled: true
                focus: true
                placeholderText: ("Search")

                onAccepted: {
                    itemDetails.json = pd.retrieveData(text)
                    Style.searchitem = text
                }
            }
        }

        Image {
            id: searchicon
            source: "UI/employee/searchicon.png"
            x: 20
            y: 36
            opacity: 1
        }

        Rectangle {
            id: headerRectangle
            x: -1
            y: 90
            width: 651
            height: 55
            color: "#2d3142"

            Text {
                id: itemID_header
                x: 8
                y: 8
                width: 75
                height: 39
                text: qsTr("ITEM ID")
                font.family: "ubuntu"
                color:"white"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 19
            }

            Text {
                id: itemName_header
                x: 95
                y: 8
                width: 272
                height: 39
                text: qsTr("ITEM NAME")
                font.family: "ubuntu"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: 19
                color:"white"
            }

            TextInput {
                id: itemPrice_header
                x: 395
                y: 8
                width: 110
                height: 39
                text: qsTr("PRICE")
                verticalAlignment: Text.AlignVCenter
                font.family: "ubuntu"
                font.pixelSize: 19
                color:"white"
            }

            Text {
                id: element2
                x: 515
                y: 8
                width: 122
                height: 39
                text: qsTr("ADD TO CART")
                verticalAlignment: Text.AlignVCenter
                font.family: "ubuntu"
                font.pixelSize: 19
                color:"white"
            }
        }

        Rectangle {
            id: displayItemsRectangle
            x: 8
            y: 151
            width: 637
            height: 526
            color: "#f5f5f5"
        }

        JSONListModel {
            id: itemDetails
            json: pd.retrieveData(Style.searchitem)
        }

        ScrollView {
            x: 10
            y: 156
            ScrollBar.vertical: ScrollBar {
                policy: ScrollBar.AlwaysOff
            }
            clip: true
            width: 630
            height: 515
            ListView {
                spacing: 10
                id: itemDetailModel
                x: 8
                y: 306
                model: itemDetails.model
                delegate: ItemDelegate {

                    Rectangle {
                        id: itemrectangle
                        height: 50
                        width: 637
                        color: Style.itemcolor
                        radius: 5
                        clip: true

                        Text {
                            x: 8
                            y: 15
                            id: itemID
                            text: model.S_NO
                            font.pixelSize: 17
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignVCenter
                        }
                        Text {
                            x: 95
                            y: 15
                            id: itemName
                            text: model.NAME
                            font.pixelSize: 17
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            color:"black"
                        }
                        Text {
                            x: 392
                            y: 15
                            id: itemPrice
                            text: model.PRICE

                            font.pixelSize: 17
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                        }
                        Image {
                            source: "UI/employee/add.png"
                            x: 550
                            y: 15
                            width: 22
                            height: 21

                            MouseArea {
                                cursorShape: Qt.PointingHandCursor
                                anchors.fill: parent
                                onClicked: {
                                    makeOrder(model.S_NO, model.NAME,
                                              model.PRICE, 1)
                                    getTotal()
                                    grandTotal.text = totalPrice
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    Text {
        id: element4
        x: 863
        y: 524
        width: 42
        height: 52
        text: qsTr("RS.")
        verticalAlignment: Text.AlignVCenter
        font.family: "ubuntu"
        font.pixelSize: 19
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.8999999761581421;height:480;width:640}
}
##^##*/
