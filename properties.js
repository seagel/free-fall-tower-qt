.pragma library

var monkeyTreeSource = "images/NewMonkeyTree.png";
var monkeyTailSource = "images/NewMonkeyTail.png";
var monkeySource = "images/NewMonkey.png";
var bubble = "images/bubble.png"
var weighingMachineSource = "images/scale2.png";
var rulerSource = "images/Ruler.png";
var ballClickErrorMessage = "Ball cannot be replaced when experiment is in progress";

function source(ballId) {
    return "images/" + ballId + ".png"
}

function text(ballId) {
    return ballId.toUpperCase();
}

