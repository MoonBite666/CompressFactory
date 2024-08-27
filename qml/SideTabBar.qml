import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import "Component"


Rectangle {
    id: sideTabBar
    width: 50 // 初始宽度，显示一小部分
    height: parent.height - 32
    color: "gray"

    // 菜单项
    ColumnLayout {
        anchors.fill: parent
        spacing: 10
        Layout.fillWidth: true
        Layout.preferredWidth: parent.width*0.4
        Layout.fillHeight: true
        NavButton{
            imageSourceUnchecked: "qrc:/icons/unchecked/file-video.svg"
            imageSourceChecked: "qrc:/icons/checked/file-video.svg"
            text: "Video"
            baseColor: "gray"
        }

        NavButton{
            imageSourceUnchecked: "qrc:/icons/unchecked/file-audio.svg"
            imageSourceChecked: "qrc:/icons/checked/file-audio.svg"
            text: "Audio"
            baseColor: "gray"
        }

        NavButton{
            imageSourceUnchecked: "qrc:/icons/unchecked/wrench.svg"
            imageSourceChecked: "qrc:/icons/checked/wrench.svg"
            text: "Tools"
            baseColor: "gray"
        }
    }

    // 状态和动画
    states: [
        State {
            name: "collapsed"
            PropertyChanges {
                target: sideTabBar
                width: 50
            }
        },
        State {
            name: "expanded"
            PropertyChanges {
                target: sideTabBar
                width: 200
            }
        }
    ]

    transitions: [
        Transition {
            from: "collapsed"
            to: "expanded"
            reversible: true
            NumberAnimation {
                target: sideTabBar
                property: "width"
                duration: 200
            }
        }
    ]

    // Connections{
    //     target: sideTabBar
    //     onStateChanged: {
    //         if(sideTabBar.state === "collapsed") {
    //
    //         }
    //     }
    // }
}