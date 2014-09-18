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

    GridView {
        id: objects_grid
        x: 25
        y: 109
        width: 112
        height: 85
        model : Qt.createComponent("objects.qml").createObject(null);
//        Text  {
//            anchors.bottom: parent.top
//            font.weight: Font.Bold
//            font.underline: true

//            text : "Objects"
//        }
        delegate: Item {
            x: 5
            height: 50
            Column {
                spacing: 5
                Rectangle {
                    width: 40
                    height: 40
                    Image {
                     width: init_width
                     height : init_height
                     source : image
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
