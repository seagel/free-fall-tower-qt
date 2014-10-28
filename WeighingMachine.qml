import QtQuick 2.0
import QtQuick.Controls 1.2

Rectangle{
    id: root
    width: 200
    height: 300
    color: "#4abbb4"
    property alias text: weightText.text
    signal onSlideValueChanged;
    property alias slideValue: slider.value
    property alias ball:  ball
    property alias ballText: labelText.text
    property alias anim: anim
    signal ballClicked

    Ball{
        id: ball
        x: scale.x + (scale.width-width)/2
        y: 0
        source:""
        anchors.bottom: scale.top
        visible: false
        weight: 0

        onClicked: {
            root.ballClicked();
        }
    }

    ParallelAnimation{
        id: anim
        NumberAnimation{
            target: ball
            properties:x
            to: 242
            duration: 200
        }
        NumberAnimation{
            target: ball
            properties:y
            to: 52
            duration: 200
        }
    }

    Image {
        id: scale
        y:30
        source: "images/scale2.png"
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Text {
    id: weightText
    anchors.horizontalCenter: scale.horizontalCenter
    y:scale.y + scale.height - 50
    font.bold: true
    font.pointSize: 25
    color : "#FCEA5D"
    text: "0.0"
    }

    Slider{
        id: slider
        anchors.top: scale.bottom
        anchors.margins: 5
        anchors.bottom: labelText.top

        maximumValue: 500
        stepSize: 50
        minimumValue: 100

        onValueChanged: {
            ball.weight = value;
            weightText.text = value
            root.onSlideValueChanged();
        }
    }

    Text {
        id: labelText
        anchors.top: slider.Bottom
        anchors.bottom: parent.bottom
        anchors.margins: 10
        text: ""
    }

    function reset(){
        slider.value = 100;
        ball.reset();
    }


}
