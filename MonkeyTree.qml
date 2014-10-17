import QtQuick 2.2
Rectangle {
    id:root
    property int totalMonkeyHeight:monkeyTail.height+tree.height+monkey.height
    property alias monkeyX: monkey.x
    property alias monkeyY: monkey.y
    height: parent.height
    width: parent.width
    property alias ballContainer: ballContainer
    property int currentHeight: (15/(parent.height *.78))*ballContainer.height
    clip:true

    border.color: "black"
    Image{
        id:tree
        width: parent.width
        height: parent.height * .1
        anchors.top: parent.top
        source: "images/Tree.jpg"
    }
    Image {
        id: monkeyTail
        width: parent.width
        anchors.top: tree.bottom
        source: "images/MonkeyTail.jpg"
        height: monkey.y - tree.height
    }
    Image {
        id: monkey
        y:tree.height+10
        height: parent.height * .1
        anchors.left:parent.left
        anchors.right:parent.right
        source: "images/Monkey.jpg"

        MouseArea{
            id:dragMonkey
            anchors.fill: parent
            drag.target: parent
            drag.maximumY: root.height-parent.height
            drag.minimumY:tree.height
        }
    }
    BallContainer{
        id: ballContainer
        anchors.bottom: parent.bottom
        anchors.top: monkey.bottom
        width: parent.width
        color:"#49BAB6"
    }

}
