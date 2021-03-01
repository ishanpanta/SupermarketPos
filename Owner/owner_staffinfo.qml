import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import "."

Item {
    width: 1116
    height: 718
    signal setQMLSources(string path)
    property string currentShiftItem: ""

    Image {
        id: center_box
        source: "UI/employee/center_box.png"
        x: -3
        y: 0
        width: 1119
        height: 718
        opacity: 1

        Rectangle {
            id: leftRectangle
            x: 0
            y: 0
            width: 560
            height: 718
            color: "#ffffff"

            Image {
                id: searchiconEmployee
                x: 15
                y: 71
                fillMode: Image.PreserveAspectFit
                source: "UI/employee/searchicon.png"
            }

            Image {
                id: additemsEmployee
                x: 423
                y: 62
                width: 133
                height: 36
                fillMode: Image.PreserveAspectFit
                source: "UI/employee/additems.png"

                TextInput {
                    id: textAddEmployee
                    x: 26
                    y: 8
                    width: 104
                    height: 20
                    color: "#ffffff"
                    text: qsTr("ADD EMPLOYEE")
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 14
                }
                MouseArea {
                    id: addOwnerButton
                    anchors.rightMargin: 0
                    anchors.bottomMargin: 1
                    anchors.leftMargin: 1
                    anchors.topMargin: -1
                    cursorShape: Qt.PointingHandCursor
                    anchors.fill: parent
                    onClicked: {
                        setQMLSources("owner_employee_add.qml")
                    }
                }
            }

            Text {
                id: element
                x: 160
                y: 0
                width: 183
                height: 45
                text: qsTr("EMPLOYEE")
                font.family: "ubuntu"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 30
            }

            Rectangle {
                id: headerEmployee
                x: 10
                y: 130
                width: 542
                height: 54
                color: "#2d3142"

                Text {
                    id: element1
                    x: 8
                    y: 8
                    width: 104
                    height: 38
                    color: "#ffffff"
                    text: qsTr(" EMPLOYEE ID")
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 18
                }

                Text {
                    id: element2
                    x: 138
                    y: 8
                    width: 290
                    height: 38
                    color: "#ffffff"
                    text: qsTr("NAME")
                    font.family: "ubuntu"
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 18
                }
            }

            Rectangle {
                id: displayEmpolyeeRec
                x: 10
                y: 214
                width: 542
                height: 496
                color: "#bfc0c0"
            }
        }

        // pop-up for delection of employee data
        Popup {
            id: deleteconfirm
            anchors.centerIn: parent
            width: 400
            height: 300
            closePolicy: deleteconfirm.CloseOnPressOutsideParent
            Text {

                id: areyousure
                font.family: "Ubuntu"
                font.pixelSize: 32
                text: qsTr("Deletion confirmation")
            }
            Button {
                id: yes
                text: "Yes"
                x: 100
                y: 100

                onClicked: {
                    deleteconfirm.close()
                    ed.deleteData(Style.deleteEmployee)
                    setQMLSources("owner_staffinfo.qml")
                }
            }
            Button {
                id: no
                text: "No"
                x: 200
                y: 100

                onClicked: {
                    deleteconfirm.close()
                }
            }
        }

        Item {
            id: employeesearchrect
            x: 510
            y: 121
            width: 9
            height: 0
            opacity: 1

            TextField {
                id: employeeSearch
                x: -458
                y: -61

                width: 374
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
                    itemDetails.json = ed.retrieveData(employeeSearch.text)
                    Style.searchitem = employeeSearch.text
                }
            }
        }


        JSONListModel {
            id: itemDetails
            json: ed.retrieveData(Style.searchitem)
        }
        ScrollView {
            id: employeeList
            x: 8
            y: 212
            ScrollBar.vertical: ScrollBar {
                policy: ScrollBar.AlwaysOff
            }
            clip: true
            width: 542
            height: 498
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
                        width: 540
                        color: "#4F5D75"
                        radius: 5
                        clip: true

                        Text {
                            x: 65
                            y: 8
                            id: itemID
                            text: model.ID
                            color: "white"
                            font.pixelSize: 19
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignVCenter
                        }
                        Text {
                            x: 135
                            y: 8
                            id: itemName
                            text: model.NAME
                            color: "white"
                            font.pixelSize: 19
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                        }

                        Image {
                            source: "UI/owner/edit-regular.png"
                            x: 420
                            y: 8
                            width: 28
                            height: 30
                            MouseArea {
                                hoverEnabled: true
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    Style.sno = model.ID
                                    Style.name = model.NAME
                                    Style.email = model.EMAIL
                                    Style.password = model.PASSWORD
                                    Style.gender = model.GENDER
                                    Style.contact_number = model.CONTACT_NUMBER
                                    Style.address = model.ADDRESS
                                    Style.date_of_birth = model.DATE_OF_BIRTH
                                    Style.working_since = model.WORKING_SINCE
                                    setQMLSources("owner_employee_edit.qml")
                                }
                            }
                        }

                        Image {
                            source: "UI/owner/trash-solid.png"
                            x: 485
                            y: 8
                            width: 28
                            height: 30
                            MouseArea {
                                cursorShape: Qt.PointingHandCursor
                                anchors.fill: parent
                                onClicked: {
                                    Style.deleteEmployee = model.ID
                                    deleteconfirm.open()
                                }
                            }
                        }
                    }
                }
            }
        }

        Rectangle {
            id: rectangle
            x: 560
            y: 0
            width: 559
            height: 718
            color: "#ffffff"

            Image {
                id: shiftdata_search
                x: 5
                y: 63
                fillMode: Image.PreserveAspectFit
                source: "UI/employee/searchicon.png"
            }

            Image {
                id: addShiftdata
                x: 418
                y: 54
                width: 133
                height: 36
                fillMode: Image.PreserveAspectFit
                source: "UI/employee/additems.png"

                TextInput {
                    id: add_shift_text
                    x: 29
                    y: 3
                    width: 107
                    height: 26
                    color: "#ffffff"
                    text: qsTr("ADD SHIFT")
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 14
                }
                MouseArea {
                    id: addShiftDataButton
                    anchors.rightMargin: 0
                    anchors.bottomMargin: 2
                    anchors.leftMargin: 0
                    anchors.topMargin: -2
                    cursorShape: Qt.PointingHandCursor
                    anchors.fill: parent
                    onClicked: {
                        setQMLSources("owner_ShiftData_add.qml")
                    }
                }
            }

            Text {
                id: shift_data_text
                x: 165
                y: 0
                width: 183
                height: 45
                text: qsTr("SHIFT_DATA")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 30
            }

            Rectangle {
                id: headerShift
                x: 8
                y: 129
                width: 543
                height: 54
                color: "#2d3142"

                Text {
                    id: element3
                    x: 8
                    y: 8
                    width: 90
                    height: 38
                    color: "#ffffff"
                    text: qsTr("EMPLOYEE ID")
                    font.family: "ubuntu"
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 18
                }

                Text {
                    id: element4
                    x: 138
                    y: 8
                    width: 246
                    height: 38
                    color: "#ffffff"
                    text: qsTr("NAME")
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 18
                }
            }

            Rectangle {
                id: shift_data_displayRec
                x: 8
                y: 215
                width: 543
                height: 495
                color: "#bfc0c0"
            }
        }
        Item {
            id: swiftdatasearchrect
            x: 594
            y: 43
            width: 381
            height: 42
            opacity: 1

            TextField {
                id: shiftSearchText
                x: 5
                y: 7

                width: 374
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
                    itemDetailsShiftData.json = sd.retrieveData(text)
                    currentShiftItem = shiftSearchText.text
                }
            }
        }
        JSONListModel {
            id: itemDetailsShiftData
            json: sd.retrieveData(currentShiftItem)
        }

        Popup {
            id: deleteconfirmSiftData
            anchors.centerIn: parent
            width: 400
            height: 300
            closePolicy: deleteconfirmSiftData.CloseOnPressOutsideParent
            Text {

                id: areyousureSiftData
                font.family: "Ubuntu"
                font.pixelSize: 32
                text: qsTr("Deletion confirmation")
            }
            Button {
                id: yesSiftData
                text: "Yes"
                x: 100
                y: 100

                onClicked: {
                    deleteconfirmSiftData.close()
                    sd.deleteData(Style.deleteShift_data)
                    setQMLSources("owner_staffinfo.qml")
                }
            }
            Button {
                id: noSiftData
                text: "No"
                x: 200
                y: 100

                onClicked: {
                    deleteconfirmSiftData.close()
                }
            }
        }

        ScrollView {
            id: shiftData_scrollView
            x: 569
            y: 217
            ScrollBar.vertical: ScrollBar {
                policy: ScrollBar.AlwaysOff
            }
            clip: true
            width: 542
            height: 493
            ListView {
                spacing: 10
                id: itemDetailModelShiftInfo
                x: 8
                y: 306
                model: itemDetailsShiftData.model
                delegate: ItemDelegate {

                    Rectangle {
                        id: itemrectangleShiftInfo
                        height: 50
                        width: 540
                        color: "#4F5D75"
                        radius: 5
                        clip: true

                        Text {
                            x: 65
                            y: 8
                            id: itemIDShiftInfo
                            text: model.EMPLOYEE_ID
                            color: "white"
                            font.pixelSize: 19
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignVCenter
                        }
                        Text {
                            x: 135
                            y: 8
                            id: itemNameShiftInfo
                            text: model.NAME
                            color: "white"
                            font.pixelSize: 19
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                        }

                        Image {
                            source: "UI/owner/edit-regular.png"
                            x: 420
                            y: 8
                            width: 28
                            height: 30
                            MouseArea {
                                hoverEnabled: true
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    Style.sno = model.EMPLOYEE_ID
                                    Style.name = model.NAME
                                    Style.age = model.AGE
                                    Style.dateJoined = model.DATEJOINED
                                    Style.monday = model.MONDAY
                                    Style.tuesday = model.TUESDAY
                                    Style.wednesday = model.WEDNESDAY
                                    Style.thursday = model.THURSDAY
                                    Style.friday = model.FRIDAY
                                    Style.saturday = model.SATURDAY
                                    Style.sunday = model.SUNDAY
                                    setQMLSources("owner_ShiftData_edit.qml")
                                }
                            }
                        }

                        Image {
                            source: "UI/owner/trash-solid.png"
                            x: 485
                            y: 8
                            width: 28
                            height: 30
                            MouseArea {
                                hoverEnabled: true
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    Style.deleteShift_data = model.EMPLOYEE_ID
                                    deleteconfirmSiftData.open()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
