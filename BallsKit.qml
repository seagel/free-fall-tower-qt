import QtQuick 2.0
import "Constants.js" as Constants

Item {
    id: root
    width: 100
    height: 100

    signal footballClicked;
    signal golfballClicked;
    signal ironballClicked;
    signal cottonballClicked;

    Grid{
        id: grid
        rows: 2; columns: 2; spacing: 4
        Ball {
            id:footBall
            source: Constants.footBallSource
            text: Constants.footBallText
            onClicked:{
                root.footballClicked();
            }
        }
        Ball {
            id:golfBall
            source: Constants.golfBallSource
            text: Constants.golfBallText
            onClicked:{
                root.golfballClicked();
            }
        }
        Ball {
            id:ironBall
            source: Constants.ironBallSource
            text: Constants.ironBallText
            onClicked:{
                root.ironballClicked();
            }
        }
        Ball {
            id:cottonBall
            source: Constants.cottonBallSource
            text: Constants.cottonBallText
            onClicked:{
                root.cottonballClicked();
            }
        }
    }


}
