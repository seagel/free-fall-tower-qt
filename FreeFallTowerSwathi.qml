import QtQuick 2.2
import QtQuick.Controls 1.2
import "Constants.js" as Constants

Rectangle {
    width: 850
    height: 1000
    id: root
    color: "#49BAB6"
    property int slow: 4000
    property int medium: 1000
    property int fast: 500
    property bool isVacuum: true

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
                console.log("Ball Text: "+ scaleLeft.ball.text);

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
                scaleLeft.ball.source = Constants.footBallSource;
                scaleLeft.ball.visible = true;
                scaleLeft.ball.text = Constants.footBallText;
                scaleLeft.ballText = Constants.footBallText;
            }
            onIronballClicked:{
                scaleLeft.ball.source = Constants.ironBallSource;
                scaleLeft.ball.visible = true;
                scaleLeft.ball.text = Constants.ironBallText;
                scaleLeft.ballText = Constants.ironBallText;
            }
            onCottonballClicked:{
                scaleLeft.ball.source = Constants.cottonBallSource;
                scaleLeft.ball.visible = true;
                scaleLeft.ball.text = Constants.cottonBallText;
                scaleLeft.ballText = Constants.cottonBallText;

            }
            onGolfballClicked:{
                scaleLeft.ball.source = Constants.golfBallSource;
                scaleLeft.ball.visible = true;
                scaleLeft.ball.text = Constants.golfBallText;
                scaleLeft.ballText = Constants.golfBallText;

            }
        }

        Rectangle{
            id:freeFall
            width: 400
            height: parent.height
            anchors.centerIn: parent
            //anchors.left:scaleLeft.right
            //anchors.right:scaleRight.left
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

                    /** TODO1 add this group box for radio button **/
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
                        anchors.bottom:parent.bottom //TODO1: environment check
                        visible: false

                        onClicked: {

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
                            freeFall.leftBallContainer.duration = 0;
                            freeFall.rightBallContainer.duration = 0;
                            freeFall.leftBallContainer.ball.y = 0;
                            freeFall.rightBallContainer.ball.y = 0;
                            freeFall.leftBallContainer.ball.visible = false;
                            freeFall.rightBallContainer.ball.visible = false;
                            freeFall.leftBallContainer.ball.weight = 0;
                            freeFall.rightBallContainer.ball.weight = 0;
                            btnReset.visible = false;
                            //btnDrop.visible = true
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
                color:"blue"
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
                scaleRight.ball.source = Constants.footBallSource;
                scaleRight.ball.visible = true;
                scaleRight.ballText = Constants.footBallText;
                scaleRight.ball.text = Constants.footBallText;
            }
            onIronballClicked:{
                scaleRight.ball.source = Constants.ironBallSource;
                scaleRight.ball.visible = true;
                scaleRight.ballText = Constants.ironBallText;
                scaleRight.ball.text = Constants.ironBallText;
            }
            onCottonballClicked:{
                scaleRight.ball.source = Constants.cottonBallSource;
                scaleRight.ball.visible = true;
                scaleRight.ballText = Constants.cottonBallText;
                scaleRight.ball.text = Constants.cottonBallText;

            }
            onGolfballClicked:{
                scaleRight.ball.source = Constants.golfBallSource;
                scaleRight.ball.visible = true;
                scaleRight.ballText = Constants.golfBallText;
                scaleRight.ball.text = Constants.golfBallText;
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

        /*gradient: Gradient{
            GradientStop{position: 0.0 ; color: "#C2E8EF"}
            GradientStop{position: 1.0; color: "#52D1E8"}
        }

        MouseArea{
            anchors.fill: parent
            onClicked:{
                table.results.append({objects:"golf ball", mass: 200, time_taken: 200, medium: "Vacuum"})

                //.append({ objects: current_drop_item.objectName ,
                //                                                   mass: current_drop_item.objectMass,
                //                                                   time_taken: Math.sqrt(2 * simulate_button.currentLayer * height_per_layer / 9.8).toFixed(2),
                //                                                   medium: "Vaccum" })
            }
        }*/

        ExperimentTable{
            id: table
            anchors.centerIn: parent
            anchors { fill: parent; topMargin: 6; bottomMargin: 6; leftMargin: 6; rightMargin: 6 }
        }

    }
}
