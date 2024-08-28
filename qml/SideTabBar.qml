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

    property int currentIndex: 0

    // 菜单项
    ColumnLayout {
        id: tabBarLayout
        anchors.fill: parent
        spacing: 10
        Layout.fillWidth: true
        Layout.preferredWidth: parent.width*0.4
        Layout.fillHeight: true
        NavButton{
            id: videoButton
            refIndex: 0
            imageSourceUnchecked: "qrc:/icons/unchecked/file-video.svg"
            imageSourceChecked: "qrc:/icons/checked/file-video.svg"
            text: "Video"
            onClicked: {
                console.log("Video Clicked")
                sideTabBar.currentIndex = 0
            }
        }

        NavButton{
            id: audioButton
            refIndex: 1
            imageSourceUnchecked: "qrc:/icons/unchecked/file-audio.svg"
            imageSourceChecked: "qrc:/icons/checked/file-audio.svg"
            text: "Audio"
            onClicked: {
                console.log("Audio Clicked")
                sideTabBar.currentIndex = 1
            }
        }

        NavButton{
            id: toolButton
            refIndex: 2
            imageSourceUnchecked: "qrc:/icons/unchecked/wrench.svg"
            imageSourceChecked: "qrc:/icons/checked/wrench.svg"
            text: "Tools"
            onClicked: {
                console.log("Tool Clicked")
                sideTabBar.currentIndex = 2
            }
        }
        Component.onCompleted:{
            videoButton.toggleSelection(currentIndex)
            audioButton.toggleSelection(currentIndex)
            toolButton.toggleSelection(currentIndex)
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

    Connections {
       target: sideTabBar
       function onCurrentIndexChanged() {
           videoButton.toggleSelection(currentIndex)
           audioButton.toggleSelection(currentIndex)
           toolButton.toggleSelection(currentIndex)
       }
    }
}