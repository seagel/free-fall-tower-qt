import QtQuick 2.0
import "properties.js" as Constants

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
            source: Constants.source("football")
            text: Constants.text("football")
            onClicked:{
                root.footballClicked();
            }
        }
        Ball {
            id:golfBall
            source: Constants.source("golfball")
            text: Constants.text("golfball")
            onClicked:{
                root.golfballClicked();
            }
        }
        Ball {
            id:ironBall
            source: Constants.source("ironball")
            text: Constants.text("ironball")
            onClicked:{
                root.ironballClicked();
            }
        }
        Ball {
            id:cottonBall
            source: Constants.source("cottonball")
            text: Constants.text("cottonball")
            onClicked:{
                root.cottonballClicked();
            }
        }
    }



}
