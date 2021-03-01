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

        Text {
            id: element
            x: 371
            y: 46
            width: 378
            height: 59
            text: qsTr("Monthly Report")
            font.family: "ubuntu"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 38
        }

        Rectangle {
            id: product_info_button
            x: 405
            y: 181
            width: 333
            height: 71
            color: "#abcdef"
            radius: 25

            Text {
                id: element1
                x: 32
                y: 7
                width: 265
                height: 55
                text: qsTr("Product Info")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 26
            }
            MouseArea {
                id: prod_mouseArea
                x: -2
                y: 0
                width: 333
                height: 71
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    setQMLSources("owner_product_info.qml")
               }
            }
        }

        Rectangle {
            id: suggestions_button
            x: 405
            y: 317
            width: 333
            height: 71
            color: "#abcdef"
            radius: 25
            Text {
                id: element2
                x: 39
                y: 8
                width: 265
                height: 55
                text: qsTr("Feedback")
                font.pixelSize: 26
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
            MouseArea {
                id: feedback_mouseArea
                x: 0
                y: 0
                width: 333
                height: 71
                cursorShape: Qt.PointingHandCursor
                onClicked: {

                    setQMLSources("suggestion.qml")
               }
            }

        }

        Rectangle {
            id: req_button
            x: 405
            y: 461
            width: 333
            height: 71
            color: "#abcdef"
            radius: 25
            Text {
                id: element3
                x: 33
                y: 11
                width: 265
                height: 55
                text: qsTr("Requested Items")
                font.pixelSize: 26
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
            MouseArea {
                id: req_mouseArea
                x: -1
                y: 0
                width: 333
                height: 71
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                      setQMLSources("request_item.qml")
                }
            }
        }

        Text {
            id: element4
            x: 415
            y: 263
            width: 323
            height: 20
            color: "#808080"
            text: qsTr("Displays Products name with respective sales")
            font.family: "ubuntu"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 14
        }

        Text {
            id: element5
            x: 410
            y: 407
            width: 323
            height: 20
            color: "#808080"
            text: qsTr("Displays feedbacks from the customer")
            font.pixelSize: 14
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: "ubuntu"
        }

        Text {
            id: element6
            x: 410
            y: 557
            width: 323
            height: 20
            color: "#808080"
            text: qsTr("Displays requested items from the customer")
            font.pixelSize: 14
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: "ubuntu"
        }

        /*ComboBox {
            id: comboBox
            x: 355
            y: 255
            width: 241
            height: 56
            model: ['Choose', 'Product Info', 'Suggestions', 'Request Item']
            onCurrentIndexChanged:
            {
                if(comboBox.currentIndex == 0)
                {

                }
                else if(comboBox.currentIndex == 1)
                {
                    setQMLSources("owner_product_info.qml")
                }
                else if(comboBox.currentIndex == 2)
                {
                    setQMLSources("suggestion.qml")
                }
                else if(comboBox.currentIndex == 3)
                {
                   setQMLSources("request_item.qml")
                }
            }
        }*/
    }


}
