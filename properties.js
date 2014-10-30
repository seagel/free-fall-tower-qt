.pragma library

var monkeyTreeSource = "images/monkeyTree.png";
var monkeyTailSource = "images/monkeyTail.png";
var monkeySource = "images/monkey.png";
var bubble = "images/bubble.png"
var weighingMachineSource = "images/scale.png";
var rulerSource = "images/ruler.png";
var ballClickErrorMessage = "Ball cannot be replaced when experiment is in progress";
var weightMeasureUnit = "kg";

function source(ballId) {
    return "images/" + ballId + ".png"
}

function text(ballId) {
    return ballId.toUpperCase();
}

