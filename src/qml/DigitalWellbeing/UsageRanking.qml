import QtQuick 2.15
import QtQuick.Controls 2.15
import Yoyo.Settings 1.0
import "utils.js" as U
import "../"

Column {
    id: list
    property var listmodel: ListModel {}
    topPadding: 5
    bottomPadding: 15
    property int totalTime
    property bool folded: true
    property bool foldable: true
    onImplicitHeightChanged: foldable = foldable || implicitHeight > 250
    onHeightChanged: console.log('usageranking', height, implicitHeight)
    Column {
        height: list.folded ? 200 : implicitHeight
        clip: true
        spacing: 20
        bottomPadding: 26
        Repeater {
            Component.onCompleted: console.log('list', listmodel.count)
            model: listmodel
            delegate: Rectangle {
                width: list.width
                height: 30
                color: "transparent"
                Image {
                    id: appicon
                    source: "image://fromtheme/" + icon
                    height: parent.height
                    width: height
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                }
                Column{
                    spacing: 4
                    Text {
                        text: name
                        anchors.left: appicon.right
                        anchors.leftMargin: 5
                        elide: Text.ElideRight
                    }
                    DigitalWellbeingItem {
                        id: dwg
                        maxvalue: control.totalTime
                        width: list.width - appicon.width
                        value: time
                        radius: 5
                        height: 10
                    }
                }
                Text {
                    id: stattext
                    text: stat
                    font.weight: Font.Thin
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                }
            }
        }
    }
    Button {
        height: 30
        width: list.width
        visible: list.foldable
        text: "More"
        onClicked: {
            list.folded = !list.folded
            console.log('tapped', list.height, list.implicitHeight)
        }
    }
}
