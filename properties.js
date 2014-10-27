.pragma library

var monkeyTreeSource = "images/NewMonkeyTree.png";
var monkeyTailSource = "images/NewMonkeyTail.png";
var monkeySource = "images/NewMonkey.png";//"images/Monkey2.png"
var weighingMachineSource = "images/scale2.png";
var rulerSource = "images/Ruler.png";

function source(ballId) {
    return "images/" + ballId + ".png"
}

function text(ballId) {
    return ballId.toUpperCase();
}

