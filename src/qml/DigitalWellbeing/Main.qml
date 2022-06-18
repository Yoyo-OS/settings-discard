import QtQuick 2.4
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import FishUI 1.0 as FishUI
import Yoyo.Settings 1.0
import "utils.js" as U
import "../"

ItemPage {
    id: digitalWellbeingPage
    headerTitle: qsTr("Digital Wellbeing")

    property string perAppStatDaily_: digitalWellbeing.perAppStatDaily
    readonly property int totalTime: digitalWellbeing.totalTime

    onTotalTimeChanged: {
        valueAnimation.restart()
    }

    function update() {
            sortedByFreqModel.clear()
            sortedByTimeModel.clear()
            let records = JSON.parse(digitalWellbeing.perAppStatDaily)
            records.forEach(record => sortedByTimeModel.append({
                                                                   "name": record.name,
                                                                   "icon": record.icon,
                                                                   "stat": U.getTimeString(
                                                                               record.time),
                                                                   "time": record.time
                                                               }))
            records.sort((a, b) => b.freq - a.freq)
            records.forEach(record => sortedByFreqModel.append({
                                                                   "name": record.name,
                                                                   "icon": record.icon,
                                                                   "stat": record.freq + ' '+qsTr('times'),
                                                                   "time": record.time
                                                               }))
    }
    onPerAppStatDaily_Changed: update()

    ListModel {
        id: sortedByTimeModel
    }

    ListModel {
        id: sortedByFreqModel
    }

    DigitalWellbeing {
        id: digitalWellbeing

        Component.onCompleted: {
            digitalWellbeingBackground.value = digitalWellbeing.totalTime
        }
    }
    Scrollable {
        anchors.fill: parent
        contentHeight: layout.implicitHeight

        ColumnLayout {
            id: layout
            anchors.fill: parent
            spacing: FishUI.Units.largeSpacing * 2
            RoundedItem {
                Label {
                    text: qsTr("Screen time usage")
                    color: FishUI.Theme.disabledTextColor
                }

                ColumnLayout {
                    Label {
                        id: percentLabel
                        text: digitalWellbeing.time
                        font.pointSize: 30
                    }

                    DigitalWellbeingItem {
                        id: digitalWellbeingBackground
                        Layout.fillWidth: true
                        radius: 8
                        height: 26
                    }
                }
                ColumnLayout {
                    TabBar {
                        Layout.fillWidth: true
                        currentIndex: 0
                        onCurrentIndexChanged: list.listmodel
                                               = currentIndex ? sortedByFreqModel : sortedByTimeModel

                        TabButton {
                            text: qsTr("Time")
                        }

                        TabButton {
                            text: qsTr("Frequency")
                        }
                    }
                    UsageRanking {
                        id: list
                        totalTime: digitalWellbeing.totalTime
                        listmodel: sortedByTimeModel
                        Layout.fillWidth: true
                    }
                }
            }
        }
        Item {
            Layout.fillHeight: true
        }
    }

}
