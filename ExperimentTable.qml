import QtQuick 2.0
import QtQuick.Controls 1.2

Rectangle {
    id: resultsTable
    property alias results : results

    ListModel {
       id: results
    }

    TableView {
        width: parent.width
        height: parent.height
        TableViewColumn{ role: "objects"  ; title: "Object" ; width: parent.width*.20 }
        TableViewColumn{ role: "mass" ; title: "Mass (g)" ; width: parent.width*.20 }
        TableViewColumn{ role: "height" ; title: "Height (m)" ; width: parent.width*.20 }
        TableViewColumn{ role: "time_taken" ; title: "Time (ms)" ; width: parent.width*.20 }
        TableViewColumn{ role: "medium" ; title: "Medium" ; width: parent.width*.20 }

       model: results
    }

}
