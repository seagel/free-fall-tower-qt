import QtQuick 2.0

Image{
    id: ball
    width: 30
    height: 30
    property int weight: 100
    property int timeTaken:0
    property string text:"ball"
    signal clicked

    onWeightChanged: {
        ball.width=30*weight/100;
        ball.height=30*weight/100;
    }

    MouseArea{
        anchors.fill: parent
        onClicked: ball.clicked();
    }
}
