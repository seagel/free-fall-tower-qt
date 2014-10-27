import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1
import "properties.js" as Constants
import "event_handler.js" as EventHandler

ApplicationWindow {
    id: root
    visible: true
    width: 850
    height: 1000
    title: qsTr("Free Fall Tower")
    property bool isVacuum: true
    property int slow: 4000
    property int medium: 1000
    property int fast: 500
    color: "#49BAB6"
    property bool inProgress: false



    menuBar: MenuBar {
        Menu {
            title: qsTr("File")
            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
        }
    }

    onInProgressChanged: {
        if(inProgress){
            leftKit.enabled = false;
            rightKit.enabled = false;
            scaleLeft.enabled = false;
            scaleRight.enabled = false;

        } else {
            leftKit.enabled = true;
            rightKit.enabled = true;
            scaleLeft.enabled = true;
            scaleRight.enabled = true;
        }

    }

    Rectangle {
        width: parent.width
        height: parent.height

        Rectangle{
            id: top
            height: root.height*0.7
            width: root.width
            color: root.color

            WeighingMachine {
                id: scaleLeft
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.leftMargin: 8

                onBallClicked: {
                    freeFall.leftBallContainer.ballSource = scaleLeft.ball.source;
                    freeFall.leftBallContainer.ballWeight = scaleLeft.ball.weight;
                    freeFall.leftBallContainer.ballVisible = scaleLeft.ball.visible;
                    freeFall.leftBallContainer.ball.text = scaleLeft.ball.text;

                    scaleLeft.ball.visible = false;
                    freeFall.leftBallContainer.duration = root.medium;
                    freeFall.scale.spaceAboveScale.dropButton.visible = true
                }
            }

            BallsKit{
                id:leftKit
                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.top: parent.top
                anchors.topMargin: 15

                //TODO: Change this logic to STATE into WeighingMachine
                onFootballClicked: {
                    EventHandler.onBallClicked(scaleLeft, "football")
                }
                onIronballClicked:{
                    EventHandler.onBallClicked(scaleLeft, "ironball")
                }
                onCottonballClicked:{
                    EventHandler.onBallClicked(scaleLeft, "cottonball")

                }
                onGolfballClicked:{
                    EventHandler.onBallClicked(scaleLeft, "golfball")
                }
            }

            Rectangle{
                id:freeFall
                width: 400
                height: parent.height
                anchors.centerIn: parent
                color: root.color
                property alias leftBallContainer: leftTree.ballContainer
                property alias rightBallContainer: rightTree.ballContainer
                property alias scale : scale

                MonkeyTree{
                    id:leftTree
                    height: parent.height
                    width: parent.width*.35
                    anchors.right : scale.left
                    anchors.left: parent.left
                    color:root.color
                }

                Rectangle{
                    id:scale
                    width: 150
                    height: parent.height
                    anchors.centerIn: parent
                    property alias spaceAboveScale : spaceAboveScale
                    Rectangle{
                        id:spaceAboveScale
                        width: parent.width
                        height: parent.height * .22
                        anchors.top: parent.top
                        color:"#49BAB6"
                        property alias dropButton : btnDrop

                        GroupBox {
                            id: mediumBox
                            title: "Medium:"
                            anchors.horizontalCenter: parent.horizontalCenter

                            Column {
                                ExclusiveGroup { id: tabPositionGroup }
                                spacing: 10

                                RadioButton {
                                    text: "Vacuum"
                                    checked: true
                                    exclusiveGroup: tabPositionGroup
                                    onClicked: {
                                        isVacuum = true
                                    }
                                }
                                RadioButton {
                                    text: "Air"
                                    exclusiveGroup: tabPositionGroup
                                    onClicked: {
                                        isVacuum = false
                                    }
                                }
                            }
                        }

                        Button2{
                            id: btnDrop
                            text: "Drop"
                            anchors.bottom:parent.bottom
                            visible: false

                            onClicked: {
                                inProgress = true;

                                if(!isVacuum){
                                    var exp = Math.exp((leftTree.currentHeight * 240)/leftTree.ballContainer.ball.weight);
                                    var acosh = Math.log(exp + Math.sqrt(exp * exp -1));
                                    leftTree.ballContainer.ball.timeTaken = 1000 *Math.sqrt(leftTree.ballContainer.ball.weight/(9.8 * 240))*acosh;
                                    if(rightTree.ballContainer.ball.weight != 0){
                                        exp = Math.exp((rightTree.currentHeight * 240)/rightTree.ballContainer.ball.weight);
                                        acosh = Math.log(exp + Math.sqrt(exp * exp -1));
                                        rightTree.ballContainer.ball.timeTaken = 1000 * Math.sqrt(rightTree.ballContainer.ball.weight/(9.8 * 240))*acosh;
                                        //rightTree.ballContainer.ball.timeTaken = Math.sqrt(200000 * rightTree.currentHeight / (9.8*rightTree.ballContainer.ball.weight)).toFixed(2)
                                    }
                                    freeFall.leftBallContainer.medium = "Air"
                                    freeFall.rightBallContainer.medium = "Air"
                                }
                                else{
                                    leftTree.ballContainer.ball.timeTaken = (1000 * Math.sqrt((2 * leftTree.currentHeight) / 9.8)).toFixed(2)
                                    rightTree.ballContainer.ball.timeTaken = (1000 * Math.sqrt((2 * rightTree.currentHeight) / 9.8)).toFixed(2)

                                    freeFall.leftBallContainer.medium = "Vaccum"
                                    freeFall.rightBallContainer.medium = "Vaccum"
                                }
                                if(leftTree.ballContainer.ball.timeTaken > rightTree.ballContainer.ball.timeTaken)
                                {
                                    freeFall.leftBallContainer.duration = slow;
                                    freeFall.rightBallContainer.duration = fast;
                                }
                                else if(leftTree.ballContainer.ball.timeTaken < rightTree.ballContainer.ball.timeTaken)
                                {
                                    freeFall.leftBallContainer.duration = fast
                                    freeFall.rightBallContainer.duration = slow
                                }
                                else{
                                    freeFall.leftBallContainer.duration = fast;
                                    freeFall.rightBallContainer.duration = fast;

                                }
                                freeFall.leftBallContainer.duration = leftTree.ballContainer.ball.timeTaken ;
                                freeFall.rightBallContainer.duration = rightTree.ballContainer.ball.timeTaken;

                                freeFall.leftBallContainer.ball.y = freeFall.leftBallContainer.height - freeFall.leftBallContainer.ball.height;
                                freeFall.rightBallContainer.ball.y = freeFall.rightBallContainer.height - freeFall.rightBallContainer.ball.height;

                                btnDrop.visible = false
                                btnReset.visible = true

                                if(leftTree.ballContainer.ballWeight !=0)
                                {
                                    bottom.results.append({objects:freeFall.leftBallContainer.ball.text,height:leftTree.currentHeight, mass: freeFall.leftBallContainer.ball.weight, time_taken: leftTree.ballContainer.ball.timeTaken, medium: freeFall.leftBallContainer.medium })
                                }
                                if(rightTree.ballContainer.ballWeight !=0)
                                {
                                    bottom.results.append({objects:freeFall.rightBallContainer.ball.text,height:rightTree.currentHeight, mass: freeFall.rightBallContainer.ball.weight, time_taken: rightTree.ballContainer.ball.timeTaken, medium: freeFall.rightBallContainer.medium })
                                }
                            }
                        }

                        Button2{
                            id: btnReset
                            text: "Reset"
                            visible: false
                            anchors.bottom:parent.bottom

                            onClicked: {
                                btnReset.visible = false;

                                rightTree.reset();
                                leftTree.reset();
                                scaleRight.reset();
                                scaleLeft.reset();

                                inProgress = false;
                            }
                        }

                    }

                    Image{
                        id:rulerImg
                        source: Constants.rulerSource
                        width: parent.width
                        smooth: true
                        anchors.top:spaceAboveScale.bottom
                        anchors.bottom: parent.bottom
                    }
                }

                MonkeyTree{
                    id:rightTree
                    height: parent.height
                    color:root.color
                    width: parent.width*.35
                    anchors.left : scale.right
                    anchors.right: parent.right
                }

            }

            BallsKit{
                id:rightKit
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: 15

                onFootballClicked: {
                    EventHandler.onBallClicked(scaleRight, "football")
                }
                onIronballClicked:{
                    EventHandler.onBallClicked(scaleRight, "ironball")
                }
                onCottonballClicked:{
                    EventHandler.onBallClicked(scaleRight, "cottonball")

                }
                onGolfballClicked:{
                    EventHandler.onBallClicked(scaleRight, "golfball")
                }

            }

            WeighingMachine{
                id: scaleRight
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.rightMargin: 8

                onBallClicked: {

                    freeFall.rightBallContainer.ballSource = scaleRight.ball.source;
                    freeFall.rightBallContainer.ballWeight = scaleRight.ball.weight;
                    freeFall.rightBallContainer.ballVisible = scaleRight.ball.visible;
                    freeFall.rightBallContainer.ball.text = scaleRight.ball.text

                    freeFall.rightBallContainer.duration = root.medium;
                    scaleRight.ball.visible = false;
                    freeFall.scale.spaceAboveScale.dropButton.visible = true
                }
            }
        }

        Rectangle{
            id: bottom
            anchors.top: top.bottom
            anchors.bottom: parent.bottom
            width: root.width
            height:root.height/2

            property alias results: table.results


            ExperimentTable{
                id: table
                anchors.centerIn: parent
                anchors { fill: parent; topMargin: 6; bottomMargin: 6; leftMargin: 6; rightMargin: 6 }
            }

        }
    }
}
