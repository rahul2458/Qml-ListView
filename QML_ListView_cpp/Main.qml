import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import Qt.labs.platform

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("List View with cpp")

    // custom property
    property var mylist : []
    property string folderpath: ""
     property var imageNameFilters : ["All image formats (*.png; *.jpg; *.bmp; *.gif; *.jpeg"];

    Connections {
        target: FileManageBackend

    }

    Rectangle {
        id: mainBg
        anchors.fill: parent
        color: "#fff"

        Rectangle {
            id: listRect
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            height: 80
            width: 350
            border.color: "blue"
            border.width: 1
            radius: 10
            clip: true

            RowLayout {
                anchors.fill: parent
                anchors.margins: 10
                ListView {
                    id: mList
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    orientation: ListView.Horizontal
                    spacing: 3
                    model: mylist
                    clip: true

                    delegate: Rectangle {
                        height: 60
                        width: 60
                        //color: "#06FFFFFF"
                        radius: 3
                        //border.color: mList.currentIndex == index ? "blue" : "transparent"
                        color: mList.currentIndex == index ? "gray" : "transparent"
                        border.color: mList.currentIndex == index ? "black" : "transparent"

                        Image {
                            source: modelData
                            anchors.fill: parent
                            anchors.margins: 5
                            antialiasing: true
                            fillMode: Image.PreserveAspectFit

                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                console.log(index, modelData)
                                mList.currentIndex = index
                                mainImage.source = modelData
                                mainImage.playing = true

                            }
                        }
                    }


                }
            }


        }

        // Text
        Text {
            id: myText
            anchors.left: listRect.right
            anchors.verticalCenter: listRect.verticalCenter
            color: "blue"


        }

        ColumnLayout {
            anchors.right: listRect.left
            anchors.rightMargin: 10
            anchors.bottom: listRect.bottom
            height: listRect.height
            width: 120
            spacing: 0
            Rectangle {
                id: myBtnRect
                height: 30
                width: 120
                color: "gray"
                radius: height

                Text {
                    id: btnText
                    anchors.centerIn: parent
                    font.pixelSize: 15
                    color: "white"
                    text: "Load images"
                }

                MouseArea {
                    id: btnMouse
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor

                    //color

                    onEntered: {
                        myBtnRect.color = "darkgray"
                    }

                    onExited: {
                        myBtnRect.color = "gray"
                    }

                    onClicked: {
                        filesOpen.open()
                    }
                }
            }



            Rectangle {
                id: removeButton
                height: 30
                width: 120
                color: "gray"
                radius: height
                Text {
                    anchors.centerIn: parent
                    color: "#fff"
                    font.pixelSize: 15
                    text: "Remove!"
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor

                    onEntered: {
                        removeButton.color = "darkgray"
                    }

                    onExited: {
                        removeButton.color = "gray"
                    }
                    onClicked: {
                        mylist = FileManageBackend.removeItems(mList.currentIndex)
                        myText.text = " Total images: " + mylist.length
                        mainImage.source = mylist[0]
                    }
                }
            }
        }




          AnimatedImage {
            id: mainImage
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            fillMode: Image.PreserveAspectFit
            anchors.leftMargin: 100
            anchors.rightMargin: 100
            anchors.topMargin: 100
            anchors.bottomMargin: 100
        }


        //File folder open
        FileDialog {
            id: filesOpen
            folder: folderpath
            fileMode: FileDialog.ReadOnly
            nameFilters: imageNameFilters
            title: "Select the image"
            onAccepted: {
                console.log(folderpath = folder)
                mylist = FileManageBackend.fileSearch(folderpath = folder)
                myText.text = " Total images: " + mylist.length
                mainImage.source = mylist[0]
            }

        }

    }

}
