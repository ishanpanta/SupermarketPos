import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import "."

Rectangle {
    signal setQMLSource(string path)
    property var orderList: ListModel {} //array jasto hunxa
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
        source: "UI/owner/center_box.png"
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
            color: "#a2fae3"

            Rectangle {
                id: rectangle
                x: 8
                y: 147
                width: 452
                height: 53
                color: "#f2d2f7"

                TextInput {
                    id: textInput
                    x: 8
                    y: 8
                    width: 208
                    height: 37
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
                    text: qsTr("QUANITY")
                    verticalAlignment: Text.AlignVCenter
                    font.family: "ubuntu"
                    font.pixelSize: 19
                }
            }

            Text {
                id: element
                x: 56
                y: 32
                width: 359
                height: 99
                text: qsTr("BILLING")
                font.family: "ubuntu"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 45
            }

            Rectangle {
                id: orderListView
                x: 8
                y: 225
                width: 452
                height: 328
                color: "#faf6c0"

                ListView {
                    x: 0
                    y: 0
                    width: 452
                    height: 328
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
                id: rectangle2
                x: 8
                y: 566
                width: 452
                height: 66
                color: "#ffffff"

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

            Button {
                id: bill
                x: 284
                y: 653
                width: 149
                height: 48
                text: qsTr("BILL")
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
                    setQMLSource("owner_billing.qml")
                }
            }
        }

        Item {
            id: searchrect
            x: 400
            y: 50
            opacity: 1

            TextField {
                x: -342
                y: 18

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
            source: "UI/owner/searchicon.png"
            x: 20
            y: 80
            opacity: 1
        }

        Rectangle {
            id: headerRectangle
            x: 8
            y: 223
            width: 637
            height: 55
            color: "#cdd3f7"

            Text {
                id: itemID_header
                x: 8
                y: 8
                width: 75
                height: 39
                text: qsTr("ITEM ID")
                font.family: "ubuntu"
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
            }
        }

        Rectangle {
            id: displayItemsRectangle
            x: 8
            y: 306
            width: 637
            height: 412
            color: "#d2f7e7"
        }

        JSONListModel {
            id: itemDetails
            json: pd.retrieveData(Style.searchitem)
        }

        ScrollView {
            x: 8
            y: 306
            ScrollBar.vertical: ScrollBar {
                policy: ScrollBar.AlwaysOff
            }
            clip: true
            width: 637
            height: 412
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
                        color: "#EF767A"
                        radius: 5
                        clip: true

                        Text {
                            x: 8
                            y: 8
                            id: itemID
                            text: model.S_NO
                            font.pixelSize: 17
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignVCenter
                        }
                        Text {
                            x: 95
                            y: 8
                            id: itemName
                            text: model.NAME
                            font.pixelSize: 17
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                        }
                        Text {
                            x: 395
                            y: 8
                            id: itemPrice
                            text: model.PRICE
                            font.pixelSize: 17
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                        }
                        Image {
                            source: "UI/owner/add.png"
                            x: 550
                            y: 8
                            width: 38
                            height: 35

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
        x: 871
        y: 571
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
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
