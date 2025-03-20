import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Item {
    property color lightBlack: "#1E1E1E"
    property color lightGreen: "#34C759"
    property string fontFamily: "sans-serif"

    Rectangle {
        anchors.fill: parent
        color: "black"

        Rectangle {
            id: timerContainer
            height: parent.height
            width: 300
            color: lightBlack

            ColumnLayout {
                id: counterContainer
                anchors.centerIn: parent
                anchors.verticalCenterOffset: -20
                spacing: 10
                Text {
                    id: timerLabel
                    Layout.alignment: Qt.AlignHCenter
                    text: "Timer"
                    color: lightGreen
                    font.family: fontFamily
                    font.bold: true
                    font.pixelSize: 40
                }
                Rectangle {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.preferredHeight: 50
                    Layout.preferredWidth: 150
                    color: "black"
                    border.color: "white"
                    radius: 8

                    Text {
                        text: (viewModel != null) ? viewModel.elapsedTime : ""
                        color: "white"
                        anchors.centerIn: parent
                        font.family: fontFamily
                        font.pixelSize: 30
                    }
                }

                Rectangle {
                    id: button
                    Layout.alignment: Qt.AlignHCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    Layout.preferredWidth: 100
                    color: (viewModel
                            != null) ? viewModel.isTimerActive ? "grey" : lightGreen : "grey"
                    radius: 20

                    Text {
                        id: buttonLabel
                        color: "white"
                        font.family: fontFamily
                        font.pixelSize: 30
                        text: (viewModel
                               != null) ? viewModel.isTimerActive ? "Stop" : "Start" : "Invalid"
                        anchors.centerIn: parent
                    }
                    MouseArea {
                        anchors.fill: parent
                        onPressed: {
                            viewModel.toggleTimer()
                        }
                    }
                }
            }
        }
        RowLayout {
            id: usblistLabelContainer
            anchors.verticalCenter: parent
            anchors.left: timerContainer.right
            anchors.leftMargin: 20
            spacing: 8
            Text {
                id: usbDeviceListLabel
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                Layout.preferredWidth: 180
                text: "USB List"
                color: lightGreen
                font.family: fontFamily
                font.bold: true
                font.pixelSize: 40
                wrapMode: Text.Wrap
            }
            Button {
                id: usbListFetchButton
                Layout.alignment: Qt.AlignHCenter
                Layout.fillWidth: true
                Layout.preferredHeight: 40
                Layout.preferredWidth: 140

                background: Rectangle {
                    color: parent.down ? Qt.darker(lightGreen, 1.3) : lightGreen
                    radius: 20
                }

                contentItem: Text {
                    text: "Fetch"
                    color: "white"
                    font.family: fontFamily
                    font.pixelSize: 30
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: {
                    viewModel.fetchUSBDeviceList()
                }
            }
        }

        ListView {
            id: usbListView
            anchors.top: usblistLabelContainer.bottom
            anchors.topMargin: 20
            anchors.left: timerContainer.right
            anchors.leftMargin: 20

            height: 320
            width: parent.width - timerContainer.width
            model: (viewModel != null) ? viewModel.devices : ""
            clip: true
            contentHeight: 400
            spacing: 8

            delegate: Item {
                width: usbListView.view.width

                height: itemContainer.height
                Rectangle {
                    id: itemContainer
                    width: 450
                    height: contentItem.implicitHeight + 20
                    border.color: lightGreen
                    color: lightBlack
                    radius: 10

                    Text {
                        id: contentItem
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        width: parent.width
                        wrapMode: Text.WordWrap
                        anchors.verticalCenter: parent.verticalCenter
                        text: modelData
                        color: "white"
                        font.family: fontFamily
                        font.pixelSize: 20
                    }
                }
            }
        }
        // ColumnLayout {
        //     anchors.verticalCenter: parent
        //     anchors.left: timerContainer.left
        //     spacing: 10

        //     // Button {
        //     //     text: "Fetch USB Devices"
        //     //     onClicked: {
        //     //         viewModel.fetchUSBDeviceList()
        //     //     }
        //     // }
        //     ListView {
        //         Layout.fillHeight: true
        //         Layout.fillWidth: true
        //         Layout.preferredHeight: 100
        //         Layout.preferredWidth: 100

        //         model: (viewModel != null) ? viewModel.devices : ""

        //         delegate: Item {
        //             width: parent.width
        //             height: 40

        //             Text {
        //                 anchors.centerIn: parent
        //                 text: modelData
        //             }
        //         }
        //     }
        // }
    }
}
