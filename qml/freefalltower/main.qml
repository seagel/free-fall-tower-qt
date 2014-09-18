import QtQuick 2.0

Rectangle {
    width: 500
    height: 500

    Text {
        id: status_text
        x: 236
        y: 39
        anchors.horizontalCenter: parent.horizontalCenter
        text: qsTr("Welcome to Freefall tower")
        font.pixelSize: 12
    }
    DropArea {
            id : mass_drop_area
            x: 25; y: 298
            clip: true
            width: 100; height: 37
            //onEntered: maincanvas.state = Qt.new_method(1)
            Rectangle {
                x: 0
                y: 0
                anchors.fill: parent
                opacity: 0.5
                border.color: "red"
                visible: parent.containsDrag
            }
            onDropped: {
                status_text.text = qsTr("You have moved a " + drag.source.objectName)
                mass_edit.currentItem = drag.source
                mass_edit.text = drag.source.objectMass
                //mass_edit.objectChanged()
            }

    }
    TextInput {
        id: mass_text
        x: 25
        y: 444
        text: qsTr("Mass :: ")
        font.pixelSize: 12
    }

    TextEdit {
        id: mass_edit
        x: 88
        y: 441
        width: 80
        height: 20
        text: qsTr("0")
        property Image currentItem
        cursorVisible: true
        textFormat: TextEdit.AutoText
        signal objectChanged()
        Rectangle {
            anchors.fill: parent
            opacity: 0.2
            border.color: "red"
        }
        horizontalAlignment: TextEdit.AlignHCenter
        verticalAlignment: TextEdit.AlignVCenter
        font.pixelSize: 12
        onObjectChanged: {
         currentItem.width += 100
        }
        onTextChanged: {
            if (currentItem != null){
                if (currentItem.objectMass != 0){
                    var scaleRatio = text / currentItem.objectMass
                    currentItem.objectMass = text
                    currentItem.objectWidth = scaleRatio * currentItem.objectWidth
                    currentItem.objectHeight = scaleRatio * currentItem.objectHeight

                }
            }
        }

    }


    Image {
        id: scale_object
        x: 25
        y: 335
        width: 100
        height: 100
        source: "scale.png"
    }
    GridView {
        id: objects_grid
        x: 25
        y: 109
        width: 112
        height: 85
        model : Qt.createComponent("objects.qml").createObject(null);
        delegate: Item {
            x: 5
            height: 50
            Column {
                spacing: 5
                Rectangle {
                    width: 40
                    height: 40

                    Image {

                     id : object_image
                     width: init_width
                     height : init_height
                     source : image
                     Drag.source : object_image
                     Drag.active: dragArea.drag.active


                     property string objectName: name
                     property real objectMass : mass
                     property real objectWidth : width
                     property real objectHeight : height
                     signal scale(var changed_mass)
                     MouseArea  {
                       id: dragArea
                       anchors.fill: parent
                       drag.target: parent
                       onClicked:  {
                           status_text.text = "You have selected a " + name
                       }
                       onReleased: {
                           parent.Drag.drop()
                       }
                     }
                     onObjectWidthChanged: {
                      width = objectWidth
                     }
                     onObjectHeightChanged:  {
                      height = objectHeight
                     }
                     onObjectMassChanged:  {
                        mass = objectMass
                     }


                    }
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    x: 5
                    text: name
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
        cellHeight: 70
        cellWidth: 70
    }



}
