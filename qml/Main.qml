#Main.qml
import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts

import QWindowKit 1.0

Window {
    id: window
    width: 800
    height: 600
    color: darkStyle.windowBackgroundColor
    title: qsTr("CompressFactory")
    Component.onCompleted: {
        windowAgent.setup(window)
        window.visible = true
    }

    QtObject {
        id: lightStyle
    }

    QtObject {
        id: darkStyle
        readonly property color windowBackgroundColor: "#1E1E1E"
    }

    WindowAgent {
        id: windowAgent
    }

    Rectangle {
        id: titleBar
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        height: 32
        color: window.active ? "#3C3C3C" : "#505050"
        Component.onCompleted: windowAgent.setTitleBar(titleBar)

        Text {
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 10
            }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: window.title
            font.pixelSize: 14
            color: "#ECECEC"
        }
    }
    SideTabBar{
        id: sideTabBar
        anchors.top: titleBar.bottom
        state: "collapsed"
    }
    StackLayout{
        z:-1
        width: parent.width
        anchors.top: titleBar.bottom
        anchors.bottom: parent.bottom
        currentIndex: sideTabBar.currentIndex
        Rectangle {
            anchors{
                top: titleBar.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            color: "lightgray"

            // 打开菜单按钮
            Button {
                text: qsTr("expand/collapsed")
                anchors.centerIn: parent
                onClicked: {
                    if(sideTabBar.state === "collapsed"){
                        sideTabBar.state = "expanded"
                    }
                    else{
                        sideTabBar.state = "collapsed"
                    }
                }
            }
        }
        Rectangle {
            anchors{
                top: titleBar.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            color: "#8ecae6"
            Button {
                text: qsTr("expand/collapsed")
                anchors.centerIn: parent
                onClicked: {
                    if(sideTabBar.state === "collapsed"){
                        sideTabBar.state = "expanded"
                    }
                    else{
                        sideTabBar.state = "collapsed"
                    }
                }
            }
        }
        Rectangle {
            anchors{
                top: titleBar.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            color: "#a3b18a"
        }

    }



}