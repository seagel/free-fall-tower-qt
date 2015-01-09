import QtQuick 2.0
import "properties.js" as Constants


Image{
    id: bubble
    width: 220
    height: 40
    source:Constants.bubble
    z: 20
    opacity: 0.55

    property alias text: text.text
    signal clicked

    MouseArea{
        anchors.fill: parent
        onClicked: hide();
    }

    Text {
        id: text
        anchors.centerIn: parent
        wrapMode: Text.WordWrap
        anchors.horizontalCenter: scale.horizontalCenter
        font.bold: true
        font.pointSize: 12
        color : "black"
        text: "Let's try"
    }

    function hide(){
        visible = false;
    }
    function show(){
        visible = true;
    }
}
