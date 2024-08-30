import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: sideTabBar
    width: 60 // 初始宽度，显示一小部分
    height: parent.height - 32
    color: "#F3F3F3"

    property int currentIndex: 0

    // 菜单项
    ColumnLayout {
        id: tabBarLayout
        anchors.fill: parent
        spacing: 10
        Layout.fillWidth: true
        // Layout.preferredWidth: parent.width*0.4
        Layout.fillHeight: true

        ArrowButton {
            id: arrowButton
            width: parent.width
            onClicked: {
                console.log("Arrow Clicked")
                if(sideTabBar.state === "collapsed"){
                    sideTabBar.state = "expanded"
                }
                else{
                    sideTabBar.state = "collapsed"
                }
            }
        }

        NavButton{
            id: videoButton
            refIndex: 0
            imageSourceUnchecked: "qrc:/icons/unchecked/file-video.svg"
            imageSourceChecked: "qrc:/icons/checked/file-video.svg"
            text: qsTr("Video")
            onClicked: {
                sideTabBar.currentIndex = 0
            }
        }

        NavButton{
            id: audioButton
            refIndex: 1
            imageSourceUnchecked: "qrc:/icons/unchecked/file-audio.svg"
            imageSourceChecked: "qrc:/icons/checked/file-audio.svg"
            text: qsTr("Audio")
            onClicked: {
                sideTabBar.currentIndex = 1
            }
        }

        NavButton{
            id: toolButton
            refIndex: 2
            imageSourceUnchecked: "qrc:/icons/unchecked/wrench.svg"
            imageSourceChecked: "qrc:/icons/checked/wrench.svg"
            text: qsTr("Tools")
            onClicked: {
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
            StateChangeScript {
                script: {
                    videoButton.acrossWidth("collapsed")
                    audioButton.acrossWidth("collapsed")
                    toolButton.acrossWidth("collapsed")
                }
            }
        },
        State {
            name: "expanded"

            StateChangeScript {
                script: {
                    videoButton.acrossWidth("expanded")
                    audioButton.acrossWidth("expanded")
                    toolButton.acrossWidth("expanded")
                }
            }
        }
    ]

    transitions: [
        Transition {
            from: "collapsed"
            to: "expanded"
            ParallelAnimation{
                NumberAnimation {
                    target: sideTabBar
                    property: "width"
                    from: 60
                    to: 150
                    duration: 200
                }
                NumberAnimation {
                    target: arrowButton
                    property: "width"
                    from: 60
                    to: 150
                    duration: 200
                }
                NumberAnimation {
                    target: videoButton
                    property: "width"
                    from: 60
                    to: 150
                    duration: 200
                }
                NumberAnimation {
                    target: audioButton
                    property: "width"
                    from: 60
                    to: 150
                    duration: 200
                }
                NumberAnimation {
                    target: toolButton
                    property: "width"
                    from: 60
                    to: 150
                    duration: 200
                }
            }
        },

        Transition {
            from: "expanded"
            to:"collapsed"
            ParallelAnimation{
                NumberAnimation {
                    target: sideTabBar
                    property: "width"
                    from: 150
                    to: 60
                    duration: 200
                }
                NumberAnimation {
                    target: arrowButton
                    property: "width"
                    from: 150
                    to: 60
                    duration: 200
                }
                NumberAnimation {
                    target: videoButton
                    property: "width"
                    from: 150
                    to: 60
                    duration: 200
                }
                NumberAnimation {
                    target: audioButton
                    property: "width"
                    from: 150
                    to: 60
                    duration: 200
                }
                NumberAnimation {
                    target: toolButton
                    property: "width"
                    from: 150
                    to: 60
                    duration: 200
                }
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